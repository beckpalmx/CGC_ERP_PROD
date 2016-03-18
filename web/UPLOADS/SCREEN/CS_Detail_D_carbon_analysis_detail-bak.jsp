
<%@page import="com.cgc.bean.DataBeand_carbon_send_product_detail"%>
<%@page import="com.cgc.DB.CS_D_carbon_analysis_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<!--%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%-->
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">

        </script>
        <script type="text/javascript">

            function passvaluechk() {
                if (getId("valuepass").value == "Y") {
                    getId("pass").checked = true;
                    getId("n_pass").checked = false;
                } else if (getId("valuepass").value == "N") {
                    getId("pass").checked = false;
                    getId("n_pass").checked = true;
                } else {
                    getId("pass").checked = false;
                    getId("n_pass").checked = false;
                }
            }

            function goAdd()
            {
                //
                //alert("Add");                    
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    //alert("ADD");
                    //getSave(URLsend('doc_id,line_no,job_id,product_id,size_name,iodine,machine_id,pallet,product_no,bag_quatity,bag_weight,weight,status_a,I_status,username', '../JSP/CS_Detail_D_carbon_send_product.jsp'));


                    getSave(URLsend('doc_id,line_no,doc_date,status_a,job_id,doc_type,job_type,product_id,size_name,iodine,machine_id,pallet,product_no,bag_quatity,bag_weight,weight,wh_id,location_id,wh_product_id,fraction,h2o,butane,iod,psd_1,psd_2,psd_3,psd_4,psd_5,psd_6,psd_7,psd_8,psd_9,psd_10,psd_11,psd_12,psd_13,psd_14,psd_15,psd_1_header,psd_2_header,psd_3_header,psd_4_header,psd_5_header,psd_6_header,psd_7_header,psd_8_header,psd_9_header,psd_10_header,psd_11_header,psd_12_header,psd_13_header,psd_14_header,psd_15_header,valuepass,grade,remark,param_header_id', '../JSP/CS_Detail_D_carbon_analysis_detail.jsp'));
                    //opener.showdetail();
                    showTable("show", "doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=");', 800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {

                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    //getSave(URLsend('doc_id,line_no,job_id,product_id,size_name,iodine,machine_id,pallet,product_no,bag_quatity,bag_weight,weight,status_a,I_status,username', '../JSP/CS_Detail_D_carbon_send_product.jsp'));
                    getSave(URLsend('username,lab_emp_id,doc_id,doc_date,line_no,status_u,doc_type,job_type,job_id,product_id,size_name,iodine,machine_id,pallet,product_no,bag_quatity,bag_weight,weight,wh_id,location_id,wh_product_id,fraction,h2o,butane,iod,psd_1,psd_2,psd_3,psd_4,psd_5,psd_6,psd_7,psd_8,psd_9,psd_10,psd_11,psd_12,psd_13,psd_14,psd_15,psd_1_header,psd_2_header,psd_3_header,psd_4_header,psd_5_header,psd_6_header,psd_7_header,psd_8_header,psd_9_header,psd_10_header,psd_11_header,psd_12_header,psd_13_header,psd_14_header,psd_15_header,valuepass,grade,remark,param_header_id', '../JSP/CS_Detail_D_carbon_analysis_detail.jsp'));
                    showTable("show", "doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=");', 800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goBack()
            {
                window.close();
            }

            function OpenConfirm(table, URL, dept_id) {
                var dept_id1, dept_id2, status;
                dept_id1 = '06';
                status = 'Y';
                //table += "&stadment=and+(dept_id+=+\'" + dept_id1 + "\'+or+dept_id+=+\'" + dept_id2 + ")\'+and+status+=+\'" + status + "\'"            
                table += "&stadment=and+dept_id+=+\'" + dept_id1 + "\'+and+status+=+\'" + status + "\'"
                openBrWindow(table, 315, URL);
            }

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>          

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">            

    </head>
    <body onLoad="passvaluechk()">
        <!--body onLoad=""-->
        <%! ThaiUtil en = new ThaiUtil();
            UtiDatabase uti = new UtiDatabase();
            CS_D_carbon_analysis_detailDAO objDAO = new CS_D_carbon_analysis_detailDAO();
            DataBeand_carbon_send_product_detail objBean = new DataBeand_carbon_send_product_detail();
            String dept_id, doc_type, complete_flag, chk_dept, runno, doc_id, doc_date, line_no, status_a, status_u, I_status, U_status, job_id, product_id, size_name, iodine, machine_id, pallet, product_no, bag_quatity, bag_weight, weight, wh_id, location_id, wh_product_id, fraction, job_type;
            String h2o, h2o_header, iod, iod_header, butane, butane_header, valuepass, pass, pass_header, n_pass, n_pass_header, grade, grade_header, remark, remark_header;
            String lab_emp_id, lab_emp_name, wh_iodine, name_t_product, param_header_id, psd_1, psd_1_header, psd_2, psd_2_header, psd_3, psd_3_header, psd_4, psd_4_header, psd_5, psd_5_header, psd_6, psd_6_header, psd_7, psd_7_header, psd_8, psd_8_header, psd_9, psd_9_header, psd_10, psd_10_header, psd_11, psd_11_header, psd_12, psd_12_header, psd_13, psd_13_header, psd_14, psd_14_header, psd_15, psd_15_header;
        %>
        <%
            doc_id = "";
            doc_date = "";
            line_no = "";
            I_status = "";
            U_status = "";
            status_a = "";
            status_u = "";
            job_id = "";
            product_id = "";
            size_name = "";
            iodine = "";
            machine_id = "";
            pallet = "";
            product_no = "";
            bag_quatity = "0";
            bag_weight = "0";
            weight = "0";
            wh_id = "";
            location_id = "";
            wh_product_id = "";
            fraction = "";
            job_type = "";
            doc_type = "";
            h2o = "";
            butane = "";
            iod = "";
            h2o_header = "";
            butane_header = "";
            iod_header = "";
            psd_1 = "";
            psd_2 = "";
            psd_3 = "";
            psd_4 = "";
            psd_5 = "";
            psd_6 = "";
            psd_7 = "";
            psd_8 = "";
            psd_9 = "";
            psd_10 = "";
            psd_11 = "";
            psd_12 = "";
            psd_13 = "";
            psd_14 = "";
            psd_15 = "";
            psd_1_header = "";
            psd_2_header = "";
            psd_3_header = "";
            psd_4_header = "";
            psd_5_header = "";
            psd_6_header = "";
            psd_7_header = "";
            psd_8_header = "";
            psd_9_header = "";
            psd_10_header = "";
            psd_11_header = "";
            psd_12_header = "";
            psd_13_header = "";
            psd_14_header = "";
            psd_15_header = "";
            valuepass = "";
            pass = "";
            pass_header = "";
            n_pass = "";
            n_pass_header = "";
            grade = "";
            grade_header = "";
            remark = "";
            remark_header = "";
            param_header_id = "";
            name_t_product = "";
            wh_iodine = "0";
            lab_emp_id = "";
            lab_emp_name = "";

            dept_id = request.getParameter("dept_id");
            chk_dept = "0";
            if ((request.getParameter("dept_id").equals("05")) || request.getParameter("dept_id").equals("006")) {
                chk_dept = "1";
                //out.print("I1");
            } else if (request.getParameter("dept_id").equals("002")) {
                chk_dept = "2";
                //out.print("I2");
            }

            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.Return_Edit(doc_id, line_no);
                doc_date = objBean.getDoc_date();
                job_id = objBean.getJob_id();
                product_id = objBean.getProduct_id();
                size_name = objBean.getSize_name();
                iodine = objBean.getIodine();
                machine_id = objBean.getMachine_id();
                pallet = objBean.getPallet();
                product_no = objBean.getProduct_no();
                bag_quatity = objBean.getBag_quatity();
                bag_weight = objBean.getBag_weight();
                weight = objBean.getWeight();
                wh_id = objBean.getWh_id();
                location_id = objBean.getLocation_id();
                wh_product_id = objBean.getWh_product_id();
                fraction = objBean.getFraction();
                job_type = objBean.getJob_type();
                complete_flag = objBean.getComplete_flag();
                doc_type = objBean.getDoc_type();
                h2o = objBean.getH2o();
                butane = objBean.getButane();
                iod = objBean.getIod();
                h2o_header = objBean.getH2o_header();
                butane_header = objBean.getButane_header();
                iod_header = objBean.getIod_header();
                psd_1 = objBean.getPsd_1();
                psd_2 = objBean.getPsd_2();
                psd_3 = objBean.getPsd_3();
                psd_4 = objBean.getPsd_4();
                psd_5 = objBean.getPsd_5();
                psd_6 = objBean.getPsd_6();
                psd_7 = objBean.getPsd_7();
                psd_8 = objBean.getPsd_8();
                psd_9 = objBean.getPsd_9();
                psd_10 = objBean.getPsd_10();
                psd_11 = objBean.getPsd_11();
                psd_12 = objBean.getPsd_12();
                psd_13 = objBean.getPsd_13();
                psd_14 = objBean.getPsd_14();
                psd_15 = objBean.getPsd_15();
                psd_1_header = objBean.getPsd_1_header();
                psd_2_header = objBean.getPsd_2_header();
                psd_3_header = objBean.getPsd_3_header();
                psd_4_header = objBean.getPsd_4_header();
                psd_5_header = objBean.getPsd_5_header();
                psd_6_header = objBean.getPsd_6_header();
                psd_7_header = objBean.getPsd_7_header();
                psd_8_header = objBean.getPsd_8_header();
                psd_9_header = objBean.getPsd_9_header();
                psd_10_header = objBean.getPsd_10_header();
                psd_11_header = objBean.getPsd_11_header();
                psd_12_header = objBean.getPsd_12_header();
                psd_13_header = objBean.getPsd_13_header();
                psd_14_header = objBean.getPsd_14_header();
                psd_15_header = objBean.getPsd_15_header();
                pass = objBean.getPass();
                pass_header = objBean.getPass_header();
                n_pass = objBean.getN_pass();
                valuepass = objBean.getPass();
                n_pass_header = objBean.getN_pass_header();
                grade = objBean.getGrade();
                grade_header = objBean.getGrade_header();
                remark = objBean.getRemark();
                remark_header = objBean.getRemark_header();
                param_header_id = objBean.getParam_header_id();
                name_t_product = objBean.getProd_name();
                wh_iodine = objBean.getWh_iodine();
                lab_emp_id = objBean.getLab_emp_id();
                lab_emp_name = objBean.getLab_emp_name();

                //out.println("emp id = " + lab_emp_id);
                if (lab_emp_id.equals("")) {
                    lab_emp_id = request.getParameter("emp_id");
                    lab_emp_name = en.EncodeTexttoTIS(request.getParameter("emp_fullname"));
                } else {
                    lab_emp_id = objBean.getLab_emp_id();
                    lab_emp_name = objBean.getLab_emp_name();
                }

                //out.println("Update doc_type = " + doc_type);
                status_u = "2";
                U_status = "2";

            } else {
                doc_id = en.EncodeTexttoTIS(request.getParameter("A_doc_id"));
                doc_date = en.EncodeTexttoTIS(request.getParameter("A_doc_date"));
                doc_type = request.getParameter("A_doc_type");
                job_type = en.EncodeTexttoTIS(request.getParameter("A_job_type"));

                int statusnum = 0;
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_analysis_all_detail where doc_id = '" + doc_id + "' and delete_flag <> 'Y' ");
                line_no = Integer.toString(statusnum + 1);

                //out.println("Insert doc_type = " + doc_type);                
                //out.print(doc_id); 
                status_a = request.getParameter("I_status");
                //out.print("status_a = " + status_a);
                I_status = request.getParameter("I_status");
                dept_id = request.getParameter("dept_id");
                chk_dept = "0";
                if ((request.getParameter("dept_id").equals("05")) || request.getParameter("dept_id").equals("006")) {
                    chk_dept = "1";
                } else {
                    chk_dept = "2";
                }
            }
        %>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">        
        <input type="hidden" id="doc_type" value="<%=doc_type%>">        
        <input type="hidden" id="dept_id" value="<%=dept_id%>">        
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">  
        <input type="hidden" id="I_status" name="I_status" value="<%=I_status%>">
        <input type="hidden" id="U_status" name="U_status" value="<%=U_status%>">                
        <input type="hidden" id="chkNull" name="chkNull" value="doc_id">        
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("A_username")%>" size="30" readonly/>
        <input name="emp_id" type="hidden" id="emp_id" value="<%=request.getParameter("emp_id")%>" size="30" readonly/>        
        <input type="hidden" name="bag_weight" id="bag_weight" value="<%=bag_weight%>"/>

        <br>
        <div align="left">
            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ข้อมูลการวิเคราะห์คุณภาพ</b>
                    </div>                        
                    <div class="panel-footer">                      

                        <div align="center">                        

                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td class="columnobject"><b>วันที่นำส่ง:<%=doc_date%></b>&nbsp;&nbsp;&nbsp;<b>เลขที่เอกสาร:<%=doc_id%></b></td>
                                    <td class="columnobject"><input type="hidden" name="doc_date" id="doc_date" value="<%=doc_date%>" readonly/></td>                                
                                    <td class="columnobject"><input type="hidden" name="doc_id" id="doc_id" value="<%=doc_id%>" readonly/></td>                                
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ลำดับที่&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" name="line_no" id="line_no" value="<%=line_no%>" readonly/></td>
                                    <td class="columnlabel1">เลขที่ใบแจ้งผลิต*&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" name="job_id" id="job_id" value="<%=job_id%>" onclick="openBrWindow('vd_job_order_header&textinput=job_id', 0, 'Search_Detail_Desc2.jsp')" readonly/></td>
                                </tr>         

                                <tr>
                                    <td class="columnlabel1">แหล่งผลิต &nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" name="machine_id" id="machine_id" value="<%=machine_id%>" /></td>
                                    <td class="columnlabel1">รหัสผลิต&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" name="product_no" id="product_no" value="<%=product_no%>" /></td>
                                </tr>                                  
                                <tr>
                                    <td class="columnlabel1">ชนิดถ่าน*&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" name="product_id" id="product_id" value="<%=product_id%>" onclick="openBrWindow('mproduct_cat&textinput=product_id', 0, 'Search_Detail_Desc.jsp')" readonly /></td>
                                    <td class="columnlabel1">ขนาด&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" name="size_name" id="size_name" value="<%=size_name%>" onclick="openBrWindow('m_carbon_size&textinput=size_name', 0, 'Search_Detail_Desc.jsp')" readonly/></td>
                                </tr>                                                           

                                <tr>
                                    <td class="columnlabel1">จำนวนกระสอบ&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" name="bag_quatity" id="bag_quatity" value="<%=bag_quatity%>" onkeypress="IsNuber(this.value, this)" /></td>
                                </tr>                         

                                <input type='hidden' class="inputs" name="job_type" id="job_type" value="<%=job_type%>" readonly/>                                                        
                                <input type='hidden' class="inputs" name="iodine" id="iodine" value="" readonly/>   
                                <input type='hidden' class="inputs" name="pallet" id="pallet" value="<%=pallet%>" readonly/>
                                <input type='hidden' class="inputs" name="fraction" id="fraction" value="<%=fraction%>" onkeypress="IsNuber(this.value, this)" readonly/>                            
                                <input type='hidden' class="inputs" name="weight" id="weight" value="<%=weight%>" onkeypress="IsNuber(this.value, this)" readonly/>
                                <input type="hidden" name="dept_id" id="dept_id" value="<%=dept_id%>" />
                                <input type="hidden" name="chk_dept" id="chk_dept" value="<%=chk_dept%>" />
                                <input type='hidden' class="inputs" name="wh_product_id" id="wh_product_id" value="<%=wh_product_id%>" onclick="openBrWindow('vmproduct&textinput=wh_product_id', 0, 'Search_Detail_Desc.jsp')" readonly/>
                                <input type='hidden' class="inputs" name="wh_id" id="wh_id" value="<%=wh_id%>" onclick="openBrWindow('mwarehouse&textinput=wh_id', 0, 'Search_Detail_Desc.jsp')" readonly/>
                                <input type='hidden' class="inputs" name="location_id" id="location_id" value="<%=location_id%>"/>                            

                                <tr>
                                    <td colspan='2'  align="right">
                                        <%
                                            if (request.getParameter("I_status") != null) {
                                        %>
                                        <input type="button" class="cgcButton_5" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                        <%} else {
                                        %>
                                        <input type="button" class="cgcButton_5" name="button1" value="แก้ไข" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                        <%}
                                        %>

                                        <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>                                </td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'>                                
                                    </td>
                                </tr>
                            </table>



                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel panel-primary">
            <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;บันทึกผลวิเคราะห์</div>             
            <div class="jumbotron">                
                <table style="width:1000px">                                
                    <tr>
                        <td class="columnlabel1"><B>Parameter</B></td>                                         
                        <td class="columnobject"><input type='text' class="inputs" name="param_header_id" id="param_header_id" size="12" value="<%=param_header_id%>" onclick="openBrWindow('vd_header_analyze', 0, 'Search_Config2.jsp')" readonly/>
                            <a href='#' onclick="openBrWindow('vd_header_analyze', 0, 'Search_Config2.jsp')"  ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='25' height='25' border='0' align='middle' ></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="columnlabel1"><B>LAB</B></td>         
                        <td class="columnlabel1"><B>ผลการวิเคราะห์&nbsp;</B></td>                         
                        <td class="columnlabel1"><B></B></td>                                               
                        <td class="columnlabel1"><B></B></td>                                               
                        <td class="columnlabel1"><B></B></td>                                                               
                        <td class="columnlabel1"><B>PSD1</B></td>         
                        <td class="columnlabel1"><B>PSD2</B></td>       
                        <td class="columnlabel1"><B>PSD3</B></td>       
                        <td class="columnlabel1"><B>PSD4</B></td>       
                        <td class="columnlabel1"><B>PSD5</B></td>       
                        <td class="columnlabel1"><B>PSD6</B></td>       
                        <td class="columnlabel1"><B>PSD7</B></td>       
                        <td class="columnlabel1"><B>PSD8</B></td>       
                        <td class="columnlabel1"><B>PSD9</B></td>       
                        <td class="columnlabel1"><B>PSD10</B></td>                            
                    </tr> 
                    <tr>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>                
                        <td class="columnobject"><input type='text' class="inputs" name="h2o_header" id="h2o_header" value="H2O (%)" size="8" readonly/></td>
                        <td class="columnobject"><input type='text' class="inputs" name="butane_header" id="butane_header" value="Butane (%)" size="8" readonly/></td>
                        <td class="columnobject"><input type='text' class="inputs" name="iod_header" id="iod_header" value="ไอโอดีน (mg/g)" size="23" readonly/></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_1_header" id="psd_1_header" size="4" value="<%=psd_1_header%>"  /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_2_header" id="psd_2_header" size="4" value="<%=psd_2_header%>"  /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_3_header" id="psd_3_header" size="4" value="<%=psd_3_header%>"  /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_4_header" id="psd_4_header" size="4" value="<%=psd_4_header%>"  /></td>   
                        <td class="columnobject"><input type='text' class="inputs" name="psd_5_header" id="psd_5_header" size="4" value="<%=psd_5_header%>"  /></td>      
                        <td class="columnobject"><input type='text' class="inputs" name="psd_6_header" id="psd_6_header" size="4" value="<%=psd_6_header%>"  /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_7_header" id="psd_7_header" size="4" value="<%=psd_7_header%>"  /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_8_header" id="psd_8_header" size="4" value="<%=psd_8_header%>"  /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_9_header" id="psd_9_header" size="4" value="<%=psd_9_header%>"  /></td>   
                        <td class="columnobject"><input type='text' class="inputs" name="psd_10_header" id="psd_10_header" size="4" value="<%=psd_10_header%>"  /></td>                                  
                    </tr>               
                    <tr>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>                
                        <td class="columnobject"><input type='text' class="inputs" name="h2o" id="h2o" size="8" value="<%=h2o%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="butane" id="butane" size="8" value="<%=butane%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="iod" id="iod" size="23" value="<%=iod%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_1" id="psd_1" size="4" value="<%=psd_1%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_2" id="psd_2" size="4" value="<%=psd_2%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_3" id="psd_3" size="4" value="<%=psd_3%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_4" id="psd_4" size="4" value="<%=psd_4%>" /></td>   
                        <td class="columnobject"><input type='text' class="inputs" name="psd_5" id="psd_5" size="4" value="<%=psd_5%>" /></td>      
                        <td class="columnobject"><input type='text' class="inputs" name="psd_6" id="psd_6" size="4" value="<%=psd_6%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_7" id="psd_7" size="4" value="<%=psd_7%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_8" id="psd_8" size="4" value="<%=psd_8%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_9" id="psd_9" size="4" value="<%=psd_9%>" /></td>   
                        <td class="columnobject"><input type='text' class="inputs" name="psd_10" id="psd_10" size="4" value="<%=psd_10%>" /></td>   

                    </tr>

                    <tr>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>               
                        <td class="columnobject"></td>
                        <td class="columnlabel1"><B></B></td>                      
                        <td class="columnlabel1"><B>PSD11</B></td>       
                        <td class="columnlabel1"><B>PSD12</B></td>       
                        <td class="columnlabel1"><B>PSD13</B></td>       
                        <td class="columnlabel1"><B>PSD14</B></td>       
                        <td class="columnlabel1"><B>PSD15</B></td>                
                    </tr>
                    <tr>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>
                        <td class="columnobject"><input type='text' class="inputs" name="grade_header" id="grade_header" size="23" value="เกรด (ช่วงค่าไอโอดีน)" readonly /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_11_header" id="psd_11_header" size="4" value="<%=psd_11_header%>"  /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_12_header" id="psd_12_header" size="4" value="<%=psd_12_header%>"  /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_13_header" id="psd_13_header" size="4" value="<%=psd_13_header%>"  /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_14_header" id="psd_14_header" size="4" value="<%=psd_14_header%>"  /></td>   
                        <td class="columnobject"><input type='text' class="inputs" name="psd_15_header" id="psd_15_header" size="4" value="<%=psd_15_header%>"  /></td>
                    </tr>

                    <tr>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>   
                        <td class="columnobject"></td>
                        <td class="columnobject"><input type='text' class="inputs" name="grade" id="grade" size="23" value="<%=grade%>" onclick="openBrWindow('m_iodine_product&textinput=grade', 0, 'Search_Detail.jsp')" readonly/></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_11" id="psd_11" size="4" value="<%=psd_11%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_12" id="psd_12" size="4" value="<%=psd_12%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_13" id="psd_13" size="4" value="<%=psd_13%>" /></td>
                        <td class="columnobject"><input type='text' class="inputs" name="psd_14" id="psd_14" size="4" value="<%=psd_14%>" /></td>   
                        <td class="columnobject"><input type='text' class="inputs" name="psd_15" id="psd_15" size="4" value="<%=psd_15%>" /></td>                  
                    </tr>

                    <tr>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>
                        <td class="columnobject"></td>                
                        <td class="columnlabel1">สถานะ</td>
                        <td class="columnobject"><input type="radio" name="status1" id="pass" value="Y" onClick="javascript:getId('valuepass').value = this.value;">
                            ผ่าน
                            <input type="radio" name="status1" id="n_pass" value="N" onClick="javascript:getId('valuepass').value = this.value;">
                            ไม่ผ่าน
                            <input name="valuepass" type="hidden" id="valuepass" value="<%=valuepass%>">                                                
                        </td>
                    </tr>

                    <td class="columnobject"></td>
                    <td class="columnobject"></td>
                    <td class="columnobject"></td>
                    <td class="columnlabel1">หมายเหตุ&nbsp;</td>
                    <td class="columnobject">
                        <textarea class="text_inputs" name='remark' cols='20' rows='2' id="remark"><%=remark%></textarea>                                
                    </td>
                    </tr>

                    <tr>
                        <td class="columnlabel1">ผู้บันทึกผลวิเคราะห์&nbsp;</td>            
                        <td class="columnobject"><input name="lab_emp_id" type='text' class="inputs" id="lab_emp_id" value ="<%=lab_emp_id%>" size="15" readonly="true">
                            <a href='javascript:;'onclick="OpenConfirm('Vemployee', 'Search_Config2.jsp', '06')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>                                        
                            <input name="lab_emp_name" type='text' class="inputs" id="lab_emp_name" value="<%=lab_emp_name%>" size="30" readonly="true">
                        </td>
                    </tr>                            

                </table>
            </div>
        </div>        
    </body>
</html>
