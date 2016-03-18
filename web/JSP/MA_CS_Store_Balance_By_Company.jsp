<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cmms.report.Print_Report_Store_Balance_By_Company"%>
<%@page import ="com.cmms.Util.ThaiUtil" %>
<%@page import="com.cmms.Util.PeriodDate"%>
<%
    Print_Report_Store_Balance_By_Company objdetail = new Print_Report_Store_Balance_By_Company();
    ThaiUtil en = new ThaiUtil();
    System.out.println("A_Company = " + request.getParameter("A_Company"));
    System.out.println("A_doc_date = " + request.getParameter("A_doc_date"));
    System.out.println("A_Part_Group = " + request.getParameter("A_Part_Group"));
    System.out.println("A_part_id = " + request.getParameter("A_part_id"));
    String Part_id = "-";
    if (!request.getParameter("A_part_id").equals("")) {
        Part_id = request.getParameter("A_part_id");
    }

    System.out.println("part_id = " + Part_id);

    PeriodDate period = new PeriodDate();
    String start_year = period.Start_Year("S");
%>
<%=objdetail.ShowDetail(request.getParameter("A_doc_date"), request.getParameter("A_Part_Group"), start_year, Part_id, request.getParameter("A_Company"))%>        