<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2026, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with Fabric-Generator-MCreator. If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
package ${package}.procedures;

import net.fabricmc.fabric.api.attachment.v1.AttachmentRegistry;
import net.fabricmc.fabric.api.attachment.v1.AttachmentTarget;
import net.fabricmc.fabric.api.attachment.v1.AttachmentType;
import net.minecraft.core.BlockPos;
import net.minecraft.core.RegistryAccess;
import net.minecraft.nbt.CompoundTag;
import net.minecraft.nbt.NbtOps;
import net.minecraft.resources.Identifier;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.level.Level;
import net.minecraft.world.level.LevelAccessor;
import net.minecraft.world.level.block.entity.BlockEntity;
import net.minecraft.world.level.block.state.BlockState;
import ${package}.${JavaModName};

public final class ${JavaModName}NbtData {

	public static final AttachmentType<CompoundTag> BLOCK_NBT = AttachmentRegistry.createPersistent(
			Identifier.fromNamespaceAndPath(${JavaModName}.MODID, "block_nbt"), CompoundTag.CODEC);

	public static final AttachmentType<CompoundTag> ENTITY_NBT = AttachmentRegistry.createPersistent(
			Identifier.fromNamespaceAndPath(${JavaModName}.MODID, "entity_nbt"), CompoundTag.CODEC);

	private ${JavaModName}NbtData() {
	}

	public static void load() {
		// Calling this method forces initialization of the attachment registry entries above.
	}

	private static CompoundTag blockTag(LevelAccessor world, BlockPos pos) {
		if (world != null && world.getBlockEntity(pos) instanceof AttachmentTarget target)
			return target.getAttachedOrElse(BLOCK_NBT, new CompoundTag()).copy();
		return new CompoundTag();
	}

	private static CompoundTag entityTag(Entity entity) {
		if (entity instanceof AttachmentTarget target)
			return target.getAttachedOrElse(ENTITY_NBT, new CompoundTag()).copy();
		return new CompoundTag();
	}

	public static boolean getBlockBoolean(LevelAccessor world, BlockPos pos, String key) {
		return blockTag(world, pos).getBooleanOr(key, false);
	}

	public static String getBlockString(LevelAccessor world, BlockPos pos, String key) {
		return blockTag(world, pos).getStringOr(key, "");
	}

	public static double getBlockNumber(LevelAccessor world, BlockPos pos, String key) {
		return blockTag(world, pos).getDoubleOr(key, 0);
	}

	public static ItemStack getBlockItemStack(LevelAccessor world, BlockPos pos, String key) {
		if (world instanceof Level level)
			return readItemStack(blockTag(world, pos), key, level.registryAccess());
		return ItemStack.EMPTY;
	}

	public static void setBlockBoolean(LevelAccessor world, BlockPos pos, String key, boolean value) {
		CompoundTag tag = blockTag(world, pos);
		tag.putBoolean(key, value);
		setBlockTag(world, pos, tag);
	}

	public static void setBlockString(LevelAccessor world, BlockPos pos, String key, String value) {
		CompoundTag tag = blockTag(world, pos);
		tag.putString(key, value);
		setBlockTag(world, pos, tag);
	}

	public static void setBlockNumber(LevelAccessor world, BlockPos pos, String key, double value) {
		CompoundTag tag = blockTag(world, pos);
		tag.putDouble(key, value);
		setBlockTag(world, pos, tag);
	}

	public static void setBlockItemStack(LevelAccessor world, BlockPos pos, String key, ItemStack stack) {
		if (world instanceof Level level) {
			CompoundTag tag = blockTag(world, pos);
			tag.put(key, writeItemStack(stack, level.registryAccess()));
			setBlockTag(world, pos, tag);
		}
	}

	private static void setBlockTag(LevelAccessor world, BlockPos pos, CompoundTag tag) {
		if (world == null || world.isClientSide())
			return;

		if (world.getBlockEntity(pos) instanceof AttachmentTarget target) {
			BlockEntity blockEntity = (BlockEntity) target;
			target.setAttached(BLOCK_NBT, tag.copy());
			blockEntity.setChanged();

			if (world instanceof Level level) {
				BlockState state = world.getBlockState(pos);
				level.sendBlockUpdated(pos, state, state, 3);
			}
		}
	}

	public static boolean getEntityBoolean(Entity entity, String key) {
		return entityTag(entity).getBooleanOr(key, false);
	}

	public static String getEntityString(Entity entity, String key) {
		return entityTag(entity).getStringOr(key, "");
	}

	public static double getEntityNumber(Entity entity, String key) {
		return entityTag(entity).getDoubleOr(key, 0);
	}

	public static ItemStack getEntityItemStack(Entity entity, String key) {
		if (entity != null)
			return readItemStack(entityTag(entity), key, entity.level().registryAccess());
		return ItemStack.EMPTY;
	}

	public static void setEntityBoolean(Entity entity, String key, boolean value) {
		CompoundTag tag = entityTag(entity);
		tag.putBoolean(key, value);
		setEntityTag(entity, tag);
	}

	public static void setEntityString(Entity entity, String key, String value) {
		CompoundTag tag = entityTag(entity);
		tag.putString(key, value);
		setEntityTag(entity, tag);
	}

	public static void setEntityNumber(Entity entity, String key, double value) {
		CompoundTag tag = entityTag(entity);
		tag.putDouble(key, value);
		setEntityTag(entity, tag);
	}

	public static void setEntityItemStack(Entity entity, String key, ItemStack stack) {
		if (entity != null && !entity.level().isClientSide()) {
			CompoundTag tag = entityTag(entity);
			tag.put(key, writeItemStack(stack, entity.level().registryAccess()));
			setEntityTag(entity, tag);
		}
	}

	private static void setEntityTag(Entity entity, CompoundTag tag) {
		if (entity != null && !entity.level().isClientSide() && entity instanceof AttachmentTarget target)
			target.setAttached(ENTITY_NBT, tag.copy());
	}

	private static ItemStack readItemStack(CompoundTag tag, String key, RegistryAccess registryAccess) {
		return ItemStack.OPTIONAL_CODEC
				.parse(registryAccess.createSerializationContext(NbtOps.INSTANCE), tag.getCompoundOrEmpty(key))
				.result().orElse(ItemStack.EMPTY);
	}

	private static CompoundTag writeItemStack(ItemStack stack, RegistryAccess registryAccess) {
		return (CompoundTag) ItemStack.OPTIONAL_CODEC
				.encode(stack, registryAccess.createSerializationContext(NbtOps.INSTANCE), new CompoundTag())
				.result().orElseGet(CompoundTag::new);
	}
}
<#-- @formatter:on -->
