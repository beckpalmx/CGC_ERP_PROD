<%@page import="com.cgc.bean.EmpBean"%>
<%@page import="com.cgc.DB.EmpDAO"%>
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
    <%!        EmpDAO empDAO = new EmpDAO();
        ArrayList<EmpBean> empList;
        String n,id;
        int chk;
        ThaiUtil tu;
    %>
    <%
                tu = new ThaiUtil();
                n = request.getParameter("by_name");
                id = request.getParameter("by_id");
                chk = Integer.parseInt(request.getParameter("chk"));
                if (chk == 0) {
                    empList = empDAO.selectDataAll();
                } else {
                    if (n.equals("")){
                        n = "-";
                    }if (id.equals("")){
                        id = "-";
                    }
                    empList = empDAO.selectDataSerBy(tu.EncodeTexttoTIS(n),id);
                }
    %>
</head>
<body>
    <form name="serForm" method="post" action="SearchEmployee.jsp">
        <input type="hidden" name="chk" value="0">
        <div style="width: 600px;">
            <table width="64%" cellpadding="0"  cellspacing="0">
                <tr >
                    <td width="20" class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงาน&nbsp;</td>
                    <td width="7" class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <table width="100%" cellpadding="0" cellspacing="0" >
                            <tr>
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
                            </tr>

                            <tr>
                              <td class="header2">&nbsp;</td>
                                <td width="27%" class="header2"><div align="left">รหัสพนักงาน</div></td>
                              <td width="63%" class="header2"><div align="center">ชื่อพนักงาน</div></td>
                          </tr>

                            <%
                            if(empList.size()==0){
                            %>
                            <tr>
                                <td colspan="2"> ไม่พบข้อมูล </td>
                                <td></td>
                            </tr>
                            <%
                            }
                            for (EmpBean empBean : empList) {
                            %>
                            <tr>
                              <td colspan="2" align="left"><a href="javascript:;" onclick="gettoShow('<%=empBean.getEmp_id()%>|<%=empBean.getFname()%>|<%=empBean.getLname()%>|<%=empBean.getRemark()%>|<%=empBean.getDept_id()%>|<%=empBean.getDept_name()%>|<%=empBean.getStatus()%>', 'emp_id|name|lname|remark|dept_id|dept_name|status')" class="link_transparent"><%=empBean.getEmp_id()%></a></td>
                                <td align="left"><%=empBean.getFullname()%></td>
                            </tr>
                            <%}%>
                        </table>
                    </td>
                    <td class="fcenterright"></td>
                </tr>
                <tr bordercolor="0069B3" style="height: 5px">
                    <td width="20" class="ffootleft"></td>
                    <td  class="ffootcenter" colspan="2" ></td>
                    <td width="7" class="ffootright"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
<script language="javascript">
    function chkDataSer(){
        document.serForm.chk.value = 1;
        document.serForm.submit();
    }
</script>
</html>
