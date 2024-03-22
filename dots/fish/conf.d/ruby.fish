if not type -q frum
    exit
end

frum init | source

set -gx BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundler/config
set -gx BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundler
