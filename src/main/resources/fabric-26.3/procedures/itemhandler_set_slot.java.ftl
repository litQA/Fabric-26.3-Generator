<#include "mcitems.ftl">
<#-- @formatter:off -->
{
	ItemStack _itemStack = ${mappedMCItemToItemStackCode(input$item, 1)};
	int _slotId = ${opt.toInt(input$slotid)};
	if (_slotId >= 0 && _slotId < ItemContainerContents.MAX_SIZE) {
		List<ItemStack> _contents = new ArrayList<>(_itemStack.getOrDefault(DataComponents.CONTAINER, ItemContainerContents.EMPTY).itemCopies().toList());
		while (_contents.size() <= _slotId)
			_contents.add(ItemStack.EMPTY);
		ItemStack _slotStack = ${mappedMCItemToItemStackCode(input$slotitem, 1)}.copy();
		if (!_slotStack.isEmpty()) {
			int _amount = Math.max(0, ${opt.toInt(input$amount)});
			_slotStack.setCount(Math.min(_amount, _slotStack.getItem().getDefaultMaxStackSize()));
			if (_slotStack.getCount() <= 0)
				_slotStack = ItemStack.EMPTY;
		}
		_contents.set(_slotId, _slotStack);
		if (!_itemStack.isEmpty())
			_itemStack.set(DataComponents.CONTAINER, ItemContainerContents.fromItems(_contents));
	}
}
<#-- @formatter:on -->
