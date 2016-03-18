<!DOCTYPE html>
<html>
<head>
  <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
  <script src="//code.jquery.com/jquery.min.js"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>  
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1">  
  <title>Honglub.com</title>
</head>
<body>
<div class="container">
  <h4 class="form-section">
    <i class="fa fa-pencil-square-o"></i>&nbsp;เพิ่ม/แก้ไขผู้ใช้ระบบ
  
  <hr />
  <form id="userForm" class="form-horizontal">
    <div class="form-group form-group-sm">
      <label class="control-label col-md-3">
        ชื่อ :
      </label>
      <div class="col-md-3">
        <input type="text" class="form-control input-medium input-sm" />
      </div>
    </div>
    <div class="form-group form-group-sm">
      <label class="control-label col-md-3">
        Login Name :
      </label>
      <div class="col-md-3">
        <input type="text" class="form-control input-medium input-sm" />
      </div>
    </div>
    <div class="form-group form-group-sm">
      <label class="control-label col-md-3">
        Password :
      </label>
      <div class="col-md-3">        
        <div class="input-group input-group-sm">
          <input type="password" class="form-control input-medium input-sm" />      
          <span class="input-group-addon">
            <i class="fa fa-user"></i>
          </span>
        </div>
      </div>
    </div>
    <div class="form-group form-group-sm">
      <label class="control-label col-md-3">
        Confirm Password :
      </label>
      <div class="col-md-3">
        <div class="input-group input-group-sm">
          <input type="password" class="form-control input-medium input-sm" />      
          <span class="input-group-addon">
            <i class="fa fa-user"></i>
          </span>
        </div>
      </div>
    </div>
    <div class="form-group form-group-sm">
      <label class="control-label col-md-3">
        สถานะ :
      </label>
      <div class="col-md-3">
        <select id="ddlStatus" class="form-control input-small input-sm">
          <option value="0">ใช้งาน</option>
          <option value="1">ไม่ใช้งาน</option>
        </select>
      </div>
    </div>
    <div class="form-group form-group-sm">
      <label class="control-label col-md-3">
        User Group :
      </label>
      <div class="col-md-3">
        <div class="checkbox">
          <label>
            <input type="checkbox" value="">
            Administrator
          </label>
        </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="">
            Requestor
          </label>
        </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="">
            Approver
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="col-md-offset-3 col-md-9">
        <button type="button" class="btn btn-sm btn-primary">บันทึก</button>&nbsp;    
        <button type="button" class="btn btn-sm btn-secondary">ยกเลิก</button>
      </div>
    </div>
  </form>
</div>
</body>
</html>
