# Wasteland Forge

A settlement-building / Forge-style sandbox prototype for Cyberpunk 2077.

## V0.1 goal
Enter Forge Mode, place props in the Badlands, move/rotate/delete them, save the settlement, exit Forge Mode, and restore it later.

## Planned stack
- Cyber Engine Tweaks (CET)
- Codeware (for later native/game systems integration)
- redscript / RED4ext as features require them

## Current prototype
The first scaffold provides a CET overlay, settlement data model, JSON persistence, an asset registry, and the Forge-mode state machine. Runtime entity spawning is isolated behind an adapter so we can validate the correct game API without risking saves.

## Install (development)
Copy the contents of `game/` into the Cyberpunk 2077 game directory. The resulting CET module should live at:

`bin/x64/plugins/cyber_engine_tweaks/mods/wasteland_forge/`

Open CET and use the Wasteland Forge window.

> Early development build. Back up saves and do not use on a save you cannot afford to lose.
