{include file="../_header.tpl"}
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
<link href="/css/builds/builds.css" rel="stylesheet" type="text/css">
  <div class="container">

	<div class="row" style="margin-top:60px;">

		

	    {if !empty($errorMessage)}
 		<div class="row">
			<form class="well bs-component">
				<div class="form-group">
				<p>{$errorMessage}</p>
		        </div>
		    </form>
		</div>
	    {/if}

	     <div class="row">
			<form class="well bs-component">
				<div class="form-group">
					<a href="/builds/bard"><img class="classicon" src="/images/classicons/brd.png"/></a>
					<a href="/builds/cleric"><img class="classicon" src="/images/classicons/clr.png"/></a>
					<a href="/builds/druid"><img class="classicon" src="/images/classicons/dru.png"/></a>
					<a href="/builds/enchanter"><img class="classicon" src="/images/classicons/enc.png"/></a>
					<a href="/builds/magician"><img class="classicon" src="/images/classicons/mag.png"/></a>
					<a href="/builds/monk"><img class="classicon" src="/images/classicons/mnk.png"/></a>
					<a href="/builds/necromancer"><img class="classicon" src="/images/classicons/nec.png"/></a>
					<a href="/builds/paladin"><img class="classicon" src="/images/classicons/pal.png"/></a>
					<a href="/builds/ranger"><img class="classicon" src="/images/classicons/rng.png"/></a>
					<a href="/builds/rogue"><img class="classicon" src="/images/classicons/rog.png"/></a>
					<a href="/builds/shadowknight"><img class="classicon" src="/images/classicons/shd.png"/></a>
					<a href="/builds/shaman"><img class="classicon" src="/images/classicons/shm.png"/></a>
					<a href="/builds/warrior"><img class="classicon" src="/images/classicons/war.png"/></a>
					<a href="/builds/wizard"><img class="classicon" src="/images/classicons/wiz.png"/></a>
		        </div>
		    </form>
		</div>

		<div class="row" style="text-align:left;">
	        	<ul class="breadcrumb">
	          		<li><a href="/builds">Builds</a></li>
	          		<li><a href="/builds/{$class}">{$class|capitalize}</a></li>
	          		<li class="active">{$skill->title}</li>
	        	</ul>
	    </div>

		<div class="row">
			<form class="well bs-component">
				<div class="form-group" style="height: 400px; padding: 20px; text-align: center;">
					<div class="col-md-2">
						<div class="skill-card">
			          		<label class="control-label">{$skill->title}</label><br>
			         		<img src="{$skill->image}">
		         		</div>
		         	</div>
					<div class="col-md-10">
			         	<div class="skill-card">
							<div class="description">{$skill->desc}</div>							
						</div>
					</div>
					<iframe style="display:block; margin: 0 auto;" width="560" height="315" src="https://www.youtube.com/embed/x9enpEIFzJk" frameborder="0" allowfullscreen></iframe>
		        </div>
		    </form>
		</div>


		
	</div>
  </div>
 </div>
		    </form>
		</div>