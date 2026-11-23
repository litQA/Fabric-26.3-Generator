# Minecraft Fabric 26.3 Generator

This repository contains a resource generator plugin for MCreator that targets Fabric and Minecraft 26.3.

The plugin is based on the official Fabric-Generator-MCreator project and adds procedure block coverage that was previously available only in the NeoForge generator.

## Compatibility

| Component | Version |
| --- | --- |
| Plugin | 2026.3-2.10.2.6-beta |
| MCreator | 2026.3.44621 |
| Minecraft | 26.3 |
| Fabric Loader | 0.20.1 |
| Fabric API | 0.166.2+26.3 |
| Java | 25 |
| Gradle | 9.9.1 |
| License | GPL-3.0 |

The generator accepts MCreator build numbers 202600344621 through 202600399999.

## Installation

1. Build the plugin or use a packaged `generator-fabric-26.3.zip`.
2. Copy the ZIP into the MCreator `plugins` directory.
3. Start MCreator and create a workspace with the Fabric 26.3 generator.
4. Add Fabric API 0.166.2+26.3 to the generated project dependencies when playing the mod.

## Procedure Coverage

The plugin adds 43 procedure templates that were missing from the Fabric generator:

- Block inventory: insert, extract, inspect, modify, clear, damage, and simulation-aware result procedures.
- Block NBT: boolean, text, number, and item stack get/set procedures.
- Entity NBT: boolean, text, number, and item stack get/set procedures.
- Entity inventory: slot get/set and inventory iteration.
- Item NBT: boolean, text, and number get/set procedures.
- Item containers: slot get/set procedures using `DataComponents.CONTAINER`.
- Utility procedures: fuel burn time, piglin currency check, and enchantment power bonus.

See `MIGRATION-REPORT.md` for the complete mapping and for the features that remain unsupported.

## Known Limitations

- Block inventories require a block entity. The block generator creates one when the inventory option is enabled.
- Block and entity NBT use Fabric Data Attachment persistence. Entity NBT is not automatically synchronized to clients.
- Entity inventory access supports players and entities that expose a vanilla `Container`. Other entities use `SlotAccess` where available.
- Item container access uses vanilla item components and is limited to 256 slots.
- The NeoForge energy and fluid tank procedure groups are not implemented because the supplied Fabric resources do not provide an equivalent storage API.

## Validation

The plugin ZIP was built successfully and loaded by the MCreator 2026.3 plugin loader. A headless MCreator workspace containing a block with an inventory, an item, and a procedure generated 24 Java sources; those sources compiled against Minecraft 26.3, Fabric Loader 0.20.1, Fabric API 0.166.2+26.3, Fabric Data Attachment API, and Mixin Extras.

## Credits and License

Generator maintained for this distribution by LitQA and the Moegirl Deepseek project.

Based on Fabric-Generator-MCreator by Goldorion, NerdyPuzzle, Spectrall, and contributors. The generator also reuses structure and templates from the official MCreator NeoForge generator.

Licensed under GNU GPL version 3.0. See `LICENSE` for the complete license text and the template exception.
