<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.UserBean"%>
<!DOCTYPE HTML>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CGC ERP</title>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function Cancelvalue() {
                cancelAction();
                getId("lookup_name").value = "";
                getId("delete_flag").value = "";
                getId("complete_flag").value = "";
                getId("retro_flag").value = "";
                getId("cancel_flag").value = "";
                getId("runno_from").value = "";
                getId("runno_to").value = "";
                getId("date_from_format").value = "";
                getId("date_to_format").value = "";
            }
            function Action_Export() {
                var chk_export_id = false, chk_doc_id = false, chk_doc_date = false;
                //******************check export_id***************************
                if (getId("export_id").value == "") {
                    alert("กรุณาระบุชื่อที่ต้องการจะ Export");
                } else {
                    chk_export_id = true;
                }
                //******************check doc_from  and doc_to ***************************
                if (getId("doc_id_from").value == "" && getId("doc_id_to").value == "") {
                    chk_doc_id = true;
                } else if (getId("doc_id_from").value != "" && getId("doc_id_to").value == "" || getId("doc_id_from").value == "" && getId("doc_id_to").value != "") {
                    alert("กรุณาเลือกรหัส/เลขที่เอกสารให้ครบ");
                } else {
                    if (parseInt(getId("runno_from").value) > parseInt(getId("runno_to").value)) {
                        alert("คุณเลือกลำดับเอกสารผิดอาจทำให้ไม่ได้ข้อมูลที่ต้องการกรุณาเลือกลำดับข้อมูลใหม่");
                    } else {
                        chk_doc_id = true;
                    }
                }
                //******************check doc_date ***************************
                if (getId("date_from").value != "" && getId("date_to").value == "" || getId("date_from").value == "" && getId("date_to").value != "") {
                    alert("กรุณาเลือกวันที่ให้ครบ");
                } else if (getId("date_from").value != "" && getId("date_to").value != "") {
                    if (ChkDate(getId("date_from").value, getId("date_to").value)) {
                        alert("คุณใส่วันที่ไม่ถูกต้อง...กรุณาตรวจสอบอีกครั้ง");
                    } else {
                        getId("date_from_format").value = getId("date_from").value != "" ? format_Date(getId("date_from").value) : "";
                        getId("date_to_format").value = getId("date_to").value != "" ? format_Date(getId("date_to").value) : "";
                        chk_doc_date = true;
                    }
                } else {
                    chk_doc_date = true;
                }
                if (chk_export_id && chk_doc_id && chk_doc_date) {
                    //alert("สำเร็จ");
                    document.exportfile.submit();
                }
            }
            function Open_Doc_id_from() {
                //alert(math_str_flag());
                (getId("export_id").value == "") ? alert("กรุณาเลือกรหัสที่ต้องการ Export") :
                        openBrWindow(getId("lookup_name").value + "&stadment=" + math_str_flag() + "&textinput=runno_from|doc_id_from", 53, "../SEARCHSCREEN/Search_Detail.jsp");
            }
            function Open_Doc_id_to() {
                //alert(math_str_flag());
                (getId("export_id").value == "") ? alert("กรุณาเลือกรหัสที่ต้องการ Export") :
                        openBrWindow(getId("lookup_name").value + "&stadment=" + math_str_flag() + "&textinput=runno_to|doc_id_to", 53, "../SEARCHSCREEN/Search_Detail.jsp");
            }
            function math_str_flag() {
                var return_str = "";
                var str_math = new Array;
                str_math[0] = getId("complete_flag").value != "" ? "complete_flag+=+\'" + getId("complete_flag").value + "\'" : "";
                str_math[1] = getId("retro_flag").value != "" ? "retro_flag+=+\'" + getId("retro_flag").value + "\'" : "";
                str_math[2] = getId("cancel_flag").value != "" ? "cancel_flag+=+\'" + getId("cancel_flag").value + "\'" : "";
                //str_math[3] = getId("delete_flag").value != "" ?"delete_flag+=+\'"+getId("delete_flag").value+"\'":"";
                for (var i = 0; i < str_math.length; i++) {
                    return_str += str_math[i] != "" ? "and+" + str_math[i] + "+" : "";
                }
                return return_str;
            }
        </script>
    </head>
    <body onUnload="">
        <form name="exportfile" method="post" action="../JSP/CS_053_01.jsp" >
            <% UtiDatabase objuti = new UtiDatabase();%>
            <input type="hidden" name="type_report"  value="4">
            <input type="hidden" name="complete_flag" id="complete_flag"  value="">
            <input type="hidden" name="retro_flag" id="retro_flag"  value="">
            <input type="hidden" name="cancel_flag" id="cancel_flag"  value="">
            <input type="hidden" name="delete_flag" id="delete_flag"  value="">
            <input type="hidden" name="lookup_name" id="lookup_name"  value="">
            <input type="hidden" name="date_from_format" id="date_from_format" value="">
            <input type="hidden" name="date_to_format" id ="date_to_format" value="">
            <table  cellpadding="0"  cellspacing="0">

                <tr>

                <input type="button" class="cgcButton" name="myBut" value=" BT_  " onClick="Action_Export()"/>

                <br>                    
                <br>                    
                <input type="button" class="cgcButton_2" name="myBut" value=" BT__2  " onClick="Cancelvalue()"/>   
                <br>
                <br>                    
                <input type="button" class="cgcButton_3" name="myBut" value=" BT__3  " onClick="Action_Export()"/>
                <br>
                <br>                    
                <input type="button" class="cgcButton_4" name="myBut" value=" BT__4  " onClick="Cancelvalue()"/>              
                <br>
                <br>
                <input type="button" class="cgcButton_5" name="myBut" value=" BT__5  " onClick="Action_Export()"/>
                <br><br>
                <input type="button" class="cgcButton_6" name="myBut" value=" BT__6  " onClick="Cancelvalue()"/>    
                <br><br>
                <input type="button" class="cgcButton_7" name="myBut" value=" BT__7  " onClick="Action_Export()"/>
                <br><br>
                <input type="button" class="cgcButton_8" name="myBut" value=" BT__8  " onClick="Cancelvalue()"/>    
                <br><br>
                <input type="button" class="cgcButton_9" name="myBut" value=" BT__9  " onClick="Action_Export()"/>
                <br><br>
                <input type="button" class="cgcButton_10" name="myBut" value=" BT__10  " onClick="Cancelvalue()"/>  
                <br><br>
                <input type="button" class="cgcButton_11" name="myBut" value=" BT__11  " onClick="Action_Export()"/>
                <br><br>
                <input type="button" class="cgcButton_12" name="myBut" value=" BT__12  " onClick="Cancelvalue()"/>
                <br><br>
                <input type="button" class="cgcButton_13" name="myBut" value=" BT__13  " onClick="Action_Export()"/>
                <br><br>
                <input type="button" class="cgcButton_14" name="myBut" value=" BT__14  " onClick="Cancelvalue()"/>                    
                <br><br>
                <input type="button" class="cgcButton_15" name="myBut" value=" BT__15  " onClick="Cancelvalue()"/>                    
                <br><br>
                <input type="button" class="cgcButton_16" name="myBut" value=" BT__16  " onClick="Cancelvalue()"/>      
                <br><br>
                <input type="button" class="cgcButton_17" name="myBut" value=" BT__17  " onClick="Cancelvalue()"/>      
                <br><br>
                <input type="button" class="cgcButton_18" name="myBut" value=" BT__18  " onClick="Cancelvalue()"/>                      
                <br><br>
                <input type="button" class="cgcButton_19" name="myBut" value=" BT__19  " onClick="Cancelvalue()"/>                      
                
                
                </tr>                
                <tr>
                    <td colspan='4' class='blankspace' ></td>
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
