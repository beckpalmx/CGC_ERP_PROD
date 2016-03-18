
<%@page import="com.cgc.upload.Uploadfile_rawmat"%>
<%@page import="com.cgc.FileManagement.Writer_Excel_POI"%>
<%@page import="com.cgc.FileManagement.Read_Excel_POI"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page  import="com.cgc.DB.CS_UPLOAD"%>
<%@page trimDirectiveWhitespaces="true" %>
<%@page import="java.sql.*"%>
<script>
    function goBack()
    {
        window.history.back();
    }
</script>
<%    
    String form_type = request.getParameter("form_type");
    //String form_type1 = (String)session.getAttribute("form_type");
    System.out.println("form_type = " + form_type);
    //System.out.println("form_type1 = " + form_type1);
    Uploadfile_rawmat obj_upload = new Uploadfile_rawmat();
    obj_upload.Uploadfile_Excel_To_DataBase(request,response);
    System.out.println("request = " + request);
    System.out.println("response = " + response);    
    String result = obj_upload.getResult();
    out.println(result);    
%>

<body>
<tr>
    <td class="columnlabel">&nbsp;</td>
    <td class="columnobject">    
        <button onclick="goBack()">OK</button>
    </td>
</tr>    
</body>