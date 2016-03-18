
<%@page import="com.cgc.bean.DataBeand_carbon_send_product_detail"%>
<%@page import="com.cgc.DB.D_carbon_send_product_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<!--%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%-->
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                           

        <link rel="stylesheet" href="../CSS/checkbox/awesome-bootstrap-checkbox.css"/>     


        <script src="../JS/alertify/alertify.js"></script>        

        <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />

        <!-- alertify theme Section -->
        <!--link rel="stylesheet" href="../CSS/alertify/alertify.bootstrap.css"-->
        <link rel="stylesheet" href="../CSS/alertify/alertify.default.css">

        <link rel="stylesheet" href="../FONTS/css/font-awesome.css" />        
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
                    getSave(URLsend('doc_id,line_no,doc_date,status_a,job_id,product_id,size_name,iodine,machine_id,pallet,product_no,bag_quatity,bag_weight,weight,wh_id,location_id,wh_product_id,fraction,job_type,username,doc_type', '../JSP/CS_Detail_D_carbon_send_product.jsp'));
                    //opener.showdetail();
                    //alert("ADD After ");                    
                    showTable("show", "doc_id", "../JSP/CS_ShowD_carbon_send_product.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_ShowD_carbon_send_product.jsp?doc_id=");', 800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {

                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    //alert("EDIT");
                    //getSave(URLsend('doc_id,line_no,job_id,product_id,size_name,iodine,machine_id,pallet,product_no,bag_quatity,bag_weight,weight,status_a,I_status,username', '../JSP/CS_Detail_D_carbon_send_product.jsp'));
                    getSave(URLsend('doc_id,doc_date,line_no,status_u,job_id,product_id,size_name,iodine,machine_id,pallet,product_no,bag_quatity,bag_weight,weight,wh_id,location_id,wh_product_id,wh_iodine,wh_iodine_real,fraction,job_type,username', '../JSP/CS_Detail_D_carbon_send_product.jsp'));
                    showTable("show", "doc_id", "../JSP/CS_ShowD_carbon_send_product.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_ShowD_carbon_send_product.jsp?doc_id=");', 800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goBack()
            {
                window.close();
            }

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
    </head>
    <body onLoad="passvaluechk()">
        <%! ThaiUtil en = new ThaiUtil();
            D_carbon_send_product_detailDAO objDAO = new D_carbon_send_product_detailDAO();
            DataBeand_carbon_send_product_detail objBean = new DataBeand_carbon_send_product_detail();
            String grade, wh_iodine, wh_iodine_real, name_t_product, pass, n_pass, valuepass, remark, h2o, iod, butane, dept_id, doc_type, complete_flag, chk_dept, runno, doc_id, doc_date, line_no, status_a, status_u, I_status, U_status, job_id, product_id, size_name, iodine, machine_id, pallet, product_no, bag_quatity, bag_weight, weight, wh_id, location_id, wh_product_id, fraction, job_type;
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
            remark = "";
            valuepass = "";
            pass = "";
            n_pass = "";
            name_t_product = "";
            wh_iodine = "0";
            grade = "0";
            wh_iodine_real = "0";

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
                remark = objBean.getRemark();
                n_pass = objBean.getN_pass();
                valuepass = objBean.getPass();
                pass = objBean.getPass();
                name_t_product = objBean.getProd_name();
                wh_iodine = objBean.getWh_iodine();
                wh_iodine_real = objBean.getWh_iodine_real();
                grade = objBean.getGrade();

                //out.println("Update doc_type = " + doc_type);
                status_u = "2";
                U_status = "2";

            } else {
                doc_id = en.EncodeTexttoTIS(request.getParameter("A_doc_id"));
                doc_date = en.EncodeTexttoTIS(request.getParameter("A_doc_date"));
                doc_type = request.getParameter("A_doc_type");
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
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <br>
        <div align="left">

            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ข้อมูลการนำส่งสินค้า</b>
                    </div>                        
                    <div class="panel-footer">              
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"></td>
                                <td class="columnobject"><b>วันที่นำส่ง:<%=doc_date%></b>&nbsp;&nbsp;&nbsp;<b>เลขที่เอกสาร:<%=doc_id%></b></td>
                                <td class="columnobject"><input type="hidden" name="doc_date" id="doc_date" value="<%=doc_date%>" readonly/></td>                                
                                <td class="columnobject"><input type="hidden" name="doc_id" id="doc_id" value="<%=doc_id%>" readonly/></td>                                
                            </tr>
                            <tr>
                                <td class="columnlabel1">ลำดับที่&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="line_no" id="line_no" value="<%=line_no%>" readonly/></td>
                            </tr>         


                            <%if ((chk_dept.charAt(0) == '2')) {%>

                            <tr>
                                <td class="columnlabel1">เลขที่ใบแจ้งผลิต*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="job_id" id="job_id" value="<%=job_id%>" onclick="openBrWindow('vd_job_order_header&textinput=job_id', 0, 'Search_Detail_Desc2.jsp')" readonly/></td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">ชนิดถ่าน*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="product_id" id="product_id" value="<%=product_id%>" onclick="openBrWindow('mproduct_cat&textinput=product_id', 0, 'Search_Detail_Desc.jsp')" readonly/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ประเภท&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="job_type" id="job_type" value="<%=job_type%>" onclick="openBrWindow('mjob_type_detail&textinput=job_type', 0, 'Search_Detail_Desc.jsp')" readonly/></td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">ขนาด&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="size_name" id="size_name" value="<%=size_name%>" onclick="openBrWindow('m_carbon_size&textinput=size_name', 0, 'Search_Detail_Desc.jsp')" readonly/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ไอโอดีน&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="iodine" id="iodine" value="<%=iodine%>" onclick="openBrWindow('m_iodine_product&textinput=iodine', 0, 'Search_Detail_Desc.jsp')" readonly/></td>
                            </tr>                                        
                            <tr>
                                <td class="columnlabel1">เครื่องผลิต &nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="machine_id" id="machine_id" value="<%=machine_id%>" onclick="openBrWindow('mmachine&textinput=machine_id', 0, 'Search_Detail_Desc_Name_T.jsp')" readonly/></td>
                            </tr>                                  
                            <tr>
                                <td class="columnlabel1">พาเลท/ถุง&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="pallet" id="pallet" value="<%=pallet%>"/></td>
                            </tr>  
                            <tr>
                                <td class="columnlabel1">รหัสผลิต&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="product_no" id="product_no" value="<%=product_no%>"/></td>
                            </tr>                            

                            <tr>
                                <td class="columnlabel1">จำนวนกระสอบ&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="bag_quatity" id="bag_quatity" value="<%=bag_quatity%>" onkeypress="IsNuber(this.value, this)"/></td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">เศษ (กิโลกรัม)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="fraction" id="fraction" value="<%=fraction%>" onkeypress="IsNuber(this.value, this)"/></td>
                                <td class="columnobject"><input type="hidden" name="bag_weight" id="bag_weight" value="<%=bag_weight%>" onkeypress="IsNuber(this.value, this)"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">น้ำหนักรวม (กิโลกรัม)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="weight" id="weight" value="<%=weight%>" onkeypress="IsNuber(this.value, this)"/></td>
                            </tr>               
                            <%} else {%>

                            <tr>
                                <td class="columnlabel1">เลขที่ใบแจ้งผลิต*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="job_id" id="job_id" value="<%=job_id%>" readonly/></td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">ชนิดถ่าน*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="product_id" id="product_id" value="<%=product_id%>" readonly/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ประเภท&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="job_type" id="job_type" value="<%=job_type%>" readonly/></td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">ขนาด&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="size_name" id="size_name" value="<%=size_name%>" readonly/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ไอโอดีน&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="iodine" id="iodine" value="<%=iodine%>" readonly/></td>
                            </tr>                                        
                            <tr>
                                <td class="columnlabel1">เครื่องผลิต &nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="machine_id" id="machine_id" value="<%=machine_id%>" readonly/></td>
                            </tr>                                  
                            <tr>
                                <td class="columnlabel1">พาเลท/ถุง&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="pallet" id="pallet" value="<%=pallet%>" readonly/></td>
                            </tr>  
                            <tr>
                                <td class="columnlabel1">รหัสผลิต&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="product_no" id="product_no" value="<%=product_no%>" readonly/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">จำนวนกระสอบ&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="bag_quatity" id="bag_quatity" value="<%=bag_quatity%>" onkeypress="IsNuber(this.value, this)" readonly/></td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">เศษ (กิโลกรัม)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="fraction" id="fraction" value="<%=fraction%>" onkeypress="IsNuber(this.value, this)" readonly/></td>
                                <td class="columnobject"><input type="hidden" name="bag_weight" id="bag_weight" value="<%=bag_weight%>" onkeypress="IsNuber(this.value, this)"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">น้ำหนักรวม (กิโลกรัม)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="weight" id="weight" value="<%=weight%>" onkeypress="IsNuber(this.value, this)" readonly/></td>
                            </tr>                              

                            <%}%>


                            <input type="hidden" name="dept_id" id="dept_id" value="<%=dept_id%>" />
                            <input type="hidden" name="chk_dept" id="chk_dept" value="<%=chk_dept%>" />

                            <%if ((chk_dept.charAt(0) == '1')) {%>

                            <!--tr>
                                <td class="columnlabel1">รหัสสินค้า (คลังสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="wh_product_id" id="wh_product_id" value="<%=wh_product_id%>" onclick="openBrWindow('vmproduct&textinput=wh_product_id', 0, 'Search_Detail_Desc.jsp')" readonly/></td>                                
                            </tr-->              

                            <tr>
                                <td class="columnlabel1"><b>รหัสสินค้า (คลังสินค้า)&nbsp;</b>&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='wh_product_id' id="wh_product_id" value='<%=wh_product_id%>' />&nbsp;<a href='javascript:;' onClick="openBrWindow('vmproduct', 21, 'Search_Config2_1.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='name_t_product' id="name_t_product" size='70' value='<%=name_t_product%>' />
                                </td>
                            </tr>               

                            <tr>
                                <td class="columnlabel1">ช่วงค่าไอโอดีน (ตามรหัสสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="wh_iodine" id="wh_iodine" value="<%=wh_iodine%>" onclick="openBrWindow('m_iodine_product&textinput=wh_iodine', 0, 'Search_Detail_Desc.jsp')" readonly/></td>
                            </tr>                                 

                            <tr>
                                <td class="columnlabel1">จัดเก็บโกดัง/คลัง (คลังสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="wh_id" id="wh_id" value="<%=wh_id%>" onclick="openBrWindow('mwarehouse&textinput=wh_id', 0, 'Search_Detail_Desc.jsp')" readonly/></td>                                                                                                                       
                            </tr>                              
                            <tr>
                                <td class="columnlabel1">จัดเก็บกองที่ (คลังสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="location_id" id="location_id" value="<%=location_id%>"/></td>
                            </tr>

                            <tr>
                                <td class="columnlabel1">ช่วงค่าไอโอดีน (คลังสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="wh_iodine_real" id="wh_iodine_real" value="<%=wh_iodine_real%>" onclick="openBrWindow('m_iodine_product&textinput=wh_iodine_real', 0, 'Search_Detail_Desc.jsp')" readonly/></td>
                            </tr>                              

                            <%} else {%>

                            <tr>
                                <td class="columnlabel1">รหัสสินค้า (คลังสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="wh_product_id" id="wh_product_id" value="<%=wh_product_id%>" readonly/>
                                    <input type='text' class="inputs" name='name_t_product' id="name_t_product" size='70' value='<%=name_t_product%>' />
                                </td>                                
                            </tr>

                            <tr>
                                <td class="columnlabel1">ช่วงค่าไอโอดีน (ตามรหัสสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="wh_iodine" id="wh_iodine" value="<%=wh_iodine%>" readonly/></td>
                            </tr>                               

                            <tr>
                                <td class="columnlabel1">จัดเก็บโกดัง/คลัง (คลังสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="wh_id" id="wh_id" value="<%=wh_id%>" readonly/></td>
                            </tr>  

                            <tr>
                                <td class="columnlabel1">จัดเก็บกองที่ (คลังสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="location_id" id="location_id" value="<%=location_id%>" readonly/></td>
                            </tr>                               
                            <tr>
                                <td class="columnlabel1">ช่วงค่าไอโอดีน (คลังสินค้า)&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="wh_iodine_real" id="wh_iodine_real" value="<%=wh_iodine_real%>" readonly/></td>
                            </tr>                              

                            <%}%>

                            <tr>
                                <td</td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>ค่า Iodine (ผลวิเคราะห์)&nbsp;</b></td>
                                <td class="columnobject"><input type='text' class="inputs" name="iod" id="iod" value="<%=iod%>" readonly/></td>
                            </tr>                              
                            <tr>
                                <td class="columnlabel1"><b>ค่า H2O (ผลวิเคราะห์)&nbsp;</b></td>
                                <td class="columnobject"><input type='text' class="inputs" name="h2o" id="h2o" value="<%=h2o%>" readonly/></td>
                            </tr>                              
                            <tr>
                                <td class="columnlabel1"><b>ค่า Butane (ผลวิเคราะห์)&nbsp;</b></td>
                                <td class="columnobject"><input type='text' class="inputs" name="butane" id="butane" value="<%=butane%>" readonly/></td>
                            </tr>               
                            <tr>
                                <td class="columnlabel1"><b>เกรด - ช่วงไอโอดีน (ผลวิเคราะห์)&nbsp;</b></td>
                                <td class="columnobject"><input type='text' class="inputs" name="grade" id="grade" value="<%=grade%>" readonly/></td>
                            </tr>                             
                            <tr>
                                <td class="columnlabel1"><b>สถานะ (ผลวิเคราะห์)&nbsp;</b></td>
                                <td class="columnobject"><input type="radio" name="status1" id="pass" value="Y" onClick="javascript:getId('valuepass').value = this.value;">
                                    ผ่าน
                                    <input type="radio" name="status1" id="n_pass" value="N" onClick="javascript:getId('valuepass').value = this.value;">
                                    ไม่ผ่าน
                                    <input name="valuepass" type="hidden" id="valuepass" value="<%=valuepass%>">                    
                                </td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1"><b>หมายเหตุ  (ผลวิเคราะห์)&nbsp;</b></td>
                                <td class="columnobject">
                                    <textarea class="text_inputs" name='remark' cols='50' rows='4' id="remark" readonly><%=remark%></textarea>                                
                                </td>
                            </tr>                                        

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
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
