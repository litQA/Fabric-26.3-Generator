# Changelog

**2026.3-2.10.3.7-beta**

## New Content
- Block inventory procedures cover slot inspection, insertion, extraction, simulated result variants, item removal, slot clearing, stack limits, and damage handling through the vanilla `Container` interface.
- Block NBT procedures cover boolean, text, number, and item stack values through a persistent Fabric Data Attachment.
- Entity NBT procedures cover boolean, text, number, and item stack values through a separate persistent Fabric Data Attachment.
- Entity inventory procedures cover slot reads, slot writes, and inventory iteration for player inventories and entities implementing `Container`.
- Item NBT procedures cover boolean, text, and number values through `DataComponents.CUSTOM_DATA`.
- Item container procedures cover slot reads and writes through `DataComponents.CONTAINER` and `ItemContainerContents`.
- Utility procedures cover enchantment power lookup, fuel burn time, and piglin currency checks.

## Changes
- The generator targets MCreator 2026.3.44621, Minecraft 26.3, Fabric Loader 0.20.1, Fabric API 0.166.2+26.3, Java 25, and Gradle 9.9.1.
- Base templates follow the Minecraft 26.3 block registration contract with `BlockBehaviour.Properties.setId(ResourceKey<Block>)` and `BuiltInRegistries.BLOCK`.
- Optional mod and client loader calls are emitted only when the corresponding generated types exist.
- Documentation covers installation, procedure coverage, validation, licensing, and known limitations.

## Fixes
Fixed 4 bugs.
- MCreator export looked for `build/libs/modid-1.0.jar` while generated workspaces produced a mod-id archive name; both sides now use `modid`.
- Block registration called the removed private `Blocks.register` overload; registration now uses the public `Registry.register` path with a `ResourceKey<Block>`.
- The mod initializer and client initializer referenced optional loader classes that were absent in generated workspaces; their guards now check for generated content.

## Known Limitations
- Eight NeoForge block energy procedures and seven NeoForge block fluid tank procedures remain unsupported because the supplied Fabric 26.3 resources provide no equivalent storage API.
- Block NBT values persist only for blocks with a block entity.
- Entity NBT attachment values do not add automatic client synchronization.
- Entity inventory procedures support player inventories and entities implementing `Container`; other entities use guarded `SlotAccess` behavior.
- Item container procedures support up to 256 slots through `ItemContainerContents`.
