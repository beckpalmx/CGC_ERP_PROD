/************************************
******/
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>:: เพิ่มหัวข้อข่าวฝาก ::</title>
<head>

<!--------------เริ่มต้น ตรวจสอบวันเืดือนปี ย้อนหลัง และตรวจเช็คค่าอื่น ๆ ของคุณ Kenny จาก Pantip ------------->
<script language="javascript">
function MyTrim(s) {
while (s.substring(0,1) == ' ') {
s = s.substring(1,s.length);
}
while (s.substring(s.length-1,s.length) == ' ') {
s = s.substring(0,s.length-1);
}
return s;
}

var c=0;
function stripBlanks(fld) {var result = "";for (i=0; i<fld.length; i++) {
if (fld.charAt(i) != " " || c > 0) {result += fld.charAt(i);
if (fld.charAt(i) != " ") c = result.length;}}return result.substr(0,c);}

var numb = '0123456789';

function isValid(parm,val) {if (parm == "") return true;
for (i=0; i<parm.length; i++) {if (val.indexOf(parm.charAt(i),0) == -1)
return false;}return true;}

function isNum(parm) {return isValid(parm,numb);}
var mth = new Array(' ','january','february','march','april','may','june','july','august','september','october','november','december');
var day = new Array(31,28,31,30,31,30,31,31,30,31,30,31);

function validateDate(fld,fmt,rng) {
var dd, mm, yy;var today = new Date;var t = new Date;fld = stripBlanks(fld);
if (MyTrim(fld) == '') {
alert("คุณยังไม่ได้กรอกช่อง วันเดือนปี\nกรุณากรอกในรูปแบบ วว/ดด/ปปปป");
return false;
}

var d1 = fld.split('\/');
if (d1.length != 3) d1 = fld.split(' ');
if (d1.length != 3) return false;
if (fmt == 'u' || fmt == 'U') {
dd = d1[1]; mm = d1[0]; yy = d1[2];}
else if (fmt == 'j' || fmt == 'J') {
dd = d1[2]; mm = d1[1]; yy = d1[0];}
else if (fmt == 'w' || fmt == 'W'){
dd = d1[0]; mm = d1[1]; yy = d1[2];}
else return false;
var n = dd.lastIndexOf('st');
if (n > -1) dd = dd.substr(0,n);
n = dd.lastIndexOf('nd');
if (n > -1) dd = dd.substr(0,n);
n = dd.lastIndexOf('rd');
if (n > -1) dd = dd.substr(0,n);
n = dd.lastIndexOf('th');
if (n > -1) dd = dd.substr(0,n);
n = dd.lastIndexOf(',');
if (n > -1) dd = dd.substr(0,n);
n = mm.lastIndexOf(',');
if (n > -1) mm = mm.substr(0,n);
if (!isNum(dd)) return false;
if (!isNum(yy)) return false;
if (!isNum(mm)) {
var nn = mm.toLowerCase();
for (var i=1; i < 13; i++) {
if (nn == mth[i] ||
nn == mth[i].substr(0,3)) {mm = i; i = 13;}
}
}
if (!isNum(mm)) return false;
dd = parseFloat(dd); mm = parseFloat(mm); yy = parseFloat(yy);

if (yy < 100) yy = yy+2500-543;
else yy=yy-543;

if (yy < 1582 || yy > 4881) return false;
if (mm == 2 && (yy%400 == 0 || (yy%4 == 0 && yy%100 != 0))) day[mm-1]++;
if (mm < 1 || mm > 12) return false;
if (dd < 1 || dd > day[mm-1]) return false;
t.setDate(dd); t.setMonth(mm-1); t.setFullYear(yy);

if (t < today) return false;
else return true;

}

function check_all()
{

if (MyTrim(from_news.date_news.value) == '')
{
alert("คุณยังไม่ได้กรอกช่อง วันเดือนปี\nกรุณากรอกในรูปแบบ วว/ดด/ปปปป");
from_news.date_news.focus();
return false;
}

if (MyTrim(from_news.topic_news.value) == '')
{
alert("คุณยังไม่ได้กรอกช่องหัวข้อข่าว");
from_news.topic_news.focus();
return false;
}

if (MyTrim(from_news.place_news.value) == '')
{
alert("คุณยังไม่ได้กรอกช่องแหล่งที่มาของข่าว");
from_news.place_news.focus();
return false;
}

if (validateDate(from_news.date_news.value,'W','P'))
{
return false;
}
else {
alert("วันเดือนปี ไม่ควรย้อนหลังกรุณากรอกใหม่อีกครั้งครับ");
from_news.date_news.select();
return false;
}
}
//-->
</script>
<!-------------- สิ้นสุด ตรวจสอบวันเืดือนปี ย้อนหลัง ของคุณ Kenny จาก Pantip -------------->

</head>
<body onLoad="document.dateTest.testDateFormat1.focus()">

<form method="post" onSubmit="return validate()" enctype="multipart/form-data" name="from_news" id="from_news">
วัน/เดือน/ปี : <input type='text' class="inputs" name="date_news" size='10' maxlength="10">

<br>
หัวข้อข่าวฝาก :
<input name="topic_news" type='text' class="inputs" id="topic_news" size="100" />
<br>
แหล่งข่าว :
<input name="place_news" type='text' class="inputs" id="place_news" />
<br>

<input name="submitit" type="button" value="บันทึกข่าวฝาก" onClick="javascript:check_all();">
<input name="cancle" type="reset" id="cancle" value="ยกเลิก" />
</form>
<div align="center"><br>
ขอขอบคุณ คุณ Kenny เป็นอย่างสูงที่สละเวลาของท่านช่วยให้คำแนะนำ ความช่วยเหลือ จากปัญหาของผมด้วยดีตลอดมา<br>
ซึ่งผมเองก็เพิ่งจะหัดเขียน
เลยไม่รู้เรื่องอะไรมากนัก ไม่มีอะไรมากเกินความรู้สึกดี ๆ ต่อคุณ kenny ทั้งที่ผมไม่เคยรู้จักกันมาก่อน ขอขอบพระคุณเป็นอย่างสูงครับ
<br>
<br>
เจ้าของกระทู้
</div>
</body>
</html> 