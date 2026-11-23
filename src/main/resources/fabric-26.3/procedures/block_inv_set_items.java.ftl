<#include "mcelements.ftl">
<#include "mcitems.ftl">
<#-- @formatter:off -->
if (world instanceof ServerLevel _serverLevel) {
	BlockEntity _be = _serverLevel.getBlockEntity(${toBlockPos(input$x, input$y, input$z)});
	int _slot = ${opt.toInt(input$slotid)};
	int _amount = ${opt.toInt(input$amount)};
	if (_be instanceof Container _container && _slot >= 0 && _slot < _container.getContainerSize()) {
		ItemStack _setstack = ${mappedMCItemToItemStackCode(input$item, 1)}.copy();
		_setstack.setCount(Math.max(0, _amount));
		_container.setItem(_slot, _setstack);
		_container.setChanged();
	}
}
<#-- @formatter:on -->
