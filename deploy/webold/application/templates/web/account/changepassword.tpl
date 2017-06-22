{include file="../_header.tpl"}


<div id="intro">
        <div class="item background-cover" style="background: url('/public/prestige/img/bg/ec.jpg')">
          <div class="container">
            <div class="row">
            
              <div class="carousel-caption-center colour-white">          
              <div class="col-sm-offset-3 col-sm-5">
  <form data-toggle="validator" role="form">
  <div class="form-group">
    <label for="inputEmail" class="control-label">Email</label>
    <input type="email" class="form-control" id="inputEmail" placeholder="Email" data-error="Bruh, that email address is invalid" required>
    <div class="help-block with-errors"></div>
  </div>
  <div class="form-group">
    <label for="inputPassword" class="control-label">Password</label>
    <div class="form-inline row">
      <div class="form-group col-sm-6">
        <input type="password" data-minlength="6" class="form-control" id="inputPassword" placeholder="Password" required>
        <div class="help-block">Minimum of 6 characters</div>
      </div>
      <div class="form-group col-sm-6">
        <input type="password" class="form-control" id="inputPasswordConfirm" data-match="#inputPassword" data-match-error="Whoops, these don't match" placeholder="Confirm" required>
        <div class="help-block with-errors"></div>
      </div>
    </div>
  </div>
  <div class="form-group">
    <button type="submit" class="btn btn-primary">Submit</button>
  </div>
</form>
</div>

              </div>
            </div>
          </div>

          <div class="overlay-bg"></div>
        </div>
    </div>

    </section>
    
{*include file="../_footer.tpl"*}