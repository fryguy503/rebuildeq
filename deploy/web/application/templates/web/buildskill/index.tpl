<div class="panel">
                <div class="panel-heading">
                   <span class="panel-title">{$class|capitalize} Skills</span>
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
  			      	{foreach from=$skills item=skill key=s}
  			      	<tr>
				       	<td><a href="/builds/{$class}/skill/{$s}"><img src="{$skill->image}"/></a></td>
				       	<td>{$skill->title}</td>
				       	<td>{$skill->desc|strip_tags|truncate:150}</td>
			       	</tr>
		          	{/foreach}
		        	</tbody>
		        </table>
			</div>
</div>