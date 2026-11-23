private static ItemStack itemFromBlockInventory(LevelAccessor world, BlockPos pos, int slot) {
	if (world != null && world.getBlockEntity(pos) instanceof Container container
			&& slot >= 0 && slot < container.getContainerSize())
		return container.getItem(slot).copy();
	return ItemStack.EMPTY;
}
