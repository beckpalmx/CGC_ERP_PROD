<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CGC ERP</title>
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
        <title>CGC ERP</title>
        <script type="text/javascript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!==0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
</head>
    <body>

        <form name="btform" method="post" action="">
            <div> 
                <table  cellpadding="0"  cellspacing="0">
                    <tr>
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2"><DIV id="u4_rtf">
                          <DIV id="u4_rtf2">ปรับยอดสินค้า</DIV>
                        </DIV></td>
                        <td class="ftopright"></td>
                    </tr>
                    <tr >
                        <td class="fcenterleft"></td>
                        <td  colspan="2" class="fcentercenter">
                            <div align="center">
                                <table width="94%"  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><b>หมายเลขเอกสาร :</b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                                    </tr>
                                    <tr>
                                        <td width="156" align="" class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                        <td width="600" class="columnobject">
                                            <input type='text' class="inputs" name='doc_id' size='10' value='' />&nbsp;<a href='javascript:;'><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                            วันที่เอกสาร*&nbsp;
                                            <input type='text' class="inputs" name='doc_date' size='10' value='' />
                                            &nbsp;<a href="javascript:;" id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%Y-%m-%d',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;
                                            เวลา*&nbsp;
                                            <input type='text' class="inputs" name='doc_time' size='10' value='' />                                        </td>
                                    </tr>
                                    <tr>
                                      <td class="columnlabel">คลังจ่าย&nbsp;</td>
                                      <td class="columnobject"><select name='____wh_in'>
                                        <option value='W005'>คลัง Semi Product Stk.</option>
                                      </select>
                                        &nbsp;&nbsp;
                                        คลังรับ&nbsp;
                                                <select name='____wh_out'>
                                                  <option value='W006'>คลังผลิต</option>
                                                </select>
                                        &nbsp;&nbsp; </td>
                                    </tr>
                                    <tr>
                                      <td class="columnlabel">เลขกอง*&nbsp;</td>
                                      <td class="columnobject"><input type='text' class="inputs" name='wh_emp_id' size='10' value='' /> 
                                        &nbsp;<a href='javascript:;'><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a></td>
                                    </tr>
                                    <tr>
                                      <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                      <td class="columnobject"><label>
                                        <textarea class="text_inputs" name="textarea" id="textarea" cols="45" rows="5"></textarea>
                                      </label></td>
                                    </tr>
                                    <tr>
                                      <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                      <td colspan="2" align="center"><div style="width:100%;">
                                        <table width="200" border="0" cellpadding="0" cellspacing="1">
                                          <tr>
                                            <td colspan="5" class="h_multi">ข้อมูลการเบิก</td>
                                          </tr>
                                          <tr>
                                            <td width="21%" class="row3"><div align="center">รหัส</div></td>
                                            <td width="17%" class="row3"><div align="center">กลุ่มสินค้า</div></td>
                                            <td width="17%" class="row3"><div align="center">ชนิดสินค้า</div></td>
                                            <td width="23%" class="row3"><div align="center">จำนวน / kg</div></td>
                                            <td width="22%" class="row3"><div align="center">ปรับยอด / kg</div></td>
                                          </tr>
                                        </table>
                                      </div>
                                          <div style="width:100%; height: 150px; overflow: auto;" id="show3"> </div></td>
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center"></td>
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
            </div>
        </form>
</body>
</html>
