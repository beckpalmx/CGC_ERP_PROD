<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
    </head>
    <body>
    <table  cellpadding="0"  cellspacing="0">
      <tr>
        <td class="ftopleft"></td>
        <td  class="ftopcenter" colspan="2"><DIV id="u4_rtf4">
            <DIV id="u4_rtf5">
              <DIV id="u9_rtf2">
                <DIV id="u4_rtf">
                  <DIV id="u9_rtf">ยืนยันใบแจ้งคืนถ่านกัมมันต์ที่เหลือจากการผลิตเข้าคลังสินค้า</DIV>
                </DIV>
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
                <td colspan="2" align="right"><b>หมายเลขเอกสาร :</b></td>
              </tr>
              <tr>
                <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
              </tr>
              <tr>
                <td width="156" align="" class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                <td width="600" class="columnobject"><input type='text' class="inputs" name='doc_id2' size='10' value='' />
                  &nbsp;<a href='javascript:;'><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                  วันที่เอกสาร*&nbsp;
                                <input type='text' class="inputs" name='doc_date' size='10' value='' />
                  &nbsp;<a href="javascript:;" id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                  <script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%Y-%m-%d',showsTime:false,button:'date_1',singleClick:true,step:1});</script>
                  &nbsp; เวลา*
                  <input type='text' class="inputs" name='doc_date2' size='10' value='' /></td>
              </tr>
              <tr>
                <td class="columnlabel">แผนก*&nbsp;</td>
                <td class="columnobject"><input type='text' class="inputs" name='prd_emp_id' size='' value='' />
                  <a href='javascript:;'><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;<input type='text' class="inputs" name='input2' size='' value='' /></td>
              </tr>

              <tr>
                <td colspan='2' class='blankspace'></td>
              </tr>
              <tr>
                <td colspan='2' class='blankspace'></td>
              </tr>
              <tr>
                <td height="208" colspan="2" align="center"><div style="width:100%;">
                  <table width="200" border="0" cellpadding="0" cellspacing="1">
                    <tr>
                      <td width="3%" rowspan="2" valign="middle" class="row3"><label>
                        <div align="center">
                          <input type="checkbox" name="checkbox" id="checkbox">
                          </div>
                      </label>                        <div align="center"></div></td>
                      <td width="4%" rowspan="2" valign="middle" class="row3"><div align="center">No.</div>                        <div align="center"></div></td>
                      <td width="12%" rowspan="2" valign="middle" class="row3"><div align="center">เลขที่ใบแจ้งผลิต</div>                        <div align="center"></div></td>
                      <td width="5%" rowspan="2" valign="middle" class="row3"><div align="center">ขนาด</div>                        <div align="center"></div></td>
                      <td width="13%" valign="middle" class="row3"><div align="center">ชนิดของถ่าน</div></td>
                      <td width="7%" rowspan="2" valign="middle" class="row3"><div align="center">ไอโอดีน</div>                        <div align="center"></div></td>
                      <td width="13%" rowspan="2" valign="middle" class="row3"><div align="center">รหัสครบพาเลท<br>
                      / ครบถุง</div>                        <div align="center"></div></td>
                      <td width="6%" rowspan="2" valign="middle" class="row3"><div align="center">เลขที่/<br>
                      ถุงที่</div>                        <div align="center"></div></td>
                      <td width="6%" rowspan="2" valign="middle" class="row3"><div align="center">เครื่อง<br>
                      ผลิต</div>                        <div align="center"></div></td>
                      <td width="6%" rowspan="2" valign="middle" class="row3"><div align="center">ขนาด<br>
                      บรรจุ</div>                        <div align="center"></div></td>
                      <td colspan="3" valign="middle" class="row3"><div align="center">จำนวนคืน</div>                        <div align="center"></div>                        <div align="center"></div></td>
                      <td width="7%" rowspan="2" valign="middle" class="row3"><div align="center">สาเหตุ<br>
                      การคืน</div>                        <div align="center"></div></td>
                    </tr>
                    <tr>
                      <td valign="middle" class="row3"><div align="center">C/P/U/อื่นๆ</div></td>
                      <td width="5%" valign="middle" class="row3"><div align="center">กส/ถุง</div></td>
                      <td width="7%" valign="middle" class="row3"><div align="center">น.น<br>
                      ถุงเศษ</div></td>
                      <td width="6%" valign="middle" class="row3"><div align="center">น.น<br>
                      สุทธิ</div></td>
                    </tr>
                  </table>
                </div>
                    <div style="width:100%; height: 150px; overflow: auto;" id="show"> </div></td>
              </tr>
              <tr>
                <td colspan='2' class='blankspace'></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><div align="right"><span class="columnobject">ผู้นำส่ง*
                      <input type='text' class="inputs" name='input' size='10' value='' />
&nbsp;<a href='javascript:;')><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
<input type='text' class="inputs" name='input' size='30' value='' />
                </span></div></td>
              </tr>
              <tr>
                <td colspan='2' class='blankspace'></td>
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
