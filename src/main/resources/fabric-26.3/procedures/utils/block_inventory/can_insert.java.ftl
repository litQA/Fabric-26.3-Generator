private static boolean canInsertInBlockInventory(LevelAccessor world, BlockPos pos, int slotId, int amount, ItemStack itemstack) {
	return insertInBlockInventory(world, pos, slotId, amount, itemstack, true) == 0;
}
