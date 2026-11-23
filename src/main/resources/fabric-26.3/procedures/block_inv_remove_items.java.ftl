<#include "mcelements.ftl">
<#-- @formatter:off -->
if (world instanceof ServerLevel _serverLevel) {
	BlockEntity _be = _serverLevel.getBlockEntity(${toBlockPos(input$x, input$y, input$z)});
	int _slot = ${opt.toInt(input$slotid)};
	int _amount = ${opt.toInt(input$amount)};
	if (_be instanceof Container _container && _slot >= 0 && _slot < _container.getContainerSize() && _amount > 0) {
		ItemStack _stack = _container.getItem(_slot).copy();
		_stack.shrink(Math.min(_amount, _stack.getCount()));
		_container.setItem(_slot, _stack);
		_container.setChanged();
	}
}
<#-- @formatter:on -->
