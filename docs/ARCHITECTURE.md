# Wasteland Forge Architecture

## Core layers
1. CET UI: build palette, object list, controls, settings.
2. Forge model: settlement state, selection, transforms, duplication, categories.
3. Persistence: JSON settlement saves and later named save slots.
4. Runtime bridge: Codeware DynamicEntitySystem for spawning/deleting world entities.
5. Character layer: future NPC residents and optional named-character modules.

## Safety rule
Forge never modifies story quest facts to resurrect a character. Named-character settlement modules will use isolated spawned entities so a sandbox resident does not rewrite campaign state.

## Planned build workflow
Enter Forge Mode -> choose category -> choose asset -> preview -> place -> transform -> duplicate/delete -> save -> exit Forge Mode.

## Settlement format
Each object stores a Forge ID, template path, category, position, rotation, scale and optional metadata. Later NPC records add home, job, schedule and interaction metadata.
