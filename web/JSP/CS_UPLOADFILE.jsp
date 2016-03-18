
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page  import="com.cgc.DB.CS_UPLOAD"%>
<%
if(request.getParameter("delete_file") == null){

    CS_UPLOAD obj = new CS_UPLOAD();
    out.print("<div align='center'>"+obj.Image_Upload(request)+"</div>");
    out.print("<br><input type='button'  id='bt1' onClick=\"windows.close();\" value=' กลับสู่หน้าหลัก '/>");
    //location.replace(\'../SCREEN/CS_UPLOADFILE.jsp\')\
    }else{
    CS_UPLOAD obj = new CS_UPLOAD();
    obj.Delete_File(request.getParameter("delete_file"));
    }
%>