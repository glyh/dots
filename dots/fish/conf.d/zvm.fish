#!/usr/bin/env fish
if not type -q zvm
    exit
end

# TODO: https://github.com/tristanisham/zvm/pull/65
set -gxa PATH "$HOME/.zvm/bin"
