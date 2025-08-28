# 🐧 Linux [Dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory)

> Personal [dotfiles](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory) configuration for GNOME Desktop Environment

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) ![GitHub repo size](https://img.shields.io/github/repo-size/rahatzamancse/linux-dots?color=green&logo=github) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/rahatzamancse/linux-dots?color=green)

## 🚀 One-Command Installation

```bash
curl -sSL https://raw.githubusercontent.com/rahatzamancse/linux-dots/main/initmydots | bash
```

## 🐳 Docker Commands

### OLLAMA Setup
```bash
docker run -d --restart unless-stopped --gpus=all \
  -v ollama:/root/.ollama -p 11434:11434 \
  --name ollama ollama/ollama
```

## 🤝 Management Method

This repository uses the [Git Bare Repository](https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html) method for dotfile management, providing a clean and efficient way to track configuration files across the home directory.
