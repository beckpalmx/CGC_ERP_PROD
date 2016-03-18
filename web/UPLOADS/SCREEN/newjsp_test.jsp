<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>

<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.DateUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>


<html>
    <head>
        <title>Bootstrap Case</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

    </head>
    <body>

        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">CGC ERP</a>
                </div>
                <div>
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                        <li><a href="#">Page 1</a>
                        <li>
                            <a href="#">Page 1.1</a>
                        </li>
                        </li>
                        <li><a href="#">Page 2</a></li>
                        <li><a href="#">Page 3</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="jumbotron">
                <h1></h1>      
                <p></p>      
                <a href="#" class="btn btn-info btn-lg"><span class="glyphicon glyphicon-search"></span> Search</a>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <p>Number 1</p>
                </div>
                <div class="col-md-3"> 
                    <p>Number 2</p>
                </div>
                <div class="col-md-3"> 
                    <p>Number 3</p>
                </div>


                <%
                    DBConnect db = new DBConnect();
                    Connection Conn = db.openNewConnection();
                    String SQL_User = "";
                    String priviledge_id = "";
                    Statement STateMent = null;

                    SQL_User = "select * from vmuser_account where username = 'admin' and password = 'Systemadmin007' ";

                    STateMent = Conn.createStatement();
                    ResultSet rec_user = STateMent.executeQuery(SQL_User);

                    while (rec_user != null && (rec_user.next())) {

                        System.out.println(rec_user.getString("priviledge_id") + " | " + rec_user.getString("priviledge_id"));

                        priviledge_id = rec_user.getString("priviledge_id");
                    }

                    SQL_User = "select * from mpriviledge where priviledge_id = '" + priviledge_id + "'"
                            + " order by sub_menu_id ";

                    STateMent = Conn.createStatement();
                    ResultSet rec_priviledge = STateMent.executeQuery(SQL_User);

                    ArrayList<String> sub_menu_id = new ArrayList<String>();                    

                    while (rec_priviledge != null && (rec_priviledge.next())) {
                        System.out.println("sub_menu_id = " + rec_priviledge.getString("sub_menu_id"));
                        sub_menu_id = new ArrayList<String>(Arrays.asList(rec_priviledge.getString("sub_menu_id").split(",")));
                    }

                    for (int i = 0; i < sub_menu_id.size(); i++) {
                        System.out.println("sub_menu_id[" + i + "]" + sub_menu_id.get(i));
                    }


                %>

                <div class="col-md-3">
                    <ul class="nav nav-pills nav-stacked">
                        <li class="active"><a href="#">Home</a></li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Menu 1 <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Submenu 1-1</a></li>
                                <li><a href="#">Submenu 1-2</a></li>
                                <li><a href="#">Submenu 1-3</a></li>                        
                            </ul>
                        </li>
                        <li><a href="#">Menu 2</a></li>+

                        <li><a href="#">Menu 3</a></li>
                    </ul>
                </div>

                <div class="clearfix visible-lg"></div>
            </div>
        </div>

    </body>
</html>
