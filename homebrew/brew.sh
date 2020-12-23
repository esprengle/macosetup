#!/usr/bin/env bash
#

# Don't run directly!
[[ "$_" == "$0" ]] && exit 255

# Brew
[[ ${_brew_enabled:-true} == false ]] && return
[[ ${_xcode_enabled:-true} == false ]] && return
echo "${BASH_SOURCE[0]}"

# Install Homebrew
if [[ ! -x /usr/local/bin/brew ]]
then
  #/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Analytics
brew analytics "${_brew_analytics:-off}"

# Taps
for _tap in "${_brew_taps[@]:-()}"
do
  brew tap "$_tap"
done

# Install Formulae
if [[ -n "${_brew_formulae[*]:-()}" ]]
then

  for _formulae in "${_brew_formulae[@]}"
  do
    brew info "$_formulae" | grep -qi "not installed" && \
      brew install "$_formulae"
  done

  [[ ${_brew_upgrade:-true} == true ]] && brew upgrade
fi

# Cleanup
[[ ${_brew_cleanup:-false} == true ]] && brew cleanup --prune="${_brew_cleanup_prune:-0}"