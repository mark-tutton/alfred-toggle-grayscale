# Toggle Grayscale for Alfred

An Alfred workflow that toggles the macOS grayscale display filter.

## Usage

Toggle the macOS grayscale display filter via the `gray` keyword.

Configure the Hotkey for faster triggering.

A notification shows the new state.

## Build

Run `./build.sh`, then open `dist/Toggle-Grayscale.alfredworkflow`.

## How it works

`src/toggle-grayscale.sh` calls `UAGrayscaleIsEnabled` and `UAGrayscaleSetEnabled` from the private `UniversalAccess.framework`.

1. JavaScript for Automation through `osascript`. Ships with macOS.
2. Fallback: `python3` with `ctypes`. Used only when the Xcode Command Line Tools are installed.

No Accessibility or Automation permissions are required.

## License

MIT. See [LICENSE](LICENSE).
