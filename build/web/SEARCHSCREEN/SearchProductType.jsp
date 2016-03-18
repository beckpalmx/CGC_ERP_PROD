<%@page import="com.cgc.bean.PtypeBean"%>
<%@page import="com.cgc.DB.PTypeDAO"%>
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
    <%!        PTypeDAO ptDAO = new PTypeDAO();
        ArrayList<PtypeBean> ptList;
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
            ptList = ptDAO.selectDataAll();
        } else {
            if (n.equals("")) {
                n = "-";
            }
            if (id.equals("")) {
                id = "-";
            }
            ptList = ptDAO.selectDataSerBy(tu.EncodeTexttoTIS(n), id);
        }
    %>
</head>
<body>
    <form name="serForm" method="post" action="SearchProductType.jsp">
        <input type="hidden" name="chk" value="0">
        <br>
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-zoom-in" style="color:white"></span>&nbsp;<b>���Ң�����</b></div>
                <div class="panel-footer">          
                    <table width="100%" cellpadding="0" cellspacing="0" >
                        <tr>
                            <td colspan="4"  class="blankspace"></td>
                        </tr>

                        <tr>
                            <td height="22" align="right" valign="middle">���� :&nbsp;</td>
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
                        </tr>

                        <tr>
                            <td class="header2">&nbsp;</td>
                            <td width="27%" class="header2"><div align="left">���ʻ������Թ���</div></td>
                            <td width="63%" class="header2"><div align="center">���ͻ������Թ���</div></td>
                        </tr>

                        <%
                            if (ptList.size() == 0) {
                        %>
                        <tr>
                            <td colspan="2"> ��辺������ </td>
                            <td></td>
                        </tr>
                        <%
                            }
                            for (PtypeBean ptypeBean : ptList) {
                        %>
                        <tr>
                            <td colspan="2" align="left"><a href="javascript:;" onclick="gettoShow('<%=ptypeBean.getPtype_id()%>|<%=ptypeBean.getName_t()%>|<%=ptypeBean.getRemark()%>', 'ptype_id|name_t_ptype|remark_ptype')" class="link_transparent"><%=ptypeBean.getPtype_id()%></a></td>
                            <td align="left"><%=ptypeBean.getName_t()%></td>
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
