<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.bean.DataBean_Mcompany"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dTD">
<html>
    <head>
        <link rel="shortcut icon" href="IMAGES/URL/cgc_logo.ico" >
        <link rel="icon" type="image/gif" href="IMAGES/URL/cgc_logo.gif" >        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="pragma" content="no-cache" />
        <title>ERP</title>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>

        <script src="../JS/alertify/alertify.min.js"></script>        
        <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />
        <link rel="stylesheet" href="../CSS/alertify/alertify.default.css" />        

    </head>
    <%
        UserBean userbean = (UserBean) session.getAttribute("user");
        DataBean_Mcompany dataBean_Mcompany = (DataBean_Mcompany) session.getAttribute("name_t");
        System.out.println("Session Header = " + session.getAttribute("session_id"));
    %>
    <script language='javascript'>

        function linkpage(jsppage) {
            var mfixcon = "";
            with (document.btform) {
                action = jsppage;
                submit();
            }
        }

        function Logout() {
            if (confirm('คุณต้องการออกจากระบบใช่หรือไม่')) {
                document.submitForm.submit();
            }
        }

        var StayAlive = 1; // เวลาเป็นวินาทีที่ต้องการให้ WIndows ปิด

        function KillMe() {
            setTimeout("self.close()", StayAlive * 1000);
            window.opener.location.reload();
        }


        function startTime()
        {
            var today = new Date();
            var h = today.getHours();
            var m = today.getMinutes();
            var s = today.getSeconds();
// add a zero in front of numbers<10
            m = checkTime(m);
            s = checkTime(s);
            document.getElementById('time_text').innerHTML = h + ":" + m + ":" + s;
            t = setTimeout(function() {
                startTime();
            }, 500);
        }

        function checkTime(i)
        {
            if (i < 10)
            {
                i = "0" + i;
            }
            return i;
        }

        function Calc()
        {
            window.open("calculator.jsp", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=100, left=100, width=400, height=400");
        }

    </script>

    <head>
    <BODY onload="startTime()"BGCOLOR="#F7F7F7" LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 onLoad="KillMe();
            self.focus();
            window.opener.location.reload();" >
        <input type="hidden" id="logout"/>
        <TABLE BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
            <TR>
                <TD COLSPAN=11 align="center"><img src="../IMAGES/HEADER/MAIN_9.png"/></TD>
            </TR>
            <TR valign="top">
                <TD width="40">&nbsp;</TD>
                <TD COLSPAN=5 align="center" valign="top">
                    <form name="submitForm" target="_top" action="../JSP/Logout.jsp">
                        <div>
                            <pre><a href="javascript:;" onClick="Logout()"><span class="style2"><img src="../IMAGES/exit_btn_48.png" width="21" height="21" border="0"/><strong>ออกจากระบบ </strong></span></a>
                            <a href="javascript:;" onClick="Calc()"><strong>เครื่องคิดเลข</strong></a> </pre>

                            <!--script language="javascript">MyDate('tha')</script><div id="time_text"-->
                        </div>
                    </form>                
                </TD>

                <TD>

                </TD> 
                <TD width="350"><div align="left"><marquee behavior="scroll" direction="left"><%=userbean.getMessage_disp()%> *** <%=dataBean_Mcompany.getName_t()%> ***</marquee></div></TD>
                <TD width="430" valign="middle" class="company"><div align="right">                        
                        ผู้ใช้ : <%=userbean.getUsername()%> &nbsp; <%=userbean.getFullname()%> 
                        <!--script language="javascript">MyDate('tha')</script-->
                        <%=userbean.getSelect_database()%>
                    </div>                                          
                </TD>                
                <TD width="200" valign="middle" class="company">
                    <div align="right">
                        <!--ฐานข้อมูล : <%=userbean.getSelect_database()%> &nbsp;-->                                          
                        <script language="javascript">MyDate('tha');</script><div id="time_text">                            
                        </div>
                    </div>
                <TD width="96" class="columnobject">                    
                    <p align="right">&nbsp;</p></div>               
                    <!--%=session.getAttribute("session_id")%-->
                </TD>
            </TR>
        </TABLE>
    </BODY>
</head>
</html>