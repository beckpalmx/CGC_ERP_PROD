<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_carbon_return_detail_whDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
    String sql = "";
    String htmlText = "";
    D_carbon_return_detail_whDAO carbonDao = new D_carbon_return_detail_whDAO();
    String doc_id = "";
%>
<%
    doc_id = request.getParameter("id");
    htmlText = carbonDao.showDetailView(doc_id);
%>
<html>
    <head>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CGC ERP</title>
    </head>
    <body> 
    <table  cellpadding="0"  cellspacing="0">
      <tr>
        <td class="ftopleft"></td>
        <td  class="ftopcenter" colspan="2"><DIV id="u4_rtf">
            <DIV id="u4_rtf2">
              <DIV id="u9_rtf">
                <DIV id="u4_rtf3">ใบแจ้งคืนถ่านกัมมันต์ที่เหลือจากการผลิตเข้าคลังสินค้า</DIV>
              </DIV>
            </DIV>
        </DIV></td>
        <td class="ftopright"></td>
      </tr>
      <tr >
        <td class="fcenterleft"></td>
        <td  colspan="2" class="fcentercenter"><div align="center">
            <table width="94%"  cellpadding="0" cellspacing="0" >

              <tr>
                <td width="756" height="208" align="center"><div style="width:100%;">
                  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="inner">
                    <tr>
                      <td colspan="6" class="h_multi">ข้อมูลการคืนถ่านกัมมันต์</td>
                      <td colspan="9" class="btn_multi">&nbsp;</td>
                    </tr>
                    <tr>
                      
                      <td width="7%" rowspan="2" valign="middle" class="row3"><div align="center">No.</div></td>
                      <td width="7%" rowspan="2" valign="middle" class="row3"><div align="center">ขนาด</div></td>
                      <td valign="middle" class="row3"><div align="center">
                          <DIV align="center">ชนิดของถ่าน</DIV>
                      </div></td>
                      <td width="7%" rowspan="2" valign="middle" class="row3"><div align="center">
                          <DIV align="center">ไอโอดีน</DIV>
                      </div></td>
                      <td width="13%" rowspan="2" valign="middle" class="row3"><div align="center">
                          <DIV align="center">รหัสครบพาเลท<BR>
                            / ครบถุง</DIV>
                      </div></td>
                      <td width="5%" rowspan="2" valign="middle" class="row3"><div align="center">
                          <DIV align="center">เลขที่</DIV>
                      </div></td>
                      <td width="5%" rowspan="2" valign="middle" class="row3"><div align="center">
                          <DIV align="center">เครื่อง<BR>
                            ผลิต</DIV>
                      </div></td>
                      <td width="6%" rowspan="2" valign="middle" class="row3"><div align="center">
                          <DIV align="center">ขนาด<BR>
                            บรรจุ</DIV>
                      </div></td>
                      <td colspan="3" valign="middle" class="row3"><div align="center">
                          <DIV align="center">จำนวนคืน</DIV>
                      </div>
                          <div align="center"></div>
                        <div align="center"></div></td>
                      <td width="11%" rowspan="2" valign="middle" class="row3"><div align="center">
                          <DIV align="center">สาเหตุการคืน</DIV>
                      </div></td>
                      <td width="8%" rowspan="2" valign="middle" class="row3"><div align="center">
                          <DIV align="center">หมายเหตุ</DIV>
                      </div></td>
                    </tr>
                    <tr>
                      <td width="11%" valign="middle" class="row3"><DIV align="center">C/P/U/ อื่นๆ</DIV></td>
                      <td width="5%" valign="middle" class="row3"><DIV align="center">กส/ถุง</DIV></td>
                      <td width="6%" valign="middle" class="row3"><DIV align="center">น.น<BR>
                        ถุงเศษ</DIV></td>
                      <td width="6%" valign="middle" class="row3"><DIV align="center">น.น<BR>
                        สุทธิ</DIV></td>
                    </tr>
                  </table>
                </div>
                    <div style="width:100%; height: 150px; overflow: auto;" id="show">
                        <%=htmlText%>                    </div>                    </td>
              </tr>
              <tr>
                <td class='blankspace'><div align="center">
                  <label>
                      <input type="button"  class="cgcButton_5" value="ปิดหน้าจอ" onClick="javasclipt:window.close();">
                  </label>
                </div></td>
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
