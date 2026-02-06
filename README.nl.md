# US International Windows-achtige Toetsenbordindeling voor Linux

Krijg hetzelfde slimme dead key gedrag op Linux als de Windows US-International toetsenbordindeling.

## Het Probleem

Op Linux hebben de US-International toetsenbordindelingen frustrerend gedrag:
- `US intl. with dead keys`: Typen van `I'm` vereist spatie na de apostrof
- `US alt. intl.`: Typen van `I'm` geeft `Iḿ` (accent op de m)

Windows US-International is slimmer: apostrofs maken alleen accenten op klinkers (á, é, í, ó, ú), niet op medeklinkers.

## De Oplossing

Dit `.XCompose` bestand brengt Windows-achtig gedrag naar Linux:
- `' + e` → `é` (accenten op klinkers werken)
- `I'm` → `I'm` (apostrofs met medeklinkers werken normaal)
- Werkt op alle Linux distributies
- Werkt met elke desktopomgeving (KDE, GNOME, XFCE, etc.)

## Beperkingen

Deze oplossing gebruikt het `.XCompose`-systeem van X11. Op **Wayland** wordt `.XCompose` niet door alle applicaties ondersteund. Het werkt in de meeste GTK- en Qt-apps, maar **niet in Chromium-gebaseerde browsers** (Chrome, Edge, Brave, Electron-apps) die als native Wayland-client draaien.

**Workaround voor Chromium-gebaseerde browsers op Wayland:** Forceer de browser om via XWayland te draaien door `--ozone-platform=x11` toe te voegen aan het startcommando. Om dit permanent te maken:

- **Normale installatie:** Bewerk het `.desktop`-bestand van je browser (meestal in `~/.local/share/applications/` of `/usr/share/applications/`) en voeg `--ozone-platform=x11` toe aan de `Exec=` regel, bijv.:
  ```
  Exec=/usr/bin/brave --ozone-platform=x11 %U
  ```
- **Flatpak-installatie:** Voeg de flag toe aan het configuratiebestand van de browser en geef toegang tot `.XCompose`:
  ```bash
  # Voor Brave (pas de app ID aan voor andere browsers):
  echo "--ozone-platform=x11" >> ~/.var/app/com.brave.Browser/config/brave-flags.conf
  flatpak override --user --filesystem=~/.XCompose:ro com.brave.Browser
  ```
  Veelgebruikte Flatpak app IDs: `com.brave.Browser`, `com.google.Chrome`, `com.microsoft.Edge`

Herstart de browser na deze wijzigingen.

Als alternatief kun je de ingebouwde `US alt. intl.` layout gebruiken, die dead keys naar AltGr verplaatst (maar niet het Windows-achtige gedrag heeft).

## Installatie

### Snelle Installatie

```bash
git clone https://github.com/T-21/us-intl-windows-like.git
cd us-intl-windows-like
chmod +x install.sh
./install.sh
```

### Handmatige Installatie

1. Kopieer `.XCompose` naar je home directory:
   ```bash
   cp .XCompose ~/.XCompose
   ```

2. Zet je toetsenbordindeling op **"US alt. intl."** of **"US international with dead keys"**

3. **Log uit en weer in** (of herstart)

4. Test het:
   - Type `'e` → moet `é` geven
   - Type `I'm` → moet `I'm` geven (niet `Iḿ`)

## Desktop-Specifieke Instructies

### KDE Plasma
1. Systeeminstellingen → Invoerapparaten → Toetsenbord → Indelingen
2. Selecteer "English (US, alt. intl.)" of "English (US, international with dead keys)"
3. Toepassen

### GNOME
1. Instellingen → Toetsenbord → Invoerbronnen
2. Voeg toe "English (United States) - English (international AltGr dead keys)"

### XFCE
1. Instellingen → Toetsenbord → Indeling
2. Wijzig indeling naar "USA - English (US, alt. intl.)"

## Deïnstallatie

```bash
./uninstall.sh
```

Of handmatig:
```bash
rm ~/.XCompose
```

## Hoe Het Werkt

Het `.XCompose` bestand overschrijft het standaard dead key gedrag voor medeklinkers terwijl het accentgedrag voor klinkers behouden blijft. Het gebruikt X11's compose key systeem, dat ondersteund wordt door alle Linux desktopomgevingen.

## Bijdragen

Issues en pull requests zijn welkom! Dit is ontstaan uit frustratie met Linux toetsenbordindelingen en gedeeld op forums zoals [deze Linux Mint thread](https://forums.linuxmint.com/viewtopic.php?t=427302).

## Credits

- Originele oplossing van de Linux Mint forums
- Verfijnd en verpakt door Toine Pel

## Licentie

MIT License - Zie [LICENSE](LICENSE) bestand
