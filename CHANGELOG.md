# Changelog

## 2026.3-2.10.3.7-beta

Fabric 26.3 export fix:

Generated workspace build files use the stable `modid` archive name that the generator export path resolves to `build/libs/modid-1.0.jar`.

Validation:

The plugin ZIP loaded in MCreator 2026.3.44621 and generated a workspace with 24 Java sources. The generated `build.gradle` records `base.archivesName = "modid"`, matching the generator export path.

## 2026.3-2.10.2.6-beta

Fabric 26.3 procedure coverage:

Block inventory procedures for slot inspection, insertion, extraction, simulation-aware result variants, item removal, slot clearing, stack limits, and damage handling. The implementation uses the vanilla `Container` interface and requires a block entity with an inventory.

Block NBT procedures for boolean, text, number, and item stack values. Persistence uses a Fabric Data Attachment backed by `CompoundTag.CODEC`.

Entity NBT procedures for boolean, text, number, and item stack values. Persistence uses a separate Fabric Data Attachment and does not add automatic client synchronization.

Entity inventory procedures for slot reads, slot writes, and inventory iteration. Player inventories and entities implementing `Container` are supported.

Item NBT procedures for boolean, text, and number values. Existing item stack NBT procedures continue to use `DataComponents.CUSTOM_DATA`.

Item container procedures for slot reads and writes through `DataComponents.CONTAINER` and `ItemContainerContents`.

Utility procedures for enchantment power lookup, fuel burn time, and piglin currency checks.

Generator base corrections:

Generated block registration now uses the Minecraft 26.3 `BlockBehaviour.Properties.setId(ResourceKey<Block>)` contract and registers through `BuiltInRegistries.BLOCK`.

Generated mod and client initializers now emit optional loader calls only when the corresponding generated classes or special entity types exist.

Generated workspace build files use the workspace mod id for the archive name, the Fabric Loader 0.20.1 and Fabric API 0.166.2 versions, Gradle 9.9.1, and an empty `mcreator.gradle` file created by MCreator.

Validation:

The plugin ZIP loaded in MCreator 2026.3.44621 and generated a workspace containing a block with an inventory, an item, and a procedure. Twenty-four generated Java sources compiled successfully against Minecraft 26.3 and the Fabric 26.3 runtime libraries.
