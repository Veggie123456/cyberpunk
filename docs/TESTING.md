# V0.1 Runtime Test

## Dependencies
Use current compatible versions of Cyberpunk 2077, RED4ext, redscript, Cyber Engine Tweaks and Codeware.

Codeware currently documents compatibility with Cyberpunk 2077 2.31, redscript 0.5.31+, CET 1.37.0+, and RED4ext 1.29.0+.

## Install
Copy the contents of `game/` into the Cyberpunk 2077 root, then copy `r6/` into the same root.

## Smoke test
1. Back up your save.
2. Start Cyberpunk and load into the world.
3. Open the CET console.
4. Run:
   `Game.GetPlayer():WastelandForgeSpawnTest()`
5. A base-game drop-point entity should be requested roughly 2m from V.

The runtime bridge uses Codeware's `DynamicEntitySystem`. Forge persistence remains ours: `persistSpawn=false` because settlement.json will be authoritative.

## What this proves
If the test entity appears, we have crossed the critical boundary from UI-only prototype to real runtime world spawning.

## Next after confirmation
Wire the CET palette to this bridge, capture player/crosshair position, replace the test template with verified build props, track returned EntityIDs, implement delete/recreate, then transform persistence.
