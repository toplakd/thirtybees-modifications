<div class="authentication_container">
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#account_login_form">{l s='Sign in'}</a></li>
    <li><a data-toggle="tab" href="#account_create_form">{l s='Create an account'}</a></li>
  </ul>

  <div class="tab-content">


    <div id="account_login_form" class="tab-pane fade in active">
        <form action="{$link->getPageLink('authentication', true)|escape:'html':'UTF-8'}" method="post" id="login_form" class="box">
          <h3 class="page-subheading">{l s='Already registered?'}</h3>
          <div class="form_content clearfix">
            <div class="form-group">
              <label for="email">{l s='Email address'}</label>
              <input class="is_required validate account_input form-control" data-validate="isEmail" type="email" id="email" name="email" value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}" required>
            </div>
            <div class="form-group">
              <label for="passwd">{l s='Password'}</label>
              <input class="is_required validate account_input form-control" type="password" data-validate="isPasswd" id="passwd" name="passwd" value="" required>
            </div>
            <div class="lost_password form-group"><a href="{$link->getPageLink('password')|escape:'html':'UTF-8'}" title="{l s='Recover your forgotten password'}" rel="nofollow">{l s='Forgot your password?'}</a></div>
            <div class="submit">
              {if isset($back)}<input type="hidden" class="hidden" name="back" value="{$back|escape:'html':'UTF-8'}">{/if}
              <button type="submit" id="SubmitLogin" name="SubmitLogin" class="btn btn-lg btn-success">
                <i class="icon icon-sign-in"></i> {l s='Sign in'}
              </button>
            </div>
          </div>
        </form>
    </div>


    <div id="account_create_form" class="tab-pane fade">
      {include './authentication-create.tpl'}
    </div>

  </div>
</div>

<style>
.authentication_container {
    width: 100%;
    max-width:400px;
    margin: auto;
}

.authentication_container .nav-tabs {
    border: 0px;
    margin-bottom: 10px;
}

.authentication_container .nav-tabs > li.active > a,
.authentication_container .nav-tabs > li.active > a:hover,
.authentication_container .nav-tabs > li.active > a:focus {
    color: #fff;
    background-color: #428bce;
    cursor: default;
}

.authentication_container .nav-tabs > li > a {
    margin-right: 2px;
    line-height: 1.42857143;
    border: 1px solid transparent;
    border-radius: 5px;
    padding: 5px;
}

.authentication_container #account-creation_form .form-control {
    width: 100%;
    max-width: 400px;
}

.authentication_container #account_login_form {
    text-align: center;
}

.authentication_container #login_form .form-control {
    margin: auto;
}

</style>