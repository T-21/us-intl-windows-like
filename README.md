# US International Windows-like Keyboard Layout for Linux

Get the same smart dead key behavior on Linux as Windows US-International keyboard layout.

## The Problem

On Linux, the US-International keyboard layouts have frustrating behavior:
- `US intl. with dead keys`: Typing `I'm` requires hitting space after the apostrophe
- `US alt. intl.`: Typing `I'm` gives `Iḿ` (accent on the m)

Windows US-International is smarter: apostrophes only create accents on vowels (á, é, í, ó, ú), not consonants.

## The Solution

This `.XCompose` file brings Windows-like behavior to Linux:
- `' + e` → `é` (accents on vowels work)
- `I'm` → `I'm` (apostrophes with consonants work normally)
- Works on all Linux distros
- Works with any desktop environment (KDE, GNOME, XFCE, etc.)

## Limitations

This solution uses X11's `.XCompose` system. On **Wayland**, `.XCompose` is not supported by all applications. It works in most GTK and Qt apps, but **not in Chromium-based browsers** (Chrome, Edge, Brave, Electron apps) running as native Wayland clients.

**Workaround for Chromium-based browsers on Wayland:** You can force these browsers to run under XWayland by adding `--ozone-platform=x11` to the launch command. To make this permanent, edit the `.desktop` file for your browser (usually in `~/.local/share/applications/` or `/usr/share/applications/`) and append the flag to the `Exec=` line. This restores full `.XCompose` support.

Alternatively, consider using the built-in `US alt. intl.` layout, which moves dead keys to AltGr (but does not have the Windows-like behavior).

## Installation

### Quick Install

```bash
git clone https://github.com/T-21/us-intl-windows-like.git
cd us-intl-windows-like
chmod +x install.sh
./install.sh
```

### Manual Install

1. Copy `.XCompose` to your home directory:
   ```bash
   cp .XCompose ~/.XCompose
   ```

2. Set your keyboard layout to **"US alt. intl."** or **"US international with dead keys"**

3. **Log out and log back in** (or restart)

4. Test it:
   - Type `'e` → should give `é`
   - Type `I'm` → should give `I'm` (not `Iḿ`)

## Desktop-Specific Instructions

### KDE Plasma
1. System Settings → Input Devices → Keyboard → Layouts
2. Select "English (US, alt. intl.)" or "English (US, international with dead keys)"
3. Apply

### GNOME
1. Settings → Keyboard → Input Sources
2. Add "English (United States) - English (international AltGr dead keys)"

### XFCE
1. Settings → Keyboard → Layout
2. Change layout to "USA - English (US, alt. intl.)"

## Uninstallation

```bash
./uninstall.sh
```

Or manually:
```bash
rm ~/.XCompose
```

## How It Works

The `.XCompose` file overrides the default dead key behavior for consonants while preserving accent behavior for vowels. It uses X11's compose key system, which is supported across all Linux desktop environments.

## Contributing

Issues and pull requests welcome! This was born from frustration with Linux keyboard layouts and shared on forums like [this Linux Mint thread](https://forums.linuxmint.com/viewtopic.php?t=427302).

## Credits

- Original solution from the Linux Mint forums
- Refined and packaged by Toine Pel

## License

MIT License - See [LICENSE](LICENSE) file
