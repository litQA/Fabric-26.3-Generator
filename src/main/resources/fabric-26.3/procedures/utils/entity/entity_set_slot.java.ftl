private static void setEntitySlot(Entity entity, int slot, ItemStack itemstack) {
	if (entity == null || slot < 0)
		return;
	ItemStack stack = itemstack.copy();
	if (entity instanceof Player player) {
		Container inventory = player.getInventory();
		if (slot < inventory.getContainerSize()) {
			inventory.setItem(slot, stack);
			inventory.setChanged();
		}
		return;
	}
	if (entity instanceof Container container) {
		if (slot < container.getContainerSize()) {
			container.setItem(slot, stack);
			container.setChanged();
		}
		return;
	}
	try {
		SlotAccess access = entity.getSlot(slot);
		if (access != null)
			access.set(stack);
	} catch (RuntimeException ignored) {
	}
}
