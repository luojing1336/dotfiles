# ============================================
# Powerlevel10k Instant Prompt
# ============================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================
# Oh-My-Zsh Configuration
# ============================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# 插件配置
plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ============================================
# PATH Configuration (统一管理)
# ============================================
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

# ============================================
# Android SDK Configuration
# ============================================
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# 使用通配符或最新版本，避免硬编码
# export PATH=$PATH:$ANDROID_HOME/build-tools/33.0.0

# ============================================
# Java Configuration
# ============================================
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export GRADLE_LOCAL_JAVA_HOME=$JAVA_HOME

# ============================================
# Node Version Manager (NVM) - 延迟加载优化
# ============================================
export NVM_DIR="$HOME/.nvm"

# NVM 延迟加载函数（提升启动速度）
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}

# 或者使用标准加载方式（如果不在意启动速度）
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ============================================
# Ruby Configuration
# ============================================
# 使用 rbenv 管理 Ruby 版本
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi

# ============================================
# Shell Completions
# ============================================
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

# ============================================
# Powerlevel10k Theme
# ============================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================
# Custom Aliases (解开注释可选)
# ============================================
alias zshconfig="code ~/.zshrc"
alias zshreload="source ~/.zshrc"
# alias ll="ls -lah"
# alias gs="git status"
# alias gp="git pull"

# ============================================
# Custom Functions (解开注释可选)
# ============================================
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