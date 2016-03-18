<%@page import="com.cgc.bean.WarehouseBean"%>
<%@page import="com.cgc.DB.WareHouseDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    <script type=""  language="javascript" src="../JS/myAjaxFramework.js"></script>
    <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
    <script src="../JS/jquery/jquery-2.1.4.js"></script>
    <script src="../JS/bootstrap/js/bootstrap.min.js"></script>          

    <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
    <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
    <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
    <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">       

    <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
    <link href="../CSS/component.css" rel="stylesheet" type="text/css">    

    <%!        WareHouseDAO whDAO = new WareHouseDAO();
        ArrayList<WarehouseBean> whList;
        String n, id;
        int chk;
        ThaiUtil tu;
    %>
    <%
        tu = new ThaiUtil();
        n = request.getParameter("by_name");
        id = request.getParameter("by_id");
        chk = Integer.parseInt(request.getParameter("chk"));
        if (chk == 0) {
            whList = whDAO.selectDataAll();
        } else {
            if (n.equals("")) {
                n = "-";
            }
            if (id.equals("")) {
                id = "-";
            }
            whList = whDAO.selectDataSerBy(tu.EncodeTexttoTIS(n), id);
        }
    %>
</head>
<body>
    <form name="serForm" method="post" action="SearchWareHouse.jsp">
        <input type="hidden" name="chk" value="0">
        <br>
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-zoom-in" style="color:white"></span>&nbsp;<b>ค้นหาข้อมูล</b></div>
                <div class="panel-footer">                
                    <table width="100%" cellpadding="0" cellspacing="0" >
                        <!--tr>
                            <td colspan="4"  class="blankspace"></td>
                        </tr>

                        <tr>
                            <td height="22" align="right" valign="middle">ชื่อ :&nbsp;</td>
                            <td colspan="2" align="left"><input type='text' class="inputs" name="by_name" value="" size="40"/>
                                <a href="javascript:;" ><img src="../IMAGES/BUTTON/MAIN/SEARCH20.png" width="17" height="17" border="0" onClick="chkDataSer()"></a></td>
                        </tr>
                        <tr>
                            <td width="10%" align="right" valign="middle">ID :&nbsp;</td>
                            <td colspan="2" align="left"><label>
                                    <input type='text' class="inputs" name="by_id" value="" size="40"/>
                                </label></td>
                        </tr>

                        <tr>
                            <td colspan="4" align="center">&nbsp;</td>
                        </tr-->
                        
                        <tr>
                            <td colspan="4" align="right">
                                <button type="button" class="btn btn-danger" data-toggle="tooltip" title="ปิดหน้าต่าง" onClick="javascript:window.close();"><b>ปิด</b></button>
                            </td>
                        </tr>

                        <tr>
                            <td class="header2">&nbsp;</td>
                            <td width="27%" class="header2"><div align="left">รหัสคลังสินค้า</div></td>
                            <td width="63%" class="header2"><div align="center">ชื่อคลังสินค้า</div></td>
                        </tr>

                        <%
                            if (whList.size() == 0) {
                        %>
                        <tr>
                            <td colspan="2"> ไม่พบข้อมูล </td>
                            <td></td>
                        </tr>
                        <%
                            }
                            for (WarehouseBean whBean : whList) {
                        %>
                        <tr>
                            <td colspan="2" align="left"><a href="javascript:;" onclick="gettoShow('<%=whBean.getWarehouse_id()%>|<%=whBean.getName_t()%>|<%=whBean.getRemark()%>', 'warehouse_id|name_t_warehouse|remark_wh')" class="link_transparent"><%=whBean.getWarehouse_id()%></a></td>
                            <td align="left"><%=whBean.getName_t()%></td>
                        </tr>
                        <%}%>
                    </table>                    
                </div>
            </div>
        </div>
    </form>
</body>
<script language="javascript">
    function chkDataSer() {
        document.serForm.chk.value = 1;
        document.serForm.submit();
    }
</script>
</html>
