private static int getBlockInventorySlotStackLimit(LevelAccessor world, BlockPos pos, int slotId) {
	if (world != null && world.getBlockEntity(pos) instanceof Container container
			&& slotId >= 0 && slotId < container.getContainerSize())
		return container.getMaxStackSize(container.getItem(slotId));
	return 0;
}
