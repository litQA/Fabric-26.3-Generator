<#include "mcitems.ftl">
${JavaModName}NbtData.setEntityItemStack(${input$entity}, ${input$tagName}, ${mappedMCItemToItemStackCode(input$tagValue, 1)});
