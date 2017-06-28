<table class="container_div display_table" style="width:100px">
	<tbody>
        <tr>
            <td style="vertical-align:top"><br>
            	<table width="100%"><tbody><tr><td valign="top"><table width="100%" cellpadding="0" cellspacing="0">
            		<tbody>
            			<tr><td colspan="2" nowrap="1"></td></tr>
            			<tr><td colspan="2"><b>Class: </b><span class="item_class">{if !empty($itemfocus)}{$itemfocus->classesString}{/if}</span></td></tr>
            			<tr><td colspan="2"><b>Race: </b><span class="item_race">{if !empty($itemfocus)}{$itemfocus->racesString}{/if}</span></td></tr></td></tr>
            			<tr><td colspan="2"><b><span class="item_slot">{if !empty($itemfocus)}{$itemfocus->slotsString}{/if}</span></td></tr></b></td></tr>
            		</tbody>
            	</table><br>
            	<table>
            		<tbody>
            			<tr valign="top"><td>
            				<table style="width: 125px;">
            					<tbody>
            						<tr><td><b>Size: </b></td><td class="item_size" style="text-align:right">{if !empty($itemfocus)}{$itemfocus->sizeString}{/if}</td></tr>
            						<tr><td><b>Weight: </b></td><td class="item_weight" style="text-align:right">{if !empty($itemfocus)}{$itemfocus->weight}{/if}</td></tr>
            						<tr><td><b>Item Type: </b></td><td class="item_type" style="text-align:right">{if !empty($itemfocus)}{$itemfocus->typeString}{/if}</td></tr>
            					</tbody>
            				</table>
            				</td><td>
            					<table style="width: 125px;">
            						<tbody>
            							<tr><td><b>AC: </b></td><td class="item_ac" style="text-align:right">{if !empty($itemfocus)}{$itemfocus->ac}{/if}</td></tr>
            						</tbody>
            					</table>
            				</td><td>
            					<table style="width: 125px;">
            						
            					</table>
            				</td>
            			</tr>
            			<tr><td colspan="2">&nbsp;</td></tr>
            			<tr valign="top">
            				<td><table style="width:100%"></table></td>
            				<td><table style="width:100%"></table></td>
            				<td><table style="width:100%"></table></td>
            			</tr>
            		</tbody>
            	</table><br>
            </td>
		</tr>		
		<tr><td><br><b>Value: </b>
            {if !empty($itemfocus) AND ($itemfocus->price % 1000 > 0)}<span class="item_platinum">{$itemfocus->price % 1000}</span> <img src="http://www.raidaddicts.org/Allah//images/icons/item_644.png" width="14" height="14"> {/if}
            {if !empty($itemfocus) AND ($itemfocus->price % 100 > 0)}<span class="item_gold">{$itemfocus->price % 100} <img src="http://www.raidaddicts.org/Allah//images/icons/item_645.png" width="14" height="14"></span> {/if}
            {if !empty($itemfocus) AND ($itemfocus->price % 10 > 0)}<span class="item_silver">{$itemfocus->price % 10} <img src="http://www.raidaddicts.org/Allah//images/icons/item_646.png" width="14" height="14"></span> {/if}
             {if !empty($itemfocus) AND ($itemfocus->price % 1 > 0)}<span class="item_copper">{$itemfocus->price % 1} <img src="http://www.raidaddicts.org/Allah//images/icons/item_647.png" width="14" height="14"></span> {/if}
            </td></tr>
		</tbody>
		</table><br></td>
		<td style="vertical-align:top"></td></tr>
	</tbody>
</table>
