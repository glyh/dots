#!/usr/bin/env fish

# https://github.com/qutebrowser/qutebrowser/issues/8135
set -gx QT_SCALE_FACTOR_ROUNDING_POLICY RoundPreferFloor

set -gx QT_IM_MODULE             fcitx
set -gx QT_QPA_PLATFORM          wayland
