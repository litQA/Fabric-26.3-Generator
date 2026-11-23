<#-- @formatter:off -->
{
	Entity _entityIter = ${input$entity};
	Container _containerIter = null;
	if (_entityIter instanceof Player _playerIter) {
		_containerIter = _playerIter.getInventory();
	} else if (_entityIter instanceof Container _entityContainer) {
		_containerIter = _entityContainer;
	}
	if (_containerIter != null) {
		for (int _idx = 0; _idx < _containerIter.getContainerSize(); _idx++) {
			ItemStack itemstackiterator = _containerIter.getItem(_idx).copy();
			${statement$foreach}
		}
	}
}
<#-- @formatter:on -->
