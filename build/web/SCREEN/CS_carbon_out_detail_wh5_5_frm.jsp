
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                           

        <link rel="stylesheet" href="../CSS/checkbox/awesome-bootstrap-checkbox.css"/>     


        <script src="../JS/alertify/alertify.js"></script>        

        <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />

        <!-- alertify theme Section -->
        <!--link rel="stylesheet" href="../CSS/alertify/alertify.bootstrap.css"-->
        <link rel="stylesheet" href="../CSS/alertify/alertify.default.css">

        <link rel="stylesheet" href="../FONTS/css/font-awesome.css" />        
    </head>
    <script type="text/javascript">
        function Chknull() {
            //alert(document.getElementById('price_year').value );
            //alert(document.getElementById('month_id').value );
            if (document.getElementById('price_year').value == '-' || document.getElementById('month_id').value == '-' || document.getElementById('price_year').value == 'price_year' || document.getElementById('month_id').value == 'month_id')
            {
                alert('กรุณาใส่เงื่อนไขให้ครบ');
            } else {
                document.report.submit();
            }
        }
    </script>    
    <body onunload="closepopup()">
        <form name="report" method="post" action="CS_carbon_out_detail_wh5_5_1.jsp" target="_blank">  
            <% UtiDatabase objuti = new UtiDatabase();%>    

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>แสดงการสรุปถ่านเติมเตา ถ่านออกจากเตา ถ่านร่อนแยกขนาด (CS_carbon_out_detail_wh5_5_1)</b>
                        </div>                        
                        <div class="panel-footer">                              
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr>
                                <tr>                                
                                <tr><td colspan='2'><b>กำหนดเงื่อนไข เพื่อประมวลผล </b></td></tr>                                
                                <tr>
                                    <td class="columnlabel1"><b>ปี พ.ศ.*&nbsp;</b></td>                               
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select price_year from vmproduct_price_year order by price_year desc", "price_year", "price_year", "price_year", "price_year", "-")%>
                                    </td>
                                </tr>    
                                <tr>
                                    <td class="columnlabel1"><b>เดือน *&nbsp;</b></td>                               
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select month_id from mmonth order by runno", "month_id", "month_id", "month_id", "month_id", "-")%>
                                    </td>
                                </tr>   

                                <tr>
                                    <td class="columnlabel1"><b>เตาที่&nbsp;</b></td>
                                    <td class="columnobject">
                                        <input name='burn_no' type='text' class="inputs" id="burn_no" value='-' size='10' />
                                    </td>
                                </tr>  

                                <!--tr>
                                    <td class="columnlabel1"><b>กองที่(วัตถุดิบ)&nbsp;</b></td>
                                    <td class="columnobject">
                                <%=objuti.ShowSelectBox("select location_id,name_t,print_count,runno from vmlocation order by print_count desc ,runno desc", "location_id", "location_id", "location_id")%>&nbsp;</td>
                            </td>
                        </tr-->  

                                <tr>
                                    <td colspan='2' class='blankspace' align="center">

                                        <!--input type ="submit" class="myButton" style="width:120px;height: 30px;"  value ="ประมวลผล" onclick="Chknull()"-->
                                        <!--a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PROCESS_90.png" width="90" height="34" border="0"></a></div-->                                        
                                        <input type ="submit" class="cgcButton" style="width:120px;height: 30px;"  value ="ประมวลผล" onclick="Chknull()"></td>
                                    </td>
                                </tr>                                   
                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>                            
    </body>
</html>

