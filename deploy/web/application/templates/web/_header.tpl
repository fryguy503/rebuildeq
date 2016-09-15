
    <!-- NAVBAR
    ================================================== -->
    <div class="navbar-wrapper cbp-af-header">
      <div class="container">

        <!-- Fixed navbar -->
        <div class="navbar cbp-af-inner" role="navigation">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <h1><a class="navbar-brand scroll" href="/">Rebuild Everquest</a></h1>
            </div>
            <div class="navbar-collapse collapse">
              <ul class="nav navbar-nav pull-right">
                <li>{if $page != "about"}<a class="signup" href="/about/">About</a>{else}<a>About</a>{/if}</li>
                <li>{if $page != "builds"}<a class="signup" href="/builds/">Builds</a>{else}<a>Builds</a>{/if}</li>
                <li>{if $page != "chat"}<a class="signup" href="/chat/">Sign Up</a>{else}<a>Sign Up</a>{/if}</li>

                <li class="dropdown {if $page != 'guide'}current{/if}">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Guides <span class="caret"></span></a>
                  <ul class="dropdown-menu" role="menu">
                  <li><a href="/guide/card/" class="external {if $page == 'guide' and $action == 'card'}signup{/if}">Card Augments</a></li>
                    {*<li><a href="/guide/setup/" class="external {if $page == 'guide' and $action == 'setup'}signup{/if}">Setting Up RebuildEQ</a></li>
                    <li><a href="/guide/newbie/" class="external {if $page == 'guide' and $action == 'newbie'}signup{/if}">Adventurer's Guide</a></li>
                    <li><a href="/guide/command/" class="external {if $page == 'guide' and $action == 'command'}signup{/if}">Custom Commands</a></li>
                    
                    <li><a href="/guide/encounter/" class="external {if $page == 'guide' and $action == 'encounter'}signup{/if}">Encounter Events</a></li>
                    <li><a href="/guide/rested/" class="external {if $page == 'guide' and $action == 'rested'}signup{/if}">Rested Experience</a></li>*}
                    <li><a href="/changelog/" class="external {if $page == 'changelog'}signup{/if}">Changelog</a></li>
                    <li><a href="/donate/" class="external {if $page == 'donate'}signup{/if}">Donate</a></li>
                  </ul>
                </li>

                  {*<li>{if $page != "changelog"}<a class="signup" href="/changelog/">Changelog</a>{else}<a>Changelog</a>{/if}</li>*}
                {*<li>{if $page != "donate"}<a class="signup" href="/donate/">Donate</a>{else}<a>Donate</a>{/if}</li>*}
                {*<li><a class="nav-online-count" href="/online/">{$characterCount} Players</a></li>*}


              </ul>
            </div>
          </div>
        </div>

      </div>
    </div>

