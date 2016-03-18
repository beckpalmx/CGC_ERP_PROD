
<%@page import="com.cgc.Util.Upload_Image"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
System.out.println("Uploads : " + request );                                        

Upload_Image obj_upload = new Upload_Image(request);
%>

<%="<script type=\"text/javascript\">window.parent.showResult("+obj_upload.Return_Status()+")</script>"%>