
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">

        </script>
        <script type="text/javascript">

            function goAdd()
            {
                for(var i = 1; i<=15;i++){
                    senddataPopup('hc'+i.toString()).value = getId('hc'+i.toString()).value;
                }
                window.close();
                
            }
            
            function goBack()
            {
                window.close();
            }
           
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    </head>
    <body >
        <%!            ThaiUtil en = new ThaiUtil();
        String hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15,qc;
        %>
        <%
                    
                    if(request.getParameter("hc1")!= null)
                        hc1 = en.EncodeTexttoTIS(request.getParameter("hc1"));
                     if(request.getParameter("hc2")!= null)
                        hc2 = en.EncodeTexttoTIS(request.getParameter("hc2"));
                     if(request.getParameter("hc3")!= null)
                        hc3 = en.EncodeTexttoTIS(request.getParameter("hc3"));
                     if(request.getParameter("hc4")!= null)
                        hc4 = en.EncodeTexttoTIS(request.getParameter("hc4"));
                     if(request.getParameter("hc5")!= null)
                        hc5 = en.EncodeTexttoTIS(request.getParameter("hc5"));
                     if(request.getParameter("hc6")!= null)
                        hc6 = en.EncodeTexttoTIS(request.getParameter("hc6"));
                     if(request.getParameter("hc7")!= null)
                        hc7 = en.EncodeTexttoTIS(request.getParameter("hc7"));
                     if(request.getParameter("hc8")!= null)
                        hc8 = en.EncodeTexttoTIS(request.getParameter("hc8"));
                     if(request.getParameter("hc9")!= null)
                        hc9 = en.EncodeTexttoTIS(request.getParameter("hc9"));
                     if(request.getParameter("hc10")!= null)
                        hc10 = en.EncodeTexttoTIS(request.getParameter("hc10"));
                     if(request.getParameter("hc11")!= null)
                        hc11 = en.EncodeTexttoTIS(request.getParameter("hc11"));
                     if(request.getParameter("hc12")!= null)
                        hc12 = en.EncodeTexttoTIS(request.getParameter("hc12"));
                     if(request.getParameter("hc13")!= null)
                        hc13 = en.EncodeTexttoTIS(request.getParameter("hc13"));
                     if(request.getParameter("hc14")!= null)
                        hc14 = en.EncodeTexttoTIS(request.getParameter("hc14"));
                     if(request.getParameter("hc15")!= null)
                        hc15 = en.EncodeTexttoTIS(request.getParameter("hc15"));

        %>
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td height="119" class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">Parameter</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td height="51" class="row3"><div align="right">ลำดับ &nbsp;</div></td>
                                <td class="row3"><div align="center">Parameter</div></td>
                            </tr>

                            <tr>
                                <td class="columnlabel">1 &nbsp;</td>
                                <td class="columnobject"><input name="hc1" type='text' class="inputs" id="hc1" size="30" value="<%=hc1%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">2 &nbsp;</td>
                                <td class="columnobject"><input name="hc2" type='text' class="inputs" id="hc2" size="30" value="<%=hc2%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">3 &nbsp;</td>
                                <td class="columnobject"><input name="hc3" type='text' class="inputs" id="hc3" size="30" value="<%=hc3%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">4 &nbsp;</td>
                                <td class="columnobject"><input name="hc4" type='text' class="inputs" id="hc4" size="30" value="<%=hc4%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">5 &nbsp;</td>
                                <td class="columnobject"><input name="hc5" type='text' class="inputs" id="hc5" size="30" value="<%=hc5%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">6 &nbsp;</td>
                                <td class="columnobject"><input name="hc6" type='text' class="inputs" id="hc6" size="30" value="<%=hc6%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">7 &nbsp; </td>
                                <td class="columnobject"><input name="hc7" type='text' class="inputs" id="hc7" size="30" value="<%=hc7%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">8&nbsp;</td>
                                <td class="columnobject"><input name="hc8" type='text' class="inputs" id="hc8" size="30" value="<%=hc8%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">9&nbsp;</td>
                                <td class="columnobject"><input name="hc9" type='text' class="inputs" id="hc9" size="30" value="<%=hc9%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">10&nbsp;</td>
                                <td class="columnobject"><input name="hc10" type='text' class="inputs" id="hc10" size="30" value="<%=hc10%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">11&nbsp;</td>
                                <td class="columnobject"><input name="hc11" type='text' class="inputs" id="hc11" size="30" value="<%=hc11%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">12&nbsp;</td>
                                <td class="columnobject"><input name="hc12" type='text' class="inputs" id="hc12" size="30" value="<%=hc12%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">13&nbsp;</td>
                                <td class="columnobject"><input name="hc13" type='text' class="inputs" id="hc13" size="30" value="<%=hc13%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">14&nbsp;</td>
                                <td class="columnobject"><input name="hc14" type='text' class="inputs" id="hc14" size="30" value="<%=hc14%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">15&nbsp;</td>
                                <td class="columnobject"><input name="hc15" type='text' class="inputs" id="hc15" size="30" value="<%=hc15%>"></td>
                            </tr>

                            <tr>
                                <td colspan='2'  align="right">

                                    <input type="button" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;


                                    <input type="button" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>                                </td>
                            </tr>
                        </table>
                    </div></td>
                <td class="fcenterright"></td>
            </tr>
            <tr bordercolor="0069B3">
                <td class="ffootleft"></td>
                <td  class="ffootcenter" colspan="2"></td>
                <td class="ffootright"></td>
            </tr>
        </table>

    </body>
</html>
