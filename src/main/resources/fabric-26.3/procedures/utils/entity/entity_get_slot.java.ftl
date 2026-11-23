private static ItemStack getEntitySlot(Entity entity, int slot) {
	if (entity == null || slot < 0)
		return ItemStack.EMPTY;
	if (entity instanceof Player player) {
		Container inventory = player.getInventory();
		return slot < inventory.getContainerSize() ? inventory.getItem(slot).copy() : ItemStack.EMPTY;
	}
	if (entity instanceof Container container)
		return slot < container.getContainerSize() ? container.getItem(slot).copy() : ItemStack.EMPTY;
	try {
		SlotAccess access = entity.getSlot(slot);
		return access != null ? access.get().copy() : ItemStack.EMPTY;
	} catch (RuntimeException ignored) {
		return ItemStack.EMPTY;
	}
}
