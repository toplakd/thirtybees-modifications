<div class="mobile_button_container">

    <!--Left Float Buttons -->
    <div class="alza-nav-buttons-left">
        <!--Toggle Button Home -->
        <div class="alza-toggle-button-width">
                <button class="alza-toggle-button" onclick="menu_toggle5()" >
                    <i class="icon-home"></i>
                </button>
        </div>

        <!--Toggle Button Categories mobile -->
        <div class="alza-toggle-button-width">
            <button class="alza-toggle-button toggle-2nd-color" onclick="menu_toggle1()">
                <i class="icon-search"></i>
            </button>
        </div>
    </div>

    <!--Right Float Buttons -->
    <div class="alza-nav-buttons-right">
        <!--Toggle Button Shopping Login -->
        <div class="alza-toggle-button-width alza-toggle-button-user">
            <button class="alza-toggle-button " onclick="menu_toggle3()">
                <i class="icon-user"></i>
            </button>
        </div>
    <!--Toggle Button Cart -->
        <div class="alza-toggle-button-width">
            <button class="alza-toggle-button toggle-2nd-color " onclick="menu_toggle2()">
                <i class="icon-cart-arrow-down"></i>
            </button>
        </div>

    </div>

</div>
        
<!--Sidebar1 Categories/Search -->
<div id="mySidebar1">
    <div class="sidebar-blocks">
            {hook h= 'displayTop' mod= 'blocksearch' }
            {hook h= 'displayRightColumn'} 
    </div>
</div>

<!--Sidebar2 BlockCart -->
<!--is added directly into blockcart.tpl template -->


<!--Sidebar3 User/CMS -->
<div id="mySidebar3">
    <div class="alza-user-login-dropdown">
    {capture name='displayNav'}{hook h='displayNav'}{/capture}
    <ul>{$smarty.capture.displayNav}</ul>
        <div class="w3-sidebar-blockcms">
            {hook h= 'displayLeftColumn' mod= 'blockmyaccount'}
            {hook h= 'displayLeftColumn' mod= 'blockcms'}
        </div>
    </div>
</div>

<script>

   function menu_toggle0() {
            $("#mySidebar1").removeClass('active');
            $("#mySidebar2").removeClass('active');
            $("#mySidebar3").removeClass('active');
            $("#mySidebar4").removeClass('active');
            document.getElementById("myOverlay").style.display = "none"; 
            document.body.style.overflowY = "auto";
   }

   function menu_toggle1() {
            $("#mySidebar2").removeClass('active');
            $("#mySidebar3").removeClass('active');
            $("#mySidebar4").removeClass('active');
        if ( $("#mySidebar1").hasClass('active') ) {
            $("#mySidebar1").removeClass('active');
            document.getElementById("myOverlay").style.display = "none"; 
            document.body.style.overflowY = "auto";
        } else { 
            $("#mySidebar1").addClass('active');
            document.getElementById("myOverlay").style.display = "block"; 
            document.body.style.overflow = "hidden";
        }
    }

   function menu_toggle2() {
            $("#mySidebar1").removeClass('active');
            $("#mySidebar3").removeClass('active');
            $("#mySidebar4").removeClass('active');
        if ( $("#mySidebar2").hasClass('active') ) {
            $("#mySidebar2").removeClass('active');
            document.getElementById("myOverlay").style.display = "none"; 
            document.body.style.overflowY = "auto";
        } else { 
            $("#mySidebar2").addClass('active');
            document.getElementById("myOverlay").style.display = "block"; 
            document.body.style.overflow = "hidden";
        }
    }

   function menu_toggle3() {
            $("#mySidebar1").removeClass('active');
            $("#mySidebar2").removeClass('active');
            $("#mySidebar4").removeClass('active');
        if ( $("#mySidebar3").hasClass('active') ) {
            $("#mySidebar3").removeClass('active');
            document.getElementById("myOverlay").style.display = "none"; 
            document.body.style.overflowY = "auto";
        } else { 
            $("#mySidebar3").addClass('active');
            document.getElementById("myOverlay").style.display = "block"; 
            document.body.style.overflow = "hidden";
        }
    }
    
   function menu_toggle4() {
            $("#mySidebar1").removeClass('active');
            $("#mySidebar2").removeClass('active');
            $("#mySidebar3").removeClass('active');
        if ( $("#mySidebar4").hasClass('active') ) {
            $("#mySidebar4").removeClass('active');
            document.getElementById("myOverlay").style.display = "none"; 
            document.body.style.overflowY = "auto";
        } else { 
            $("#mySidebar4").addClass('active');
            document.getElementById("myOverlay").style.display = "block"; 
            document.body.style.overflow = "hidden";
        }
    }

   function menu_toggle5() {
            $("#mySidebar1").removeClass('active');
            $("#mySidebar2").removeClass('active');
            $("#mySidebar3").removeClass('active');
            $("#mySidebar4").removeClass('active');
            document.getElementById("myOverlay").style.display = "none"; 
            document.body.style.overflowY = "auto";
            window.location = "/index.php";
   }

</script>
                