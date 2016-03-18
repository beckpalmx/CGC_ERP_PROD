
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
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
    </head>
    <script type="text/javascript">
        function Chknull(){
            //alert(document.getElementById('price_year').value );
            //alert(document.getElementById('month_id').value );
            if (document.getElementById('price_year').value == '-' 
                    //|| document.getElementById('month_id').value == '-' 
                    ||document.getElementById('price_year').value == 'price_year' 
                    //|| document.getElementById('month_id').value == 'month_id')                
            {
                alert('กรุณาใส่เงื่อนไขให้ครบ');                                
            } else {
                document.report.submit();
            }
        }
    </script>    
    <body onunload="closepopup()">
        <form name="report" method="post" action="CS_dRawmatt_month.jsp" target="_blank">                                
            <% UtiDatabase objuti = new UtiDatabase();%>           
            <table  cellpadding="0"  cellspacing="0">             
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงานสรุป รับ/เบิก วัตถุดิบ&nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr>
                                <tr>   
                                <tr><td colspan='2'><b>กำหนดเงื่อนไข เพื่อประมวลผล </b></td></tr>                                
                                <tr>
                                    <td class="columnlabel"><b>ปี พ.ศ.*&nbsp;</b></td>                               
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select price_year from vmproduct_price_year order by price_year desc", "price_year", "price_year", "price_year", "price_year", "-")%>
                                    </td>
                                </tr>    
                                <tr>
                                    <td class="columnlabel"><b>เดือน *&nbsp;</b></td>                               
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select month_id from mmonth order by runno", "month_id", "month_id", "month_id", "month_id", "-")%>
                                    </td>
                                </tr>   

                                <tr>
                                    <td class="columnlabel"><b>กองที่(วัตถุดิบ)&nbsp;</b></td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select location_id,name_t,print_count,runno from vmlocation order by print_count desc ,runno desc", "location_id", "location_id", "location_id")%>&nbsp;</td>
                                    </td>
                                </tr>  

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
                        </div></td>
                    <td class="fcenterright"></td>
                </tr>
                <tr bordercolor="0069B3">
                    <td class="ffootleft"></td>
                    <td  class="ffootcenter" colspan="2"></td>
                    <td class="ffootright"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
