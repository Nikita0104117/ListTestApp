#!/bin/bash

set -e

# Trap handlers
trap 'echo "‼️ The script terminated with an error on line $LINENO. Error code: $?" >&2' ERR
trap 'catch_exit $?' EXIT

# Process exit
catch_exit() {
    if [ "$1" -eq 0 ]; then
        echo "✅ Project bootstrap finished."
    else
        echo "‼️ The script terminated with an error. Error code: $1" >&2
    fi
}

projectBootstrapArtText="$(base64 -D <<< "X19fX19fICAgICAgICAgIF8gICAgICAgICAgIF8gICAKfCBfX18gXCAgICAgICAgKF8pICAgICAgICAgfCB8ICAKfCB8Xy8gLyBfXyBfX18gIF8gIF9fXyAgX19ffCB8XyAKfCAgX18vICdfXy8gXyBcfCB8LyBfIFwvIF9ffCBfX3wKfCB8ICB8IHwgfCAoXykgfCB8ICBfXy8gKF9ffCB8XyAKXF98ICB8X3wgIFxfX18vfCB8XF9fX3xcX19ffFxfX3wKICAgICAgICAgICAgICBfLyB8ICAgICAgICAgICAgICAKICAgICAgICAgICAgIHxfXy8gICAgICAgICAgICAgICAKIF9fX19fICAgICAgXyAgICAgICAgICAgICAgICAgICAKLyAgX19ffCAgICB8IHwgICAgICAgICAgICAgICAgICAKXCBgLS0uICBfX198IHxfIF8gICBfIF8gX18gICAgICAKIGAtLS4gXC8gXyBcIF9ffCB8IHwgfCAnXyBcICAgICAKL1xfXy8gLyAgX18vIHxffCB8X3wgfCB8XykgfCAgICAKXF9fX18vIFxfX198XF9ffFxfXyxffCAuX18vICAgICAKICAgICAgICAgICAgICAgICAgICAgfCB8ICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgfF98ICAgICAgICA=")"
echo "$projectBootstrapArtText"
echo ""
echo "Bootstrapping Kibosh VPN iOS project."
# latest setup scripts are usually on development branch
# git checkout develop

# -------------------- Native libraries -----------------------
if [[ $(arch) == 'arm64' ]]; then
  echo 'Detected Apple Silicon chip'

  # making sure Homebrew package manager is installed
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
  arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  arch -x86_64 brew install swiftlint
  arch -x86_64 brew install swiftgen
else
  echo 'Detected Intel chip'

  # making sure Homebrew package manager is installed
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install swiftlint
  brew install swiftgen
fi

# -------------------- Install project frameworks -----------------------
bash install_frameworks