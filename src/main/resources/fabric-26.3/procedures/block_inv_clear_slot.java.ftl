<#include "mcelements.ftl">
<#-- @formatter:off -->
if (world instanceof ServerLevel _serverLevel) {
	BlockEntity _be = _serverLevel.getBlockEntity(${toBlockPos(input$x, input$y, input$z)});
	int _slot = ${opt.toInt(input$slotid)};
	if (_be instanceof Container _container && _slot >= 0 && _slot < _container.getContainerSize()) {
		_container.setItem(_slot, ItemStack.EMPTY);
		_container.setChanged();
	}
}
<#-- @formatter:on -->
