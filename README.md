# US International Windows-like Keyboard Layout for Linux

Get the same smart dead key behavior on Linux as Windows US-International keyboard layout.

## The Problem

On Linux, the US-International keyboard layouts have frustrating behavior:
- `US intl. with dead keys`: Typing `I'm` requires hitting space after the apostrophe
- `US alt. intl.`: Typing `I'm` gives `Iḿ` (accent on the m)

Windows US-International is smarter: the apostrophe only combines with vowels (á, é, í, ó, ú, ý) and `c` (ç). With any other letter it produces a plain apostrophe followed by that letter.

## The Solution

This `.XCompose` file brings Windows-like behavior to Linux:
- `' + e` → `é` (accents on vowels still work)
- `I'm` → `I'm` (apostrophes before consonants work normally)
- `' + c` → `ç` and `" + y` → `ÿ` (the exceptions Windows makes are preserved)
- Works on all Linux distros
- Works with any desktop environment (KDE, GNOME, XFCE, etc.)

Every consonant is covered, including the ones where the X11 default table would otherwise produce an accented character (`ǵ ḱ ṕ ẃ ź`) or silently swallow the keystrokes (`b f h q x`).

## Limitations

This solution uses X11's `.XCompose` system. On **Wayland**, `.XCompose` is not supported by all applications. It works in most GTK and Qt apps, but **not in Chromium-based browsers** (Chrome, Edge, Brave, Electron apps) running as native Wayland clients.

**Workaround for Chromium-based browsers on Wayland:** Force the browser to run under XWayland by adding `--ozone-platform=x11` to the launch command. To make this permanent:

- **Native install:** Edit the `.desktop` file for your browser (usually in `~/.local/share/applications/` or `/usr/share/applications/`) and add `--ozone-platform=x11` at the end of the `Exec=` line, e.g.:
  ```
  Exec=/usr/bin/brave --ozone-platform=x11 %U
  ```
- **Flatpak install:** Add the flag to the browser's config file and grant access to `.XCompose`:
  ```bash
  # For Brave (adjust app ID for other browsers):
  echo "--ozone-platform=x11" >> ~/.var/app/com.brave.Browser/config/brave-flags.conf
  flatpak override --user --filesystem=~/.XCompose:ro com.brave.Browser
  ```
  Common Flatpak app IDs: `com.brave.Browser`, `com.google.Chrome`, `com.microsoft.Edge`

Restart the browser after making these changes.

## Installation

### Quick Install

```bash
git clone https://github.com/T-21/us-intl-windows-like.git
cd us-intl-windows-like
chmod +x install.sh
./install.sh
```

### Updating

```bash
cd us-intl-windows-like
git pull
./install.sh
```

Log out and log back in afterwards. Restarting individual applications is not always enough for the new table to be picked up.

The `~/.XCompose` you had before the first install is backed up once and never overwritten afterwards, so updating is safe to repeat. If the installed file has been modified locally, a timestamped copy is saved next to it before it is replaced, so you can retrieve your own mappings from there.

### Manual Install

1. Copy `.XCompose` to your home directory (back up any existing file first):
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

This restores the `~/.XCompose` you had before installing, or removes the file if there was none. Timestamped copies of locally modified versions are left in place and listed, so nothing disappears silently.

Or manually:
```bash
rm ~/.XCompose
```

## How It Works

The first line, `include "%L"`, pulls in the default compose table for your locale, so every standard sequence keeps working. The rules below it override only the combinations where Linux and Windows disagree, which is a dead key followed by a consonant. A later definition wins, so those overrides replace the defaults while the vowels are left untouched.

For most Latin-script locales (`en_US`, `nl_NL`, `de_DE`, `fr_FR` and others) `%L` resolves to the same table, so behavior does not depend on your system language. That is also why the line should stay as `%L` rather than being hardcoded to a specific locale.

## Contributing

Issues and pull requests welcome! This was born from frustration with Linux keyboard layouts and shared on forums like [this Linux Mint thread](https://forums.linuxmint.com/viewtopic.php?t=427302).

When changing mappings, check that vowels still accent correctly (`café`, `naïve`) and that common contractions stay plain (`don't`, `I'll`, `I'd've`). Duplicate sequences are resolved silently in favor of the last one, so it is easy to shadow an existing rule by accident.

## Credits

- Original solution from the Linux Mint forums
- Refined and packaged by Toine Pel

## License

MIT License - See [LICENSE](LICENSE) file
