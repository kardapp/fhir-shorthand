# 03 - SUSHI och sushi-config

## Vad är SUSHI?
SUSHI (SUSHI Unshortens SHorthand Inputs) är kompilatorn som läser FSH och genererar FHIR JSON-resurser.

## Var vi använder SUSHI i repot
- FSH-input: `GDRFirstRelease/input/fsh/`
- Konfiguration: `GDRFirstRelease/sushi-config.yaml`
- Genererat resultat: `GDRFirstRelease/fsh-generated/`

## Vanliga kommandon
```powershell
Set-Location "C:\Users\fz71\github\fhir-shorthand\GDRFirstRelease"
sushi .
```

## Vad sushi-config.yaml styr
- IG-metadata (namn, version, canonical, publisher).
- Dependencies mot externa Implementation Guides.
- Paketinställningar och publiceringsmetadata.

## Rekommenderat arbetssätt
1. Uppdatera FSH-filer.
2. Kör `sushi .` lokalt för snabb feedback.
3. Granska varningar/fel innan IG Publisher-körning.
4. Kör full build med Publisher för slutlig QA.

## Vanliga felbilder
- Dependency saknas eller fel version i `sushi-config.yaml`.
- Namnkollisioner mellan `Id` i flera artefakter.
- Oväntad output när lokala ändringar i flera FSH-filer interagerar.

## Tips för felsökning
- Isolera ändringen: kör om efter små steg.
- Läs både SUSHI-logg och den genererade resursen i `fsh-generated/`.
- Verifiera att artefakt-ID, canonical och referenser är konsekventa.
