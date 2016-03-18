<!DOCTYPE html>
<html>

<head>
  <script data-require="jquery@*" data-semver="2.1.1" src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
  <link data-require="bootstrap@*" data-semver="3.2.0" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.css" />
  <script data-require="bootstrap@*" data-semver="3.2.0" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.js"></script>

  <link rel="stylesheet" href="style.css" />
  <script src="script.js"></script>
</head>

<body>
  <form id="cusPayment" name="cusPayment" method="post" action="#">
    <input id="accid" name="accid" type="hidden" value="">
    <input id="statid" name="statid" type="hidden" value="">
    <input id="amt" name="amt" type="hidden" value="">
    <input id="lflag" name="lflag" type="hidden" value="E">
  </form>
  <a data-toggle="modal" data-target="#loginModal" href="#" class="btn-green pay-btn" id='paynow'>Pay Bill Now<i class="fa fa-chevron-right"></i></a>
  <div>
  </div>

  <div class="modal fade pay-now" id="loginModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-top">
      <div class="modal-content self-content">
        <div class="modal-header remove-border">
          <button type="button" class="close-btn" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body popup-copy">
          <div class="col-sm-10 popup-title">Confirm Payment Amount</div>
        </div>
      </div>
    </div>
  </div>
  <script>
    $(document).ready(function() {
      $("#paynow").click(function(event) {
        event.preventDefault();

        //$("#cusPayment").submit();
        //this submits the page, you want to show a modal window not another page
      })
    })
  </script>
</body>

</html>
