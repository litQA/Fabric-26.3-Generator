<#include "mcelements.ftl">
<#include "mcitems.ftl">
${JavaModName}NbtData.setBlockItemStack(world, ${toBlockPos(input$x, input$y, input$z)}, ${input$tagName}, ${mappedMCItemToItemStackCode(input$tagValue, 1)});
