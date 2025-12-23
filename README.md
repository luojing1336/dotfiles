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
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

### Java Configuration

Java 17 is configured using Zulu JDK:

```bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home # 17
export GRADLE_LOCAL_JAVA_HOME=JAVA_HOME
```

The configuration supports switching between different Java versions by uncommenting the appropriate line.

### Android SDK

Android development tools are configured with the following paths:

```bash
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/build-tools/33.0.0
```

### Python Configuration

Python configuration prioritizes Homebrew-installed Python, especially for Apple M-series chips:

```bash
export PATH="/opt/homebrew/bin:$PATH" # Apple M 芯片
```

### Ruby Configuration

Ruby is configured with support for both rbenv and RVM:

```bash
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$PATH:$HOME/.rvm/bin"
```

### Other Development Tools

- **VSCode**: Command-line tools for VSCode are added to PATH
- **Fastlane**: Mobile deployment tools
- **Docker**: Docker command-line tools and completions
- **pnpm**: Fast npm alternative package manager
- **bun**: JavaScript runtime and package manager

## PATH Configuration

The PATH is structured in a specific order to prioritize tools:

1. **Homebrew** (`/opt/homebrew/bin:/opt/homebrew/sbin`): System-level tools managed by Homebrew
2. **User binaries** (`$HOME/.local/bin`): User-installed tools and packages
3. **Android SDK**: Various Android development tools
4. **Development tools**: VSCode, Fastlane, Ruby, Docker, pnpm, bun

This structure ensures that Homebrew-managed tools take precedence, followed by user-installed tools.

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

7. Restart your shell or run `source ~/.zshrc`

## Features

- **Fast startup**: Uses Powerlevel10k instant prompt for faster shell initialization
- **Syntax highlighting**: Commands are highlighted as you type
- **Autosuggestions**: Based on command history
- **Git integration**: Git status and branch information in prompt
- **Cross-platform compatibility**: Optimized for macOS with Apple Silicon
- **Comprehensive development support**: Multiple programming languages and tools