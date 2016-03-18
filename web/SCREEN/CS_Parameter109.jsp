
<%@page import="com.cgc.bean.DataBeanD_carbon_analyze_detail"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_analyze_header"%>
<%@page import="com.cgc.DB.D_carbon_analyze_value_detailDAO"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
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

        <script src="../JS/angularjs/angular.min.js"></script>                

        <script src="../JS/alertify/alertify.min.js"></script>        
        <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />
        <link rel="stylesheet" href="../CSS/alertify/alertify.default.css" />          

        <link rel="stylesheet" href="../CSS/checkbox/awesome-bootstrap-checkbox.css"/> 
        <link rel="stylesheet" href="../FONTS/css/font-awesome.css" />        

        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function passvaluechk() {
                if (getId("valuepass").value == "Y") {
                    getId("pass").checked = true;
                    getId("nopass").checked = false;
                } else if (getId("valuepass").value == "N") {
                    getId("pass").checked = false;
                    getId("nopass").checked = true;
                } else {
                    getId("pass").checked = false;
                    getId("nopass").checked = false;
                }
            }
            function goAdd()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('chkNull,doc_id,header_id,bag,prd_place,c_type,prd_code,h2o,ba,iod,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,valuepass,grade,remark,status_a,username,job_id', '../JSP/CS_Parameter109.jsp'));
                    window.opener.location.reload();
                    //window.opener.newref.submit();
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('chkNull,doc_id,bag,prd_place,c_type,prd_code,h2o,ba,iod,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,valuepass,grade,remark,status_u,username,line_no,header_id,job_id', '../JSP/CS_Parameter109.jsp'));
                    window.opener.location.reload();
                    setTimeout('window.close()', 1000);
                }
            }

            function goBack()
            {
                window.close();
            }
        </script>
    </head>
    <body onLoad="passvaluechk()">
        <%!            ThaiUtil en = new ThaiUtil();
            UtiDatabase objuti = new UtiDatabase();
            D_carbon_analyze_value_detailDAO objDAO = new D_carbon_analyze_value_detailDAO();
            //D_carbon_analyze_headerDAO objHDAO = new D_carbon_analyze_headerDAO();
            DataBeanD_carbon_analyze_header objBeanH = new DataBeanD_carbon_analyze_header();
            DataBeanD_carbon_analyze_detail objBean = new DataBeanD_carbon_analyze_detail();
            String hd1, hd2, hd3, hd4, hd5, hd6, hd7, hd8, hd9, hd10, hd11, hd12, hd13, hd14, hd15, doc_id, line_no, status_a, status_u, header_id, valuepass, grade, remark,
                    bag, prd_place, c_type, prd_code, h2o, ba, iod, job_id, job_id_desc;
        %>
        <%
            hd1 = "";
            hd2 = "";
            hd3 = "";
            hd4 = "";
            hd5 = "";
            hd6 = "";
            hd7 = "";
            hd8 = "";
            hd9 = "";
            hd10 = "";
            hd11 = "";
            hd12 = "";
            hd13 = "";
            hd14 = "";
            hd15 = "";
            doc_id = "";
            line_no = "";
            status_a = "";
            status_u = "";
            header_id = "";
            valuepass = "";
            grade = "-";
            remark = "";
            bag = "";
            prd_place = "";
            c_type = "";
            prd_code = "";
            h2o = "";
            ba = "";
            iod = "";
            job_id = "";
            job_id_desc = "";
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                header_id = en.EncodeTexttoTIS(request.getParameter("header_id"));
                objBean = objDAO.ReturnEdit(doc_id, line_no, header_id, objBean);
                hd1 = objBean.getHc1();
                hd2 = objBean.getHc2();
                hd3 = objBean.getHc3();
                hd4 = objBean.getHc4();
                hd5 = objBean.getHc5();
                hd6 = objBean.getHc6();
                hd7 = objBean.getHc7();
                hd8 = objBean.getHc8();
                hd9 = objBean.getHc9();
                hd10 = objBean.getHc10();
                hd11 = objBean.getHc11();
                hd12 = objBean.getHc12();
                hd13 = objBean.getHc13();
                hd14 = objBean.getHc14();
                hd15 = objBean.getHc15();
                remark = objBean.getRemark();
                valuepass = objBean.getPass();
                job_id = objBean.getJob_id();
                job_id_desc = objBean.getJob_id_desc();
                bag = objBean.getBag();
                prd_place = objBean.getPrd_place();
                c_type = objBean.getP_type();
                prd_code = objBean.getPrd_code();
                h2o = objBean.getH2o();
                ba = objBean.getButane();
                iod = objBean.getIod();
                grade = objBean.getGrade();
                status_u = "2";
            } else {
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                header_id = en.EncodeTexttoTIS(request.getParameter("header_id"));
                status_a = request.getParameter("status_a_parameter");
                //valuepass = "N";
                //bag = request.getParameter("bag");
                //prd_place = en.EncodeTexttoTIS(request.getParameter("prd_place"));
                //c_type = en.EncodeTexttoTIS(request.getParameter("c_type"));
                //prd_code = en.EncodeTexttoTIS(request.getParameter("prd_code"));
                //job_id = en.EncodeTexttoTIS(request.getParameter("job_id"));
                //job_id_desc = en.EncodeTexttoTIS(request.getParameter("job_id_desc"));
            }

        %>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="header_id" value="<%=header_id%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" name="chkNull" value="bag,prd_place,c_type,prd_code,h2o,ba,iod">
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <br>
        <div align="left">
            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>Parameter</b>
                    </div>                        
                    <div class="panel-footer">                      
                        <div align="center">                
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td class="columnlabel1">จำนวน(ถุง*)</td>
                                    <td class="columnobject"><input type='text' class="inputs" name='bag' size='20' id="bag"  value="<%=bag%>" /></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">แหล่งผลิต*</td>
                                    <td class="columnobject"><input name="prd_place" type='text' class="inputs" id="prd_place" size="20" value="<%=prd_place%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ขนาด/ชนิดถ่าน*</td>
                                    <td class="columnobject"><input name="c_type" type='text' class="inputs" id="c_type" size="20" value="<%=c_type%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">รหัส*</td>
                                    <td class="columnobject"><input name="prd_code" type='text' class="inputs" id="prd_code" size="20" value="<%=prd_code%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">H2O(%)*</td>
                                    <td class="columnobject"><input name="h2o" type='text' class="inputs" id="h2o" size="20" value="<%=h2o%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">Butane(%)*</td>
                                    <td class="columnobject"><input name="ba" type='text' class="inputs" id="ba" size="20" value="<%=ba%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ไอโอดีน(mg/g)*</td>
                                    <td class="columnobject"><input name="iod" type='text' class="inputs" id="iod" size="20" value="<%=iod%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">เลขที่ใบแจ้งการผลิต</td>
                                    <td class="columnobject"><input name="job_id" type='text' class="inputs" id="job_id" value="<%=job_id%>" size="20"><a href='javascript:;' onClick="openBrWindow('vd_job_order_header&stadment=and+complete_flag+<>+\'Y\'', 109, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        <input name="job_id_desc" type='text' class="inputs" id="job_id_desc" value ="<%=job_id_desc%>"size="30">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">&nbsp;</td>
                                    <td class="columnobject"><table width="100%" border="0" id="tbExp">
                                            <%if (status_u.equals("2")) {%>
                                            <tr>                                        </tr>
                                            <%}%>
                                            <tr>
                                                <td colspan="17" class="row3"><div align="center">P.S.D.</div></td>
                                            </tr>
                                            <tr>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd1")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd2")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd3")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd4")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd5")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd6")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd7")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd8")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd9")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd10")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd11")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd12")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd13")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd14")))%>&nbsp;</td>
                                                <td class="row3"><%=objuti.NotNull(en.EncodeTexttoTIS(request.getParameter("hd15")))%>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td class="columnobject"><input name="hd1" type='text' class="inputs" id="hd1" size="4" value="<%=hd1%>"></td>
                                                <td class="columnobject"><input name="hd2" type='text' class="inputs" id="hd2" size="4" value="<%=hd2%>"></td>
                                                <td class="columnobject"><input name="hd3" type='text' class="inputs" id="hd3" size="4" value="<%=hd3%>"></td>
                                                <td class="columnobject"><input name="hd4" type='text' class="inputs" id="hd4" size="4" value="<%=hd4%>"></td>
                                                <td class="columnobject"><input name="hd5" type='text' class="inputs" id="hd5" size="4" value="<%=hd5%>"></td>
                                                <td class="columnobject"><input name="hd6" type='text' class="inputs" id="hd6" size="4" value="<%=hd6%>"></td>
                                                <td class="columnobject"><input name="hd7" type='text' class="inputs" id="hd7" size="4" value="<%=hd7%>"></td>
                                                <td class="columnobject"><input name="hd8" type='text' class="inputs" id="hd8" size="4" value="<%=hd8%>"></td>
                                                <td class="columnobject"><input name="hd9" type='text' class="inputs" id="hd9" size="4" value="<%=hd9%>"></td>
                                                <td class="columnobject"><input name="hd10" type='text' class="inputs" id="hd10" size="4" value="<%=hd10%>"></td>
                                                <td class="columnobject"><input name="hd11" type='text' class="inputs" id="hd11" size="4" value="<%=hd11%>"></td>
                                                <td class="columnobject"><input name="hd12" type='text' class="inputs" id="hd12" size="4" value="<%=hd12%>"></td>
                                                <td class="columnobject"><input name="hd13" type='text' class="inputs" id="hd13" size="4" value="<%=hd13%>"></td>
                                                <td class="columnobject"><input name="hd14" type='text' class="inputs" id="hd14" size="4" value="<%=hd14%>"></td>
                                                <td class="columnobject"><input name="hd15" type='text' class="inputs" id="hd15" size="4" value="<%=hd15%>"></td>
                                            </tr>

                                        </table></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">สถานะ</td>
                                    <td class="columnobject"><input type="radio" name="status1" id="pass" value="Y" onClick="javascript:getId('valuepass').value = this.value;">
                                        ผ่าน
                                        <input type="radio" name="status1" id="nopass" value="N" onClick="javascript:getId('valuepass').value = this.value;">
                                        ไม่ผ่าน
                                        <input name="valuepass" type="hidden" id="valuepass" value="<%=valuepass%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">เกรด</td>
                                    <td class="columnobject"><input name="grade" type='text' class="inputs" id="grade" size="20" value="<%=grade%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">หมายเหต</td>
                                    <td class="columnobject"><textarea class="text_inputs" name="remark" id="remark" cols="45" rows="5"><%=remark%></textarea></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td class="columnobject">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td class="columnobject">&nbsp;</td>
                                </tr>

                                <tr>
                                    <td colspan='2'  align="right">
                                        <%if (status_a.equals("1")) {%>
                                        <input type="button" class="cgcButton_5" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                        <%} else {%>
                                        <input type="button" class="cgcButton_5" name="button1" value="แก้ไข" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                        <%}%>
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
        </div>
    </body>
</html>
