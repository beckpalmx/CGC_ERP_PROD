<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.DateUtil"%>
<%@page import="com.cgc.Util.PeriodDate"%>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="../JS/bootstrap/js/bootstrap.min.js"></script>

<link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">

 <script>

        var value = 0;

        function barAnim() {
            value += 5;
            $(".progress-bar").css("width", value + "%").attr("aria-valuenow", value);
            //if (value == 25 || value == 55 || value == 85) {
            if (value === 75 || value === 95) {
                return setTimeout(barAnim, 500);
            }
            //if (value >= 100) {
            //    alert(value + " % Complete");
            //}
            return value >= 100 || setTimeout(barAnim, 20);
        }

        setTimeout(barAnim, 20);
    </script>     


<%

    String current_date ,current_month,current_year , start_year , end_year  ,start_current_month ,end_current_month ;
    DateUtil ObjDate = new DateUtil();
    current_date = ObjDate.Return_Date_Now_full();
    current_month = ObjDate.Return_Month_Now();
    current_year = ObjDate.Return_Year_Now();
    System.out.println("current_date = " + current_date );
    System.out.println("current_Month = " + current_month + " | " + current_year);

    PeriodDate period = new PeriodDate();
    start_year = period.Start_Year("S");
    end_year = period.End_Year("S");
    
    start_current_month = period.Start_Current_Month(current_month);
    end_current_month = period.End_Current_Month(current_month);
    System.out.println("start_current_month = " + start_current_month );
    System.out.println("end_current_month = " + end_current_month );
    
%>