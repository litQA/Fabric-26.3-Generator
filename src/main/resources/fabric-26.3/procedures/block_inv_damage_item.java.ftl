<#include "mcelements.ftl">
<#-- @formatter:off -->
if (world instanceof ServerLevel _serverLevel) {
	BlockEntity _be = _serverLevel.getBlockEntity(${toBlockPos(input$x, input$y, input$z)});
	int _slot = ${opt.toInt(input$slotid)};
	int _amount = ${opt.toInt(input$amount)};
	if (_be instanceof Container _container && _slot >= 0 && _slot < _container.getContainerSize() && _amount > 0
			&& !_container.getItem(_slot).isEmpty()) {
		ItemStack[] _result = {_container.getItem(_slot).copy()};
		_result[0].hurtAndBreak(_amount, _serverLevel, null, _newStack -> _result[0] = _newStack);
		_container.setItem(_slot, _result[0]);
		_container.setChanged();
	}
}
<#-- @formatter:on -->
