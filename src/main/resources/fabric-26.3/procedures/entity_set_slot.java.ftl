<#include "mcitems.ftl">
<@addTemplate file="utils/entity/entity_set_slot.java.ftl"/>
{
	ItemStack _slotStack = ${mappedMCItemToItemStackCode(input$slotitem, 1)}.copy();
	_slotStack.setCount(Math.max(0, ${opt.toInt(input$amount)}));
	setEntitySlot(${input$entity}, ${opt.toInt(input$slotid)}, _slotStack);
}
