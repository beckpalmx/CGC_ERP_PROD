<%!
public class MyProfilex {
	
	public String displayName() {
		
		return "Win";
		
    }
	
	public String displayFullname() {
		
		return "Mr.Pongsak Phaotip";
		
    }
	
}
%>
<%@page import="MyProfilex"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <%	MyProfile profile = new MyProfile();
                out.print(profile.displayName());
                out.print("<br>");
                out.print(profile.displayFullname());
        %>
    </body>
</html>
