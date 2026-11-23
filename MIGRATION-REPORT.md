# Migration Report

## Target

| Item | Value |
| --- | --- |
| Plugin ID | generator-fabric-26.3 |
| Plugin version | 2026.3-2.10.2.6-beta |
| MCreator | 2026.3.44621 |
| Supported MCreator builds | 202600344621 through 202600399999 |
| Minecraft | 26.3 |
| Fabric Loader | 0.20.1 |
| Fabric API | 0.166.2+26.3 |
| Java | 25 |
| Gradle | 9.9.1 |
| License | GPL-3.0 |

The source is based on Fabric-Generator-MCreator 26.3-2.10.1 and the MCreator 26.3 NeoForge generator. The Fabric generator already imports the shared datapack and NeoForge resource layers, with procedures and triggers supplied by the Fabric layer.

## Implemented Procedure Mapping

The 43 procedure templates below are now present in `src/main/resources/fabric-26.3/procedures/`. Fabric now has 498 procedure templates; the NeoForge generator has 513.

| Group | Count | Procedure names |
| --- | --- | --- |
| Block inventory | 13 | `block_inv_can_insert`, `block_inv_clear_slot`, `block_inv_damage_item`, `block_inv_extract_items`, `block_inv_extract_items_get_result`, `block_inv_get_amount_inslot`, `block_inv_get_item_inslot`, `block_inv_get_slot_count`, `block_inv_get_slot_stack_limit`, `block_inv_insert_items`, `block_inv_insert_items_get_result`, `block_inv_remove_items`, `block_inv_set_items` |
| Block NBT | 8 | `block_nbt_logic_get`, `block_nbt_logic_set`, `block_nbt_text_get`, `block_nbt_text_set`, `block_nbt_num_get`, `block_nbt_num_set`, `block_nbt_itemstack_get`, `block_nbt_itemstack_set` |
| Entity NBT | 8 | `entity_nbt_logic_get`, `entity_nbt_logic_set`, `entity_nbt_text_get`, `entity_nbt_text_set`, `entity_nbt_num_get`, `entity_nbt_num_set`, `entity_nbt_itemstack_get`, `entity_nbt_itemstack_set` |
| Item NBT | 6 | `item_nbt_logic_get`, `item_nbt_logic_set`, `item_nbt_text_get`, `item_nbt_text_set`, `item_nbt_num_get`, `item_nbt_num_set` |
| Entity inventory | 3 | `entity_get_slot`, `entity_set_slot`, `entity_inventory_foreach` |
| Item container | 2 | `itemhandler_get_slot`, `itemhandler_set_slot` |
| Utility | 1 | `blockat_enchant_power_bonus` |
| Utility | 1 | `item_fuel_power` |
| Utility | 1 | `item_is_piglin_currency` |

### Implementation Mapping

| NeoForge dependency | Fabric 26.3 replacement |
| --- | --- |
| `Capabilities.Item.BLOCK` and resource handlers | Vanilla `Container` obtained from the block entity |
| `Capabilities.Item.ENTITY` | Player `Inventory`, entities implementing `Container`, and `SlotAccess` fallback |
| `Capabilities.Item.ITEM` | `DataComponents.CONTAINER` and `ItemContainerContents` |
| `getPersistentData()` on block entities and entities | Persistent Fabric Data Attachment containing `CompoundTag` |
| Item custom NBT | `DataComponents.CUSTOM_DATA` and `CustomData` |
| `ResolvableInt` fuel lookup | Vanilla `ResolvableInt.getFromItem` with `DataComponents.COOKING_FUEL` and `CookingFuel::burnTime` |
| `isPiglinCurrency()` | `stack.getItem() == PiglinAi.BARTERING_ITEM` |
| NeoForge enchant power hook | Procedure-local lookup of bookshelf and generated blocks with `enchantPowerBonus > 0` |

Block inventory insertion respects `Container.canPlaceItem`, `Container.getMaxStackSize`, stack component equality, slot bounds, and simulated execution. Extraction returns a copy and commits by shrinking the source stack. Mutating procedures call `Container.setChanged`.

Block and entity NBT use a generated `${JavaModName}NbtData` class in the procedures package. Its `load()` method is called from the generated mod initializer. Reads return copies of the stored tag. Writes replace the attachment, mark block entities changed, and notify clients of block updates. Item stack values are encoded with `ItemStack.OPTIONAL_CODEC` through `NbtOps`.

## Base Generator Corrections

The Fabric 26.3 base templates required these compatibility changes:

- Block registration now uses the 26.3 `BlockBehaviour.Properties.setId(ResourceKey<Block>)` contract.
- The generated mod initializer only calls item-extension or special-entity loaders when those types exist.
- The generated client initializer only calls the model loader when models or special entity types exist.
- `base.archivesName` is derived from the workspace mod id.
- Fabric Loader, Fabric API, and the Gradle wrapper use the versions in the target table.
- The stale upstream `actualmodid` property was removed.
- The NBT data class is generated as part of the base template set.

## Verification

The plugin was built successfully with Gradle 8.14.5. The current environment has a broken `File.canWrite()` result that prevents Gradle 9.x from configuring the root project, so Gradle 8.14.5 was used only as a local validation runner. The project wrapper remains on Gradle 9.9.1 as required by the target table.

The built ZIP loaded in MCreator 2026.3.44621 through the real plugin loader and produced `LOADED fabric-26.3 mc=26.3`.

A headless workspace was created with:

- A block with a 9-slot inventory and a generated block item.
- An item using a 16x16 placeholder texture.
- A procedure with an empty `no_ext_trigger` event.

MCreator generated the base project, the block entity, the item, the procedure, the NBT helper, and the block/item/block-entity initializers. The 24 generated Java files were formatted with MCreator's import organizer and compiled successfully with `javac` 25 against Minecraft 26.3, Fabric Loader 0.20.1, Fabric API 0.166.2+26.3, the Fabric Data Attachment API, Mixin, Mixin Extras, DataFixerUpper, fastutil, Brigadier, and JetBrains annotations.

A full generated-project Gradle/Loom build was not run in this environment.

## Known Limitations

- The eight `block_energy_*` procedures are not implemented: `block_energy_can_extract`, `block_energy_can_receive`, `block_energy_check_extract`, `block_energy_check_receive`, `block_energy_extract`, `block_energy_get_max`, `block_energy_get`, `block_energy_receive`.
- The seven `block_fluidtank_*` procedures are not implemented: `block_fluidtank_check_drain`, `block_fluidtank_check_fill`, `block_fluidtank_drain`, `block_fluidtank_fill`, `block_fluidtank_get_max`, `block_fluidtank_get`, `block_fluidtank_tanks`.
- No compatible energy or fluid storage API was present in the supplied Fabric 26.3 resources. No placeholder no-op API is emitted.
- Block NBT persistence requires a block entity. Positions without a block entity are read as empty values and writes are ignored.
- Entity NBT is persistent but is not automatically synchronized to clients. Procedures that need client values must synchronize them explicitly.
- Entity inventory reads and writes support player inventories and entities that expose a vanilla `Container`. Other entities use `SlotAccess` when available.
- Item container data is limited by `ItemContainerContents` to 256 slots.
- `blockat_enchant_power_bonus` can only see the bookshelf and generated blocks declared with an enchantment power bonus. It does not query NeoForge capability extensions.

## Licensing

The project is licensed under the GNU General Public License, version 3.0. The complete license text and the additional template exception are retained in `LICENSE`. The upstream Fabric-Generator-MCreator attribution is recorded in `README.md`.
