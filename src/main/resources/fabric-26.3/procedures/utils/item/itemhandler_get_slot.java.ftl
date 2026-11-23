private static ItemStack getItemStackFromItemStackSlot(int slotID, ItemStack itemStack) {
	if (slotID < 0)
		return ItemStack.EMPTY;
	List<ItemStack> contents = itemStack.getOrDefault(DataComponents.CONTAINER, ItemContainerContents.EMPTY).itemCopies().toList();
	return slotID < contents.size() ? contents.get(slotID).copy() : ItemStack.EMPTY;
}
