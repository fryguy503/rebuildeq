<div class="col-sm-12 col-md-11 center-column mt25">
<div class="row">
	<div class="panel">
	                <div class="panel-heading">
	                {if !empty($skills)}
	                	<span class="panel-title">{$class|capitalize} Skills</span>						
	                {else}
	                   <span class="panel-title">{$class|capitalize}'s {$skill->title}</span>
	                {/if}
	                </div>
	                <div class="panel-body">
	                <table class="table footable table-striped">
				      <thead>
				        <tr>
					        <th>Icon</th>
					        <th>Name</th>
					        <th>Description</th>
				        </tr>
				      </thead>
	      				<tbody>
	      				{if !empty($skills)}
	      				{foreach from=$skills item=skill key=s}
						<tr>
					       	<td><a href="/builds/{$class}/skill/{$s}"><img src="{$skill->image}"/></a></td>
					       	<td>{$skill->title}</td>
					       	<td>{$skill->desc|strip_tags|truncate:150}</td>
				       	</tr>
				       	{/foreach}
	      				{else}
	  			      	<tr>
					       	<td><img src="{$skill->image}"/></td>
					       	<td>{$skill->title}</td>
					       	<td>{$skill->desc|strip_tags|truncate:150}</td>
				       	</tr>
				       	{/if}
			        	</tbody>
			        </table>
				</div>
	</div>
</div>
</div>