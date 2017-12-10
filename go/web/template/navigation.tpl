<!-- Navigation -->
<aside id="menu">
    <div id="navigation">
        <div class="profile-picture">
            <a href="index.html">
                <img src="/images/profile.jpg" class="img-circle m-b" alt="logo">
            </a>

            <div class="stats-label text-color">
                <span class="font-extra-bold font-uppercase">Robert Razer</span>

                <div class="dropdown">
                    <a class="dropdown-toggle" href="components.html#" data-toggle="dropdown">
                        <small class="text-muted">Founder of App <b class="caret"></b></small>
                    </a>
                    <ul class="dropdown-menu animated flipInX m-t-xs">
                        <li><a href="contacts.html">Contacts</a></li>
                        <li><a href="profile.html">Profile</a></li>
                        <li><a href="analytics.html">Analytics</a></li>
                        <li class="divider"></li>
                        <li><a href="login.html">Logout</a></li>
                    </ul>
                </div>


                <div id="sparkline1" class="small-chart m-t-sm"></div>
                <div>
                    <h4 class="font-extra-bold m-b-xs">
                        $260 104,200
                    </h4>
                    <small class="text-muted">Your income from the last year in sales product X.</small>
                </div>
            </div>
        </div>

        <ul class="nav" id="side-menu">
            <li class="{{if eq .Site.Page "changelog"}}active{{end}}"><a href="/changelogs"> <span class="nav-label">Changelog</span></a></li>
            <li class="{{if eq .Site.Page "build"}}active{{end}}"><a href="/build"> <span class="nav-label">Build</span></a></li>
            <li class="{{if eq .Site.Page "npc"}}active{{end}}"><a href="/npc/10001"> <span class="nav-label">NPC</span></a></li>
            <li class="{{if eq .Site.Page "zone"}}active{{end}}"><a href="/zone/chart"> <span class="nav-label">Zone</span></a></li>
            <li class="{{if eq .Site.Page "item"}}active{{end}}"><a href="/item/1001"> <span class="nav-label">Item</span></a></li>
            <li class="{{if eq .Site.Page "inventory"}}active{{end}}"><a href="/inventory/661861"> <span class="nav-label">Inventory</span></a></li>
            <li class="{{if eq .Site.Page "character"}}active{{end}}"><a href="/character/661861"> <span class="nav-label">Character</span></a></li>
        </ul>
    </div>
</aside>