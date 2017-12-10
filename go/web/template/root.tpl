<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- Page title -->
    <title>{{.Site.Title}}</title>

    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    <!--<link rel="shortcut icon" type="image/ico" href="favicon.ico" />-->

    <!-- Vendor styles -->
    <link rel="stylesheet" href="/vendor/fontawesome/css/font-awesome.css" />
    <link rel="stylesheet" href="/vendor/metisMenu/dist/metisMenu.css" />
    <link rel="stylesheet" href="/vendor/animate.css/animate.css" />
    <link rel="stylesheet" href="/vendor/bootstrap/dist/css/bootstrap.css" />

    <!-- App styles -->
    <link rel="stylesheet" href="/fonts/pe-icon-7-stroke/css/pe-icon-7-stroke.css" />
    <link rel="stylesheet" href="/fonts/pe-icon-7-stroke/css/helper.css" />
    <link rel="stylesheet" href="/styles/style.css">
    <link rel="stylesheet" href="/styles/builds.css" />
</head>
<body class="light-skin fixed-navbar sidebar-scroll">
    {{ template "body" .}}
<!--[if lt IE 7]>
<p class="alert alert-danger">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->




<!-- Vendor scripts -->
<script src="/vendor/jquery/dist/jquery.min.js"></script>
<script src="/vendor/jquery-ui/jquery-ui.min.js"></script>
<script src="/vendor/slimScroll/jquery.slimscroll.min.js"></script>
<script src="/vendor/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/vendor/metisMenu/dist/metisMenu.min.js"></script>
<script src="/vendor/iCheck/icheck.min.js"></script>
<script src="/vendor/sparkline/index.js"></script>
<!-- App scripts -->
<script src="/scripts/homer.js"></script>

<script>

    $(function () {

        $('#fixed-navbar').click(function(){
            if($('body').hasClass('fixed-navbar')) {
                $('body').removeClass('fixed-navbar');
                $('.status-fixed-navbar').html("Off");

                if($('body').hasClass('sidebar-scroll')) {
                    $('body').removeClass('sidebar-scroll');
                    $('#navigation').slimScroll({destroy: true});
                    $('#navigation').attr('style', '');
                    $('.status-fixed-sidebar').html("Off")
                }

                if($('body').hasClass('fixed-small-header')) {
                    $('body').removeClass('fixed-small-header');
                    $('.status-fixed-small-header').html("Off")
                }

            } else {
                $('body').addClass('fixed-navbar');
                $('.status-fixed-navbar').html("<span class='text-success font-bold'>On</span>");
                $('body').removeClass('boxed');
                $('.status-boxed-layout').html("Off")
            }
        });

        $('#fixed-sidebar').click(function(){

            if($('body').hasClass('sidebar-scroll')) {
                $('body').removeClass('sidebar-scroll');
                $('#navigation').slimScroll({destroy: true});
                $('#navigation').attr('style', '');
                $('.status-fixed-sidebar').html("Off")
            } else {
                $('body').addClass('fixed-navbar');
                $('body').addClass('sidebar-scroll');
                $('#navigation').slimScroll({
                    height: '100%',
                    opacity: 0.3,
                    size : 0,
                    wheelStep : 10
                });
                $('.status-fixed-navbar').html("<span class='text-success font-bold'>On</span>");
                $('.status-fixed-sidebar').html("<span class='text-success font-bold'>On</span>");
                $('body').removeClass('boxed');
                $('.status-boxed-layout').html("Off")
            }
        });

        $('#fixed-footer').click(function(){
            if($('body').hasClass('fixed-footer')) {
                $('body').removeClass('fixed-footer');
                $('.status-fixed-footer').html("Off");
            } else {
                $('body').addClass('fixed-footer');
                $('.status-fixed-footer').html("<span class='text-success font-bold'>On</span>");
                $('body').removeClass('boxed');
                $('.status-boxed-layout').html("Off")
            }
        });

        $('#fixed-small-header').click(function(){

            if($('body').hasClass('fixed-small-header')) {
                $('body').removeClass('fixed-small-header');
                $('body').removeClass('sidebar-scroll');
                $('#navigation').slimScroll({destroy: true});
                $('#navigation').attr('style', '');
                $('body').removeClass('fixed-navbar');
                $('.status-fixed-small-header').html("Off");
                $('.status-fixed-sidebar').html("Off");
                $('.status-fixed-navbar').html("Off")
            } else {
                $('body').addClass('fixed-navbar');
                $('body').addClass('sidebar-scroll');
                $('#navigation').slimScroll({
                    height: '100%',
                    opacity: 0.3,
                    size : 0,
                    wheelStep : 10
                });
                $('body').addClass('fixed-small-header');
                $('.status-fixed-navbar').html("<span class='text-success font-bold'>On</span>");
                $('.status-fixed-sidebar').html("<span class='text-success font-bold'>On</span>");
                $('.status-fixed-small-header').html("<span class='text-success font-bold'>On</span>");
                $('body').removeClass('boxed');
                $('.status-boxed-layout').html("Off")
            }
        });

        $('#boxed-layout').click(function(){
            if($('body').hasClass('boxed')) {
                $('body').removeClass('boxed');
                $('.status-boxed-layout').html("Off")
            } else {
                $('body').addClass('boxed');
                $('.status-boxed-layout').html("<span class='text-success font-bold'>On</span>");
                $('body').removeClass('fixed-small-header');
                $('body').removeClass('sidebar-scroll');
                $('#navigation').slimScroll({destroy: true});
                $('#navigation').attr('style', '');
                $('body').removeClass('fixed-navbar');
                $('body').removeClass('fixed-footer');
                $('.status-fixed-small-header').html("Off");
                $('.status-fixed-footer').html("Off");
                $('.status-fixed-sidebar').html("Off");
                $('.status-fixed-navbar').html("Off");
            }
        });

    });

</script>

</body>
</html>