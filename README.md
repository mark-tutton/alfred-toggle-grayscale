# Toggle Grayscale for Alfred

An Alfred workflow that toggles the macOS grayscale display filter.

## Requirements

- macOS
- Alfred with the Powerpack

## Install

1. Run `./build.sh`.
2. Open `dist/Toggle-Grayscale.alfredworkflow`.

## Usage

| Trigger | Action |
| --- | --- |
| `gray` keyword | Toggles grayscale |
| Hotkey | Unassigned by default. Double-click the Hotkey object in the workflow editor to set one. |

A notification shows the new state.

## How it works

`src/toggle-grayscale.sh` calls `UAGrayscaleIsEnabled` and `UAGrayscaleSetEnabled` from the private `UniversalAccess.framework`.

1. JavaScript for Automation through `osascript`. Ships with macOS.
2. Fallback: `python3` with `ctypes`. Used only when the Xcode Command Line Tools are installed.

No Accessibility or Automation permissions are required.

## Project layout

| Path | Purpose |
| --- | --- |
| `src/info.plist` | Workflow definition |
| `src/toggle-grayscale.sh` | Toggle script |
| `build.sh` | Packages `src/` into `dist/` |

## License

MIT. See [LICENSE](LICENSE).
