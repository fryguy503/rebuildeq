<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="https://www.facebook.com/2008/fbml"><head>
  <head>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta property="og:title" content="{$site->title}">
      <meta property="og:type" content="website">
      <meta property="twitter:account_id" content="4777423195">
      <meta itemprop="name" content="RebuildEQ">
      <meta itemprop="description" content="Rebuild EQ - A private Everquest server">
      <meta property="og:url" content="http://rebuildeq.com">
      <meta property="og:image" content="{$site->image}">
      <meta property="og:site_name" content="RebuildEQ.com">
      <meta property="og:description" content="{$site->description}">
      <meta name="description" content="{$site->description}">
      <meta name="author" content="Shin Noir, @rebuildeq">
    <title>{$site->title} | RebuildEQ</title>

    <!-- Bootstrap core CSS -->
    <link href="/public/prestige/css/bootstrap.css" rel="stylesheet">
    <link href="/public/prestige/css/theme.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/public/prestige/css/magnific-popup.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="/public/prestige/css/font-awesome.min.css" rel="stylesheet">

    <link href='http://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <script src="/public/prestige/js/modernizr.custom.js"></script>


    </head>
    
    <body>
            
            <!-- Main content starts -->
            {$content}
            <!-- Main content ends -->


        <!-- Template JS -->
        {if !empty($jsBotTemplate)}{$jsBotTemplate}{/if}
        <!-- Page JS -->
        {if !empty($jsBotPage)}{$jsBotPage}{/if}

    </body> 


      <footer class="bs-footer" role="contentinfo">
    <div class="container">
  Everquest is a registered trademark of Daybreak Game Company LLC.
  RebuildEQ.com is not associated or affiliated in any way with Daybreak Game Company LLC.
  Except where otherwise noted, this site is licensed under a Creative Commons License.
    </div>
  </footer>
</html>