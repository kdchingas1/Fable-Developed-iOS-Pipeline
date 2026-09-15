#!/usr/bin/env bash
# Install the tooling the pipeline needs on macOS. Safe to re-run.
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  echo "bootstrap: macOS is required for Xcode tooling. On Linux you can still run the research stages and edit code." >&2
  exit 0
fi

command -v brew >/dev/null || { echo "Install Homebrew first: https://brew.sh" >&2; exit 1; }

brew list xcodegen >/dev/null 2>&1 || brew install xcodegen
brew list swiftlint >/dev/null 2>&1 || brew install swiftlint
brew list swiftformat >/dev/null 2>&1 || brew install swiftformat
brew list jq >/dev/null 2>&1 || brew install jq

if ! command -v bundle >/dev/null; then
  echo "Installing bundler"; gem install bundler
fi
bundle config set --local path vendor/bundle
bundle install

xcode-select -p >/dev/null 2>&1 || { echo "Install Xcode from the App Store, then run: sudo xcode-select -s /Applications/Xcode.app" >&2; exit 1; }

[[ -f fastlane/.env ]] || { cp fastlane/.env.example fastlane/.env; echo "Created fastlane/.env from example; fill it in."; }

echo "bootstrap: done. Next: ./scripts/new-product.sh <slug> \"<Display Name>\""
