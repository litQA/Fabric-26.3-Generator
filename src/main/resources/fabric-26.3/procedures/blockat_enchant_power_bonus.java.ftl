<#include "mcelements.ftl">
<#-- @formatter:off -->
private static int getEnchantPowerBonus(LevelAccessor world, BlockPos pos) {
	Block _block = world.getBlockState(pos).getBlock();
	if (_block == Blocks.BOOKSHELF)
		return 1;
	<#list types.blocks?filter(e -> e.enchantPowerBonus gt 0) as block>
	if (_block == ${JavaModName}Blocks.${block.getModElement().getRegistryNameUpper()})
		return ${block.enchantPowerBonus?round};
	</#list>
	return 0;
}

/*@float*/(getEnchantPowerBonus(world, ${toBlockPos(input$x, input$y, input$z)}))
<#-- @formatter:on -->
