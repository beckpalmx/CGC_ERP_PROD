<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CGC Menu</title>
    </head>
    <script type=""  language="javascript" src="../JS/myAjaxFramework.js"></script>
    <script type="text/javascript" src="../JS/MENU.js"></script>
    <script type="text/javascript">var tWorkPath="../JS/menu/deluxe/deluxe-tree.files/";</script>
    <script type="text/javascript" src="../JS/menu/deluxe/deluxe-tree.files/dtree.js"></script>
    <script language="javascript" src="JS/myAjaxFramework.js"></script>
    <script language='javascript'>

        function linkpage(jsppage){
            var mfixcon="";
            with(document.btform){
                action = jsppage;
                submit();
            }
        }
        function Logout(){
            if(confirm('คุณต้องการออกจากระบบใช่หรือไม่')){
                document.submitForm.submit();
            }
        }

    </script>
    <%!        String menu;
    %>
    <%
                menu = (String) session.getAttribute("menu");
    %>
    <body bgcolor="#F7F7F7">
        <%if (!session.isNew()) {%>
        <form name="btform" target="mainFrame" method="post">
            <script type="text/javascript"><!--
                /*
           Deluxe Menu Data File
           Created by Deluxe Tuner v3.2
           http://deluxe-menu.com
                 */

                var path = "../JS/menu/deluxe/";

                // -- Deluxe Tuner Style Names
                var tstylesNames=["Individual Style","Individual Style","Individual Style","Individual Style",];
                var tXPStylesNames=["Individual Style",];
                // -- End of Deluxe Tuner Style Names

                //--- Common
                var tlevelDX=20;
                var texpanded=0;
                var texpandItemClick=0;
                var tcloseExpanded=1;
                var tcloseExpandedXP=1;
                var ttoggleMode=1;

                //--- Dimensions
                var tmenuWidth="290px";
                var tmenuHeight="";

                //--- Positioning
                var tabsolute=0 ;
                var tleft="";
                var ttop="";

                //--- Menu Appearance
                var tmenuBackColor="";
                var tmenuBackImage="";
                var tmenuBorderColor="#FFFFFF";
                var tmenuBorderWidth=0;
                var tmenuBorderStyle="solid";

                //--- Item Appearance & Font
                var tfontStyle="normal 8pt Tahoma";
                var tfontColor=["#3F3D3D","#7E7C7C"];
                var tfontDecoration=["none","underline"];
                var tfontColorDisabled="#ACACAC";
                var tpressedFontColor="#AA0000";
                var titemAlign="left";
                var titemHeight=22;
                var titemBackColor=["#F0F1F5","#F0F1F5"];
                var titemBackImage=["",""];
                var tnoWrap=1;

                //--- Icons & Buttons
                var ticonWidth=21;
                var ticonHeight=15;
                var ticonAlign="left";
                var texpandBtn=[path+"deluxe-tree.files/expandbtn2.gif",path+"deluxe-tree.files/expandbtn2.gif",path+"deluxe-tree.files/collapsebtn2.gif"];
                var texpandBtnW=9;
                var texpandBtnH=9;
                var texpandBtnAlign="left";

                //--- Lines
                var tpoints=0;
                var tpointsImage="";
                var tpointsVImage="";
                var tpointsCImage="";
                var tpointsBImage="";

                //--- Floatable Menu
                var tfloatable=1;
                var tfloatIterations=10;
                var tfloatableX=1;
                var tfloatableY=1;

                //--- Movable Menu
                var tmoveable=0;
                var tmoveHeight=12;
                var tmoveColor="transparent";
                var tmoveImage=path+"deluxe-tree.files/movepic.gif";

                //--- XP-Style
                var tXPStyle=1;
                var tXPIterations=10;
                var tXPBorderWidth=1;
                var tXPBorderColor="#FFFFFF";
                var tXPAlign="left";
                var tXPTitleBackColor="#AFB1C3";
                var tXPTitleBackImg=path+"deluxe-tree.files/xptitle_s.gif";
                var tXPTitleLeft=path+"deluxe-tree.files/xptitleleft_s.gif";
                var tXPTitleLeftWidth=4;
                var tXPIconWidth=31;
                var tXPIconHeight=32;
                var tXPMenuSpace=10;
                var tXPExpandBtn=[path+"deluxe-tree.files/xpexpand1_s.gif",path+"deluxe-tree.files/xpexpand1_s.gif",path+"deluxe-tree.files/xpcollapse1_s.gif",path+"deluxe-tree.files/xpcollapse1_s.gif"];
                var tXPBtnWidth=25;
                var tXPBtnHeight=23;
                var tXPFilter=1;

                //--- Advanced
                var tdynamic=0;
                var tajax=0;
                var titemCursor="default";
                var statusString="";
                var tblankImage=path+"deluxe-tree.files/blank.gif";
                var tpathPrefix_img="";
                var tpathPrefix_link="";
                var titemTarget="";

                //--- State Saving
                var tsaveState=0;
                var tsavePrefix="menu1";

                var tstyles = [
                    ["tfontStyle=bold 8pt Tahoma","tfontColor=#FFFFFF,#E6E6E6","tfontDecoration=none,none"],
                    ["tfontStyle=bold 8pt Tahoma","tfontColor=#3F3D3D,#7E7C7C","tfontDecoration=none,none"],
                    ["tfontDecoration=none,none"],
                    ["tfontStyle=bold 8pt Tahoma","tfontColor=#444444,#5555FF"],
                ];
                var tXPStyles = [
                    ["tXPTitleBackColor=#D9DAE2","tXPTitleBackImg=deluxe-tree.files/xptitle2_s.gif","tXPExpandBtn=deluxe-tree.files/xpexpand2_s.gif,deluxe-tree.files/xpexpand3_s.gif,deluxe-tree.files/xpcollapse2_s.gif,deluxe-tree.files/xpcollapse3_s.gif"],
                ];


                var tstyles = [
                    ["tfontStyle=bold 8pt Tahoma","tfontColor=#FFFFFF,#E6E6E6","tfontDecoration=none,none"],
                    ["tfontStyle=bold 8pt Tahoma","tfontColor=#3F3D3D,#7E7C7C","tfontDecoration=none,none"],
                    ["tfontDecoration=none,none"],
                    ["tfontStyle=bold 8pt Tahoma","tfontColor=#444444,#5555FF"],
                ];


                var tXPStyles = [
                    ["tXPTitleBackColor=#D9DAE2","tXPTitleBackImg="+path+"deluxe-tree.files/xptitle2_s.gif","tXPExpandBtn="+path+"deluxe-tree.files/xpexpand2_s.gif,"+path+"deluxe-tree.files/xpexpand3_s.gif,"+path+"deluxe-tree.files/xpcollapse2_s.gif,"+path+"deluxe-tree.files/xpcollapse3_s.gif"],
                ];


                var tmenuItems = [<%=menu%>];


                dtree_init();
                --></script>
        </form>
        <%} else {%>
        โปรด Login อีกครั้ง
        <div>
            <pre><a href="javascript:;" onClick="Logout()"><span class="style2"><img src="../IMAGES/exit_btn_48.png" width="21" height="21" border="0"/><strong>ออกจากระับบ</strong></span></a></pre>
        </div>
        <%}%>
    </body>
</html>
