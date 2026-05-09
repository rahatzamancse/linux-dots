#!/bin/bash
export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
exec ssh-keygen "$@"
