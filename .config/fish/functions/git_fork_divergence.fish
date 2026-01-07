function git_fork_divergence
    argparse 'l/limit=' 'b/branch=+' -- $argv
    or begin
        echo "Usage: git_fork_divergence [-l N] [-b BRANCH ...] https://github.com/OWNER/REPO" >&2
        return 2
    end

    command -vq gh;  or begin; echo "Missing: gh" >&2;  return 2; end
    command -vq jq;  or begin; echo "Missing: jq" >&2;  return 2; end
    command -vq gum; or begin; echo "Missing: gum (install from https://github.com/charmbracelet/gum)" >&2; return 2; end

    set -l repo_url $argv[1]
    if test -z "$repo_url"
        echo "Error: missing repo URL" >&2
        return 2
    end

    set -l cleaned (string replace -r '\.git$' '' -- $repo_url)
    set -l path ""

    if string match -qr '^https?://github\.com/' -- $cleaned
        set path (string replace -r '^https?://github\.com/' '' -- $cleaned)
    else if string match -qr '^git@github\.com:' -- $cleaned
        set path (string replace -r '^git@github\.com:' '' -- $cleaned)
    else
        echo "Error: unrecognized GitHub repo URL format: $repo_url" >&2
        return 2
    end

    set -l owner (string split -m 1 '/' -- $path)[1]
    set -l repo  (string split -m 1 '/' -- $path)[2]

    if test -z "$owner" -o -z "$repo"
        echo "Error: could not parse OWNER/REPO from: $repo_url" >&2
        return 2
    end

    set -l base "/repos/$owner/$repo"

    gum style --border rounded --padding "1 2" --margin "0 0 1 0" \
        --foreground 212 --border-foreground 212 \
        "🐙 Fork Divergence (streaming)" \
        "" \
        "$owner/$repo"

    set -l upstream_branches (gh api "$base/branches?per_page=100" --paginate 2>/dev/null | jq -r '.[].name' | sort -u)
    if test (count $upstream_branches) -eq 0
        gum style --foreground 196 "Error: couldn't fetch branches (check gh auth / repo access)."
        return 1
    end

    if set -q _flag_branch
        set -l filtered
        for b in $_flag_branch
            if contains -- $b $upstream_branches
                set filtered $filtered $b
            end
        end
        if test (count $filtered) -gt 0
            set upstream_branches $filtered
        end
    end

    set -l forks_tsv (gh api "$base/forks?per_page=100" --paginate 2>/dev/null \
        | jq -r '.[] | [.full_name, .owner.login] | @tsv')

    if test -z "$forks_tsv"
        gum style --foreground 244 "No forks found."
        return 0
    end

    if set -q _flag_limit
        set -l limited
        set -l i 0
        for line in $forks_tsv
            set i (math $i + 1)
            if test $i -le $_flag_limit
                set limited $limited $line
            end
        end
        set forks_tsv $limited
    end

    gum style --foreground 244 --margin "0 0 1 0" \
        "Legend: ✅ synced   🟦 ahead   🟥 behind   🟪 diverged"

    for line in $forks_tsv
        set -l fork_full (string split \t -- $line)[1]
        set -l fork_owner (string split \t -- $line)[2]

        gum style --bold --foreground 214 --margin "1 0 0 0" "$fork_full"

        for br in $upstream_branches
            set -l resp (gh api "$base/compare/$br...$fork_owner:$br" 2>/dev/null)
            if test $status -ne 0 -o -z "$resp"
                continue
            end

            set -l ahead (echo "$resp" | jq -r '.ahead_by // 0')
            set -l behind (echo "$resp" | jq -r '.behind_by // 0')

            set -l badge
            set -l color

            if test $ahead -eq 0 -a $behind -eq 0
                set badge "✅"; set color 42
            else if test $ahead -gt 0 -a $behind -eq 0
                set badge "🟦"; set color 39
            else if test $ahead -eq 0 -a $behind -gt 0
                set badge "🟥"; set color 196
            else
                set badge "🟪"; set color 135
            end

            # Safe formatting across fish versions:
            set -l br_pad (string pad -r -w 12 -- $br)
            set -l out (printf "  %s  %s   ahead %4d   behind %4d" $badge $br_pad $ahead $behind)

            gum style --foreground $color "$out"
        end
    end
end

