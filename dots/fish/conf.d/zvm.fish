#!/usr/bin/env fish
if not type -q zvm
    exit
end

set -gxa PATH "$HOME/.zvm/bin"
