#!/usr/bin/env bash
set -Eeuo pipefail

prompt() {
    local __var_name="$1"
    local __message="$2"
    local __default="${3-}"
    local __answer

    if [[ -n "$__default" ]]; then
        read -r -p "$__message [$__default]: " __answer
        __answer="${__answer:-$__default}"
    else
        read -r -p "$__message: " __answer
    fi

    printf -v "$__var_name" '%s' "$__answer"
}

yes_no() {
    local __message="$1"
    local __default="${2:-y}"
    local __answer
    local __prompt

    case "$__default" in
        y|Y) __prompt="Y/n" ;;
        n|N) __prompt="y/N" ;;
        *)
            echo "Internal error: invalid yes_no default: $__default" >&2
            exit 1
            ;;
    esac

    while true; do
        read -r -p "$__message [$__prompt]: " __answer
        __answer="${__answer:-$__default}"

        case "$__answer" in
            y|Y|yes|YES|Yes) return 0 ;;
            n|N|no|NO|No) return 1 ;;
            *) echo "Please answer y or n." ;;
        esac
    done
}

expand_tilde() {
    local p="$1"

    case "$p" in
        '~') printf '%s\n' "$HOME" ;;
        '~/'*) printf '%s\n' "$HOME/${p#~/}" ;;
        *) printf '%s\n' "$p" ;;
    esac
}

