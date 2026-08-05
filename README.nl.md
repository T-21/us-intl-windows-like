# US International Windows-achtige Toetsenbordindeling voor Linux

*[English](README.md) | [Nederlands](README.nl.md)*

Krijg hetzelfde slimme dead key gedrag op Linux als de Windows US-International toetsenbordindeling.

## Het Probleem

Op Linux hebben de US-International toetsenbordindelingen frustrerend gedrag:
- `US intl. with dead keys`: Typen van `I'm` vereist spatie na de apostrof
- `US alt. intl.`: Typen van `I'm` geeft `Iḿ` (accent op de m)

Windows US-International is slimmer: de apostrof combineert alleen met klinkers (á, é, í, ó, ú, ý) en `c` (ç). Bij elke andere letter volgt gewoon een apostrof met daarachter die letter.

## De Oplossing

Dit `.XCompose` bestand brengt Windows-achtig gedrag naar Linux:
- `' + e` → `é` (accenten op klinkers werken gewoon)
- `I'm` → `I'm` (apostrofs voor medeklinkers werken normaal)
- `' + c` → `ç` en `" + y` → `ÿ` (de uitzonderingen die Windows maakt blijven behouden)
- Werkt op alle Linux distributies
- Werkt met elke desktopomgeving (KDE, GNOME, XFCE, etc.)

Alle medeklinkers zijn afgedekt, ook die waar de standaardtabel van X11 anders een letter met accent zou geven (`ǵ ḱ ṕ ẃ ź`) of de aanslagen stilzwijgend zou weggooien (`b f h q x`).

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

## Installatie

### Snelle Installatie

```bash
git clone https://github.com/T-21/us-intl-windows-like.git
cd us-intl-windows-like
chmod +x install.sh
./install.sh
```

### Bijwerken

```bash
cd us-intl-windows-like
git pull
./install.sh
```

Log daarna uit en weer in. Alleen de betreffende applicatie herstarten is niet altijd genoeg om de nieuwe tabel op te pikken.

De `~/.XCompose` die je had voordat je dit voor het eerst installeerde wordt eenmalig bewaard en daarna nooit meer overschreven, dus bijwerken kun je zo vaak herhalen als je wilt. Is het geïnstalleerde bestand lokaal aangepast, dan wordt er een kopie met tijdstempel naast gezet voordat het vervangen wordt, zodat je je eigen regels daaruit kunt terughalen.

### Handmatige Installatie

1. Kopieer `.XCompose` naar je home directory (maak eerst een backup van een bestaand bestand):
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

Dit zet de `~/.XCompose` terug die je had voordat je installeerde, of verwijdert het bestand als je er geen had. Kopieën met tijdstempel van lokaal aangepaste versies blijven staan en worden getoond, zodat er niets stilzwijgend verdwijnt.

Of handmatig:
```bash
rm ~/.XCompose
```

## Hoe Het Werkt

De eerste regel, `include "%L"`, haalt de standaard compose-tabel van je locale binnen, zodat alle gebruikelijke sequences blijven werken. De regels daaronder overschrijven alleen de combinaties waarover Linux en Windows het oneens zijn, namelijk een dead key gevolgd door een medeklinker. Een latere definitie wint, dus die overrides vervangen de standaardwaarden terwijl de klinkers ongemoeid blijven.

Voor de meeste locales met Latijns schrift (`en_US`, `nl_NL`, `de_DE`, `fr_FR` en andere) wijst `%L` naar dezelfde tabel, dus het gedrag hangt niet af van je systeemtaal. Dat is ook de reden om die regel op `%L` te laten staan in plaats van er een specifieke locale in vast te leggen.

## Bijdragen

Issues en pull requests zijn welkom! Dit is ontstaan uit frustratie met Linux toetsenbordindelingen en gedeeld op forums zoals [deze Linux Mint thread](https://forums.linuxmint.com/viewtopic.php?t=427302).

Controleer bij het wijzigen van mappings of klinkers nog correct accenten krijgen (`café`, `naïve`) en of gangbare samentrekkingen gewoon blijven (`don't`, `I'll`, `I'd've`). Dubbele sequences worden stilzwijgend in het voordeel van de laatste beslecht, dus je overschaduwt makkelijk per ongeluk een bestaande regel.

## Credits

- Originele oplossing van de Linux Mint forums
- Verfijnd en verpakt door Toine Pel

## Licentie

MIT License - Zie [LICENSE](LICENSE) bestand
