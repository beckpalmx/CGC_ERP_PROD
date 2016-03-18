<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css"-->

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>             

    </head>
    <body onUnload="closepopup()">
        <%UserBean userbean = (UserBean) session.getAttribute("user");%>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="chkNull" value="name_t">
        <input type="hidden" id="status_u" value ="2">
        <input type = "hidden" id ="status_d" value ="3">

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                    <b>คืนเอกสาร (CS_RETURN_DOCUMENT)</b>
                </div>                

                <div class="panel-footer">          


                    <div class="list-group">
                        <a href='CS_RETURN_RAWMAT_REC.jsp?doc_type=1' class="list-group-item list-group-item-info">01 คืนเอกสารการรับถ่านวัตถุดิบ : data_rawmat_rec.txt</a>

                        <a href='CS_RETURN_PRODUCT.jsp?doc_type=2' class="list-group-item list-group-item-warning">02 คืนเอกสารการผลิตถ่านกัมมันต์ : data_prod_rec.txt</a>

                        <a href='CS_RETURN_CARBON_IN.jsp?doc_type=3' class="list-group-item list-group-item-danger">03 คืนเอกสารถ่านเติมเตา กลับไป ฝ่ายผลิต : data_carbon_in.txt</a>

                        <a href='CS_RETURN_CARBON_IN_WH.jsp?doc_type=4' class="list-group-item list-group-item-info">04 คืนเอกสารถ่านเติมเตา (ฝ่ายรับวัตถุดิบ) : data_carbon_in_wh.txt</a>

                        <a href='CS_RETURN_CARBON_OUT.jsp?doc_type=5' class="list-group-item list-group-item-warning">05 คืนเอกสารรายงานถ่านออกจากเตา : data_carbon_out.txt</a>

                        <a href='CS_RETURN_CARBON_WITHDRAW_TO_PRODUCTION.jsp?doc_type=6' class="list-group-item list-group-item-danger">06 คืนเอกสารการเบิกถ่านเพื่อผลิต : data_carbon_withdraw_to_production.txt</a>

                        <a href='CS_RETURN_PACKING_PRODUCT.jsp?doc_type=7' class="list-group-item list-group-item-info">07 คืนเอกสารการบรรจุถ่านกัมมันต์ : data_packing_product.txt</a>

                        <a href='CS_RETURN_CARBON_WITHDRAW_TO_EXPORT.jsp?doc_type=8' class="list-group-item list-group-item-warning">08 คืนเอกสารการเบิกถ่านเพื่อส่งออก : data_withdraw_product_to_export.txt</a>

                        <a href='CS_RETURN_RAWMAT_WITHDRAW.jsp?doc_type=9' class="list-group-item list-group-item-danger">09 คืนเอกสารการเบิกถ่านวัตถุดิบเพื่อรอเบิกสี : data_rawmat_withdraw.txt</a>

                        <a href='CS_RETURN_CARBON_FRICTION.jsp?doc_type=10' class="list-group-item list-group-item-info">10 คืนเอกสารการสีถ่าน : data_carbon_friction.txt</a>

                        <a href='CS_RETURN_RAWMAT_BIGBAG_WITHDRAW.jsp?doc_type=11' class="list-group-item list-group-item-warning">11 คืนเอกสารการเบิกถ่านวัตถุดิบถุงใหญ่ : data_rawmat_bigbag_withdraw.txt</a>

                        <a href='return_doc.pdf' class="list-group-item list-group-item-success">วิธีการใช้งาน</a>

                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