home_to_tilde() {
    local p="$1"

    if [[ "$p" == "$HOME" ]]; then
        printf '~\n'
    elif [[ "$p" == "$HOME"/* ]]; then
        printf '~/%s\n' "${p#"$HOME"/}"
    else
        printf '%s\n' "$p"
    fi
}

choose_default_socket() {
    local candidates=()

    case "$(uname -s)" in
        Darwin)
            candidates+=("$HOME/.bitwarden-ssh-agent.sock")
            candidates+=("$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock")
            ;;
        Linux)
            candidates+=("$HOME/.bitwarden-ssh-agent.sock")
            candidates+=("$HOME/snap/bitwarden/current/.bitwarden-ssh-agent.sock")
            candidates+=("$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock")
            ;;
        *)
            candidates+=("$HOME/.bitwarden-ssh-agent.sock")
            ;;
    esac

    local p

    for p in "${candidates[@]}"; do
        if [[ -S "$p" ]]; then
            home_to_tilde "$p"
            return 0
        fi
    done

    for p in "${candidates[@]}"; do
        if [[ -e "$p" ]]; then
            home_to_tilde "$p"
            return 0
        fi
    done

    home_to_tilde "${candidates[0]}"
}

choose_socket_path() {
    local suggested="$1"
    local choice
    local custom

    echo
    echo "Choose the Bitwarden SSH agent socket path."
    echo "  1) Suggested/autodetected: $suggested"
    echo "  2) Native Linux or macOS .dmg: ~/.bitwarden-ssh-agent.sock"
    echo "  3) Linux Snap: ~/snap/bitwarden/current/.bitwarden-ssh-agent.sock"
    echo "  4) Linux Flatpak: ~/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock"
    echo "  5) macOS App Store: ~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
    echo "  6) Custom path"

    while true; do
        prompt choice "Selection" "1"

        case "$choice" in
            1)
                printf '%s\n' "$suggested"
                return 0
                ;;
            2)
                printf '%s\n' "~/.bitwarden-ssh-agent.sock"
                return 0
                ;;
            3)
                printf '%s\n' "~/snap/bitwarden/current/.bitwarden-ssh-agent.sock"
                return 0
                ;;
            4)
                printf '%s\n' "~/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock"
                return 0
                ;;
            5)
                printf '%s\n' "~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
                return 0
                ;;
            6)
                prompt custom "Enter IdentityAgent path exactly as it should appear in ssh config"
                if [[ -n "$custom" ]]; then
                    printf '%s\n' "$custom"
                    return 0
                fi
                echo "Path cannot be empty."
                ;;
            *)
                echo "Please enter a number from 1 to 6."
                ;;
        esac
    done
}

ensure_include_line() {
    local main_config="$HOME/.ssh/config"
    local include_line="Include ~/.ssh/config.local.d/*.conf"
    local timestamp
    local backup
    local tmp

    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"

    if [[ ! -e "$main_config" ]]; then
        : > "$main_config"
        chmod 600 "$main_config"
    fi

    if grep -Eq '^[[:space:]]*Include[[:space:]]+~/.ssh/config\.local\.d/\*\.conf([[:space:]]|$)' "$main_config"; then
        echo "Include line already exists in $main_config"
        return 0
    fi

    timestamp="$(date +%Y%m%d-%H%M%S)"
    backup="$main_config.bak.$timestamp"

    cp "$main_config" "$backup"

    tmp="$(mktemp "$main_config.tmp.XXXXXX")"
    {
        printf '%s\n\n' "$include_line"
        cat "$main_config"
    } > "$tmp"

    mv "$tmp" "$main_config"
    chmod 600 "$main_config"

    echo "Added include line to $main_config"
    echo "Backup saved at $backup"
}

write_agent_config() {
    local target_file="$1"
    local host_aliases="$2"
    local socket_path="$3"
    local target_dir
    local timestamp
    local backup
    local tmp

    target_dir="$(dirname "$target_file")"

    mkdir -p "$target_dir"
    chmod 700 "$HOME/.ssh"
    chmod 700 "$target_dir"

    if [[ -e "$target_file" ]]; then
        timestamp="$(date +%Y%m%d-%H%M%S)"
        backup="$target_file.bak.$timestamp"

        cp "$target_file" "$backup"
        echo "Existing file backed up at $backup"
    fi

    tmp="$(mktemp "$target_file.tmp.XXXXXX")"

    cat > "$tmp" <<EOF_CONF
# Machine-local Bitwarden SSH agent config.
# This file is intentionally not meant to be synced across machines.

Host $host_aliases
    IdentityAgent $socket_path
EOF_CONF

    mv "$tmp" "$target_file"
    chmod 600 "$target_file"
}

main() {
    local default_aliases
    local local_conf_input
    local local_conf
    local suggested_socket
    local socket_path
    local socket_check_path
    local test_alias

    echo "Bitwarden SSH agent local config initializer"
    echo

    default_aliases="github_rahat github_prapti"

    prompt HOST_ALIASES "SSH Host aliases to configure" "$default_aliases"

    if [[ -z "${HOST_ALIASES//[[:space:]]/}" ]]; then
        echo "No host aliases provided; aborting." >&2
        exit 1
    fi

    prompt local_conf_input "Local SSH config file to create/update" "~/.ssh/config.local.d/bitwarden-agent.conf"
    local_conf="$(expand_tilde "$local_conf_input")"

    suggested_socket="$(choose_default_socket)"
    socket_path="$(choose_socket_path "$suggested_socket")"
    socket_check_path="$(expand_tilde "$socket_path")"

    echo
    echo "Summary:"
    echo "  Hosts:         $HOST_ALIASES"
    echo "  Local config:  $local_conf"
    echo "  IdentityAgent: $socket_path"
    echo

    if [[ ! -S "$socket_check_path" ]]; then
        echo "Warning: $socket_path is not currently an active Unix socket."
        echo "This is okay if Bitwarden is closed, locked, or the SSH agent is not enabled yet."
        echo
    fi

    if ! yes_no "Write this configuration" "y"; then
        echo "Aborted."
        exit 0
    fi

    write_agent_config "$local_conf" "$HOST_ALIASES" "$socket_path"

    echo "Wrote $local_conf"

    if yes_no "Ensure ~/.ssh/config includes ~/.ssh/config.local.d/*.conf near the top" "y"; then
        ensure_include_line
    else
        echo "Skipped modifying ~/.ssh/config"
        echo "Make sure this appears before your Host github_* blocks:"
        echo "Include ~/.ssh/config.local.d/*.conf"
    fi

    echo
    echo "Created file contents:"
    echo "----------------------------------------"
    sed 's/^/    /' "$local_conf"
    echo "----------------------------------------"

    if yes_no "Run ssh-add -L against the selected Bitwarden socket" "n"; then
        SSH_AUTH_SOCK="$socket_check_path" ssh-add -L || {
            echo "ssh-add -L failed. Check that Bitwarden Desktop is running and SSH agent is enabled." >&2
        }
    fi

    prompt test_alias "SSH host alias to test with ssh -T, or leave blank to skip" ""

    if [[ -n "$test_alias" ]]; then
        ssh -T "$test_alias" || true
    fi

    echo
    echo "Done. For GitHub aliases, a useful verification command is:"
    echo "  GIT_SSH_COMMAND='ssh -vvv' git pull"
}

main "$@"
