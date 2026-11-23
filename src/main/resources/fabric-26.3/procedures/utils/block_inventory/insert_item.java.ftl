private static int insertInBlockInventory(LevelAccessor world, BlockPos pos, int slotId, int amount, ItemStack itemstack, boolean simulate) {
	if (amount <= 0)
		return 0;
	if (itemstack.isEmpty() || world == null || !(world.getBlockEntity(pos) instanceof Container container))
		return amount;
	if (slotId < 0 || slotId >= container.getContainerSize())
		return amount;

	ItemStack existing = container.getItem(slotId);
	if (!existing.isEmpty() && !ItemStack.isSameItemSameComponents(existing, itemstack))
		return amount;
	if (existing.isEmpty() && !container.canPlaceItem(slotId, itemstack))
		return amount;

	int maxStackSize = container.getMaxStackSize(existing.isEmpty() ? itemstack : existing);
	int availableSpace = maxStackSize - existing.getCount();
	if (availableSpace <= 0)
		return amount;

	int inserted = Math.min(amount, availableSpace);
	if (!simulate) {
		if (existing.isEmpty()) {
			container.setItem(slotId, itemstack.copyWithCount(inserted));
		} else {
			ItemStack updated = existing.copy();
			updated.grow(inserted);
			container.setItem(slotId, updated);
		}
		container.setChanged();
	}
	return amount - inserted;
}
