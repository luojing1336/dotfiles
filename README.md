# Dotfiles

This repository contains my personal shell configuration files (dotfiles) that set up a comprehensive development environment on macOS. The main configuration file is `.zshrc` which includes various tools, environment variables, and development environment configurations.

## Overview

The `.zshrc` file is a comprehensive shell configuration that sets up:

- A modern, visually appealing terminal prompt using Powerlevel10k
- Oh My Zsh framework for enhanced shell functionality
- Various plugins for productivity
- Multiple development environment configurations
- PATH management for various tools and languages

## Components

### Powerlevel10k Theme

The configuration uses the Powerlevel10k theme, which provides a fast and customizable prompt. The instant prompt feature is enabled to speed up shell startup time.

```bash
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
```

### Oh My Zsh Framework

[Oh My Zsh](https://ohmyz.sh/) is a framework that makes managing Zsh configuration easier. It provides:

- A large collection of plugins and themes
- Automatic updates
- Consistent configuration patterns

Configuration:
- Theme: `powerlevel10k/powerlevel10k`
- Custom folder: `$ZSH_CUSTOM` (default location)

### Plugins

The configuration includes several plugins to enhance productivity:

- `git`: Provides Git aliases and functions
- `z`: Tracks most used directories for quick navigation
- `zsh-autosuggestions`: Suggests commands based on history
- `zsh-syntax-highlighting`: Provides syntax highlighting for commands as you type

## Development Environment Configuration

### Node.js via NVM (Node Version Manager)

Node.js is managed through NVM, allowing for easy switching between Node.js versions:

```bash
export NVM_DIR="$HOME/.nvm"

# NVM 延迟加载函数（提升启动速度）
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}
```

### Java Configuration

Java 17 is configured using Zulu JDK:

```bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export GRADLE_LOCAL_JAVA_HOME=$JAVA_HOME
```

The configuration supports switching between different Java versions by using the provided `switch_java` function.

### Android SDK

Android development tools are configured with the following paths:

```bash
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# 使用通配符或最新版本，避免硬编码
# export PATH=$PATH:$ANDROID_HOME/build-tools/33.0.0
```

## PATH Configuration

The PATH is structured in a specific order to prioritize tools:

1. **Homebrew** (`/opt/homebrew/bin:/opt/homebrew/sbin`): System-level tools managed by Homebrew
2. **User binaries** (`$HOME/.local/bin`): User-installed tools and packages
3. **VSCode**: Command-line tools for VSCode
4. **Docker**: Docker command-line tools
5. **Fastlane**: Mobile deployment tools
6. **RVM**: Ruby Version Manager
7. **pnpm**: Fast npm alternative package manager
8. **Bun**: JavaScript runtime and package manager
9. **Android SDK**: Various Android development tools

Configuration:

```bash
# Homebrew (优先级最高)
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# 用户级命令 (pipx, poetry 等)
export PATH="$HOME/.local/bin:$PATH"

# VSCode
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Docker
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"

# Fastlane
export PATH="$HOME/.fastlane/bin:$HOME/.fastlane/bin/fastlane_lib:$PATH"

# RVM
export PATH="$HOME/.rvm/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
```

### Ruby Configuration

Ruby is configured with support for rbenv:

```bash
# 使用 rbenv 管理 Ruby 版本
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi
```

### Shell Completions

Shell completions are configured for various tools:

```bash
# Docker completions
fpath=($HOME/.docker/completions $fpath)

# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# 初始化补全系统（只需一次）
autoload -Uz compinit
# 性能优化：每天只检查一次
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
```

### Custom Aliases

Some custom aliases are included for convenience:

```bash
alias zshconfig="code ~/.zshrc"
alias zshreload="source ~/.zshrc"
# alias ll="ls -lah"
# alias gs="git status"
# alias gp="git pull"
```

### Custom Functions

A function for switching Java versions is available:

```bash
# 快速切换 Java 版本
switch_java() {
  if [ "$1" = "17" ]; then
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
  elif [ "$1" = "11" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 11)
  elif [ "$1" = "8" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
  fi
  echo "JAVA_HOME: $JAVA_HOME"
}
```

### Other Development Tools

- **VSCode**: Command-line tools for VSCode are added to PATH
- **Fastlane**: Mobile deployment tools
- **Docker**: Docker command-line tools and completions
- **pnpm**: Fast npm alternative package manager
- **bun**: JavaScript runtime and package manager

## Customization

### Prompt Configuration

The Powerlevel10k prompt can be customized by running:

```bash
p10k configure
```

This will generate a `.p10k.zsh` file with your prompt preferences.

### Adding New Tools

To add new tools to your PATH, add export statements after the existing PATH configurations in `.zshrc`. For example:

```bash
export PATH="$PATH:/path/to/your/tool"
```

## Installation

To use this configuration:

1. Backup your existing `.zshrc` if needed
2. Clone this repository to your preferred location
3. Create a symbolic link to the `.zshrc` file:

```bash
ln -s /path/to/dotfiles/.zshrc ~/.zshrc
```

4. Install Oh My Zsh if not already installed:

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

5. Install Powerlevel10k theme:

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

6. Install plugins:
   - `zsh-autosuggestions`: `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
   - `zsh-syntax-highlighting`: `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

7. Install additional tools and configurations:
   - **Powerlevel10k**: Run `p10k configure` to customize your prompt
   - **NVM**: Install Node.js versions as needed after NVM is set up
   - **rbenv**: Install using `brew install rbenv` if you plan to use Ruby
   - **Android SDK**: Install Android SDK tools if needed for mobile development
   - **Docker completions**: May need to install Docker tools for full functionality
   - **Bun**: Install using `curl -fsSL https://bun.sh/install | bash` if not already installed

8. Restart your shell or run `source ~/.zshrc`

## Features

- **Fast startup**: Uses Powerlevel10k instant prompt for faster shell initialization
- **Syntax highlighting**: Commands are highlighted as you type
- **Autosuggestions**: Based on command history
- **Git integration**: Git status and branch information in prompt
- **Cross-platform compatibility**: Optimized for macOS with Apple Silicon
- **Comprehensive development support**: Multiple programming languages and tools