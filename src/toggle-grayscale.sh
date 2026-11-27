#!/bin/bash
# Toggles the macOS grayscale display filter and prints the new state.
#
# Calls UAGrayscaleIsEnabled / UAGrayscaleSetEnabled from the private
# UniversalAccess framework.
# Primary:  JXA through osascript (ships with macOS).
# Fallback: python3 + ctypes (only when the Command Line Tools are installed).

FRAMEWORK="/System/Library/PrivateFrameworks/UniversalAccess.framework"

toggle_with_jxa() {
  /usr/bin/osascript -l JavaScript <<JXA
ObjC.import('Foundation');
\$.NSBundle.bundleWithPath('$FRAMEWORK').load;
ObjC.bindFunction('UAGrayscaleIsEnabled', ['bool', []]);
ObjC.bindFunction('UAGrayscaleSetEnabled', ['void', ['bool']]);
const shouldEnableGrayscale = !\$.UAGrayscaleIsEnabled();
\$.UAGrayscaleSetEnabled(shouldEnableGrayscale);
shouldEnableGrayscale ? 'on' : 'off';
JXA
}

toggle_with_python() {
  /usr/bin/xcode-select -p >/dev/null 2>&1 || return 1
  /usr/bin/python3 - <<PY
from ctypes import cdll
universal_access = cdll.LoadLibrary("$FRAMEWORK/UniversalAccess")
should_enable_grayscale = universal_access.UAGrayscaleIsEnabled() == 0
universal_access.UAGrayscaleSetEnabled(should_enable_grayscale)
print("on" if should_enable_grayscale else "off")
PY
}

is_valid_state() {
  [ "$1" = "on" ] || [ "$1" = "off" ]
}

new_state="$(toggle_with_jxa)"
if ! is_valid_state "$new_state"; then
  new_state="$(toggle_with_python)"
fi

if is_valid_state "$new_state"; then
  printf 'Grayscale is %s' "$new_state"
else
  printf 'Could not toggle grayscale. Open the workflow debugger for details.'
  exit 1
fi
