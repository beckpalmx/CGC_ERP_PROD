<%@page import="com.cgc.DB.PGroupDAO"%>
<%@page import="com.cgc.bean.PgroupBean"%>
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
    <%!        PGroupDAO pgDAO = new PGroupDAO();
        ArrayList<PgroupBean> pgList;
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
            pgList = pgDAO.selectDataAll();
        } else {
            if (n.equals("")) {
                n = "-";
            }
            if (id.equals("")) {
                id = "-";
            }
            pgList = pgDAO.selectDataSerBy(tu.EncodeTexttoTIS(n), id);
        }
    %>
</head>
<body>
    <form name="serForm" method="post" action="SearchProductGroup.jsp">
        <input type="hidden" name="chk" value="0">
        <br>
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-zoom-in" style="color:white"></span>&nbsp;<b>ค้นหาข้อมูล</b></div>
                <div class="panel-footer">          
                    <td  colspan="2" class="fcentercenter">
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
                                <td width="27%" class="header2"><div align="left">รหัสกลุ่มสินค้า</div></td>
                                <td width="63%" class="header2"><div align="center">ชื่อกลุ่มสินค้า</div></td>
                            </tr>

                            <%
                                if (pgList.size() == 0) {
                            %>
                            <tr>
                                <td colspan="2"> ไม่พบข้อมูล </td>
                                <td></td>
                            </tr>
                            <%
                                }
                                for (PgroupBean empBean : pgList) {
                            %>
                            <tr>
                                <td colspan="2" align="left"><a href="javascript:;" onclick="gettoShow('<%=empBean.getPgroup_id()%>|<%=empBean.getName_t()%>|<%=empBean.getRemark()%>', 'pgroup_id|name_t_pgroup|remark_pgroup')" class="link_transparent"><%=empBean.getPgroup_id()%></a></td>
                                <td align="left"><%=empBean.getName_t()%></td>
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
