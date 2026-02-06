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
