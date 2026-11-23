private static ItemStack extractFromBlockInventory(LevelAccessor world, BlockPos pos, int slotId, int amount, boolean simulate) {
	if (amount <= 0 || world == null || !(world.getBlockEntity(pos) instanceof Container container))
		return ItemStack.EMPTY;
	if (slotId < 0 || slotId >= container.getContainerSize())
		return ItemStack.EMPTY;

	ItemStack existing = container.getItem(slotId);
	if (existing.isEmpty())
		return ItemStack.EMPTY;

	int extracted = Math.min(amount, existing.getCount());
	ItemStack result = existing.copyWithCount(extracted);
	if (!simulate) {
		ItemStack remaining = existing.copy();
		remaining.shrink(extracted);
		container.setItem(slotId, remaining);
		container.setChanged();
	}
	return result;
}
