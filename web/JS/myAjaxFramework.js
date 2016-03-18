
/* global xhrobject, alertify */

function createRequestObject() //Ajax Create an XMLHttpRequest Object
{
    var requestObjectTemp = false;
    if (window.XMLHttpRequest)
    {
        requestObjectTemp = new XMLHttpRequest();
    }
    else if (window.ActiveXObject)
    {
        requestObjectTemp = new ActiveXObject('Microsoft.XMLHTTP');
    }
    else
    {
        alert("Your browser does not support");
    }
    return requestObjectTemp;
}
function getId(idname)//Return Element By ID
{
    return document.getElementById(idname);
}
function senddataPopup(IDname) // Return Element Popup By ID
{
    return opener.document.getElementById(IDname);
}
function readDatainnerHTML(DIVID, xhrObject)
{
    return getId(DIVID).innerHTML = xhrobject.responseText;
}
//---------------------------------------------------------------------
function getSave(array)//การส่งข้อมูลแบบ Ajax
{
    //var obj = getId(show);
    var URL = array[0];
    var IDname = array[1];
    var xhr = createRequestObject();
    var chknull = new Array;
    chknull = IDname.split(",");
    var al;
    if (ChkParameter(chknull)) {
        if (xhr !== null)
        {
            xhr.open("GET", URL);
            xhr.onreadystatechange = function()
            {
                if (xhr.readyState === 4 && xhr.status === 200)
                {
                    al = xhr.responseText;
                    al = Trim(al);

                    if (al === "LOGIN") {
                        window.location.href = "SCREEN/main.html";
                    } else if (al === "edit") {
                        confirmDialogEdit(array);
                    } else {
                        if (al !== "") {
                            alert(al);
                            ResetParameter(IDname);
                        } else {
                            ResetParameter(IDname);
                        }
                        //ResetParameter();
                    }
                }
                //obj.innerHTML = "status:" + xhr.responseText;            
            };
        }
        xhr.send(null);
    }
    /*if(al !== ""){
     
     }*/
}
//---------------------------------------------------------------------
function getEdit(array)//การส่งข้อมูลแบบ Ajax
{
    //var obj = getId(show);
    var URL = array[0];
    var IDname = array[1];
    var xhr = createRequestObject();
    var chknull = new Array;
    chknull = IDname.split(",");
    var al;
    if (ChkParameter(chknull)) {
        if (xhr !== null)
        {
            xhr.open("GET", URL + "&confirm=true");
            xhr.onreadystatechange = function()
            {
                if (xhr.readyState === 4 && xhr.status === 200)
                {
                    al = xhr.responseText;
                    al = Trim(al);

                    if (al !== "") {
                        alert(al);
                        ResetParameter(IDname);
                    } else {
                        ResetParameter(IDname);
                    }


                }
            };
        }
        xhr.send(null);
    }
    /*if(al !== ""){
     
     }*/
}
//---------------------------------------------------------------------
function getEdit_img(array)//การส่งข้อมูลแบบ Ajax
{
    //var obj = getId(show);
    var URL = array[0];
    var IDname = array[1];
    var xhr = createRequestObject();
    var chknull = new Array;
    chknull = IDname.split(",");
    var al;
    if (ChkParameter(chknull)) {
        if (xhr !== null)
        {
            xhr.open("GET", URL + "&confirm=true");
            xhr.onreadystatechange = function()
            {
                if (xhr.readyState === 4 && xhr.status === 200)
                {
                    al = xhr.responseText;
                    al = Trim(al);
                    if (al !== "") {
                        alert(al);
                        document.getElementById("imgLoading").style.display = 'none';
                        document.getElementById("showpage").style.display = '';
                        ResetParameter();
                    } else {
                        document.getElementById("imgLoading").style.display = 'none';
                        document.getElementById("showpage").style.display = '';
                        ResetParameter(IDname);
                    }
                }
            };
        }
        xhr.send(null);
    }
}
//---------------------------------------------------------------------
function LTrim(str) {
    if (str === null) {
        return null;
    }
    for (var i = 0; str.charAt(i) === "\n"; i++)
        ;
    return str.substring(i, str.length);
}
function RTrim(str) {
    if (str === null) {
        return null;
    }
    for (var i = str.length - 1; str.charAt(i) === "\n"; i--)
        ;
    return str.substring(0, i + 1);
}
function Trim(str) {
    return LTrim(RTrim(str));
}
//---------------------------------------------------------------------
function gettoShow(dataInput, getIdshow)//เรียกข้อมูลตอน Brown แล้วข้อมูลทั้งหมดจะไปอยู่ที่ช่องที่กำหนดให้
{
    var arryData = new Array;
    var arryID = new Array;
    arryData = dataInput.split("|");
    arryID = getIdshow.split("|");

    //sendShow_Detail(URLShowDetail, DivShow, Valueinput);

    for (var i = 0; i < arryData.length; i++)
    {
        if (arryID[i] === "status") { //---> ตรวจสอบ สถานะพนักงาน
            if (arryData[i] === "Y") { //---> ตรวจสอบ ค่า Null
                opener.document.getElementById("radio1").checked = true;
            } else
                opener.document.getElementById("radio2").checked = true;
        }

        if (arryID[i] === "payment_method") { //---> ตรวจสอบ วิธีการจ่ายเงิน
            if (arryData[i] === "0")
            {
                opener.document.getElementById("radio1").checked = true;
            } else if (arryData[i] === "1")
            {
                opener.document.getElementById("radio2").checked = true;
            } else if (arryData[i] === "2")
            {
                opener.document.getElementById("radio3").checked = true;
            } else
            {
                opener.document.getElementById("radio1").checked = false;
                opener.document.getElementById("radio2").checked = false;
                opener.document.getElementById("radio3").checked = false;
            }
        }

        if (arryID[i] === "lab_not_check") {
            //alert("arryID[i] = " + arryID[i]);
            if (arryData[i] === "Y") {
                senddataPopup("lab_not_check").checked = true;
            } else {
                senddataPopup("lab_not_check").checked = false;
            }
        }

        if (arryID[i] === "qc_check") {
            if (arryData[i] === "Y") {
                senddataPopup("chkbox_qc").checked = true;
            } else {
                senddataPopup("chkbox_qc").checked = false;
            }
        }
        if (arryID[i] === "type_cost") {
            if (arryData[i] === "Y") {
                senddataPopup("type_cost").checked = true;
                opener.document.getElementById("cost_value").readOnly = true;
            } else {
                senddataPopup("type_cost").checked = false;
                opener.document.getElementById("cost_value").readOnly = false;
            }
        }

        /*
         if (arryID[i] == "complete_flag") {
         if (arryData[i] == "Y") {
         senddataPopup("complete_flag").checked = true;
         opener.document.getElementById("complete_flag").readOnly = true;
         } else {
         senddataPopup("complete_flag").checked = false;
         opener.document.getElementById("complete_flag").readOnly = false;
         }
         }
         */

        if (arryID[i] === "complete_flag") {
            opener.document.getElementById(arryID[i]).value = arryData[i];
            opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
            opener.document.getElementById(arryID[i]).disabled = arryData[i] === "N" ? false : true;
        }

        //alert("ok 2" + arryData[i]);
        if (arryData[i] !== "null") {
            if (arryID[i] === "remark") {
                //for (var y = 0; y < arryData[i].length; y++) {
                for (var y = 0; y < arryData[i].size; y++) {
                    //alert("ok 2");
                    arryData[i] = arryData[i].replace('<br>', '\n');
                }
                opener.document.getElementById(arryID[i]).value = arryData[i].replace('<br>', '\n');
                //alert("ok 3");
            } else if (arryID[i] === "price_flag") {
                opener.document.getElementById(arryID[i]).value = arryData[i];
                opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
            } else {
                opener.document.getElementById(arryID[i]).value = arryData[i];
            }
        } else {
            opener.document.getElementById(arryID[i]).value = '';
        }

    }
    window.close();
}
//---------------------------------------------------------------------
function IsNumeric(sText, obj)//javascript ที่ดักข้อมูลตัวเลข  keyup sText= this.value,obj = this;
{
    var ValidChars = "0123456789.";
    var IsNumber = true;
    var Char;
    for (i = 0; i < sText.length && IsNumber === true; i++)
    {
        Char = sText.charAt(i);
        if (ValidChars.indexOf(Char) === -1)
        {
            IsNumber = false;
        }
    }
    if (IsNumber === false) {
        alert("Entry Number Only !!!");
        obj.value = sText.substr(0, sText.length - 1);
    }
}
//---------------------------------------------------------------------
function URLsend(IDname, URLwork)//เป็นการรวมข้อมูลการก่อนการSend ID=name áÅÐ ID=code  àÇÅÒàÃÕÂ¡ãªé ¡ç¨Ðà»ç¹ URLsend('name,code',test.jsp) ¤èÒ·Õèä´é¡ÅÑºÁÒ¨Ðà»ç¹  test.jsp?name=&code=
{
    var URL = URLwork + "?";
    var arry = new Array;
    arry = IDname.split(",");

    for (var i = 0; i < arry.length; i++)
    {
        if (i === 0)
        {
            if (arry[i] !== null) {
                URL = URL + arry[i] + "=" + encodeToHex(getId(arry[i]).value);
            }
        }
        else
        {
            //alert(URL);
            //out.println(URL);
            if (arry[i] !== null) {
                URL = URL + "&" + arry[i] + "=" + encodeToHex(getId(arry[i]).value);
            }
        }
    }
    var arry2 = new Array;
    arry2[0] = URL;
    arry2[1] = IDname;
    return arry2;

}

//---------------------------------------------------------------------
function confirmDialogSave(URL)
{
    var r = confirm("คุณต้องการบันทึกข้อมูลนี้ใช่หรือไม่ ?");
    if (r === true)
    {
        getSave(URL);
    }

}
//---------------------------------------------------------------------
function confirmDialogDelete(URL)//
{
    var r = confirm("ต้องการลบข้อมูลนี้ ?");
    if (r === true)
    {
        getSave(URL);
    }
}
//-----------------------------------------------------------------------
function confirmDialogEdit(URL)
{
    //var r = confirm("คุณต้องการแก้ไขข้อมูลนี้ใช่หรือไม่");
    var r = confirm(" ต้องการแก้ไขข้อมูลที่มีอยู่แล้วใช่หรือไม่ ? (Update DATA)");

    if (r === true)
    {
        getEdit(URL);
    }

}
//-----------------------------------------------------------------------
function confirmDialogEdit_img(URL)
{
    var r = confirm("Update DATA ?");
    if (r === true)
    {
        getEdit_img(URL);
    } else {
        document.getElementById("imgLoading").style.display = 'none';
        document.getElementById("showpage").style.display = '';
    }

}
//---------------------------------------------------------------------
function ResetParameter(IDname)//ยกเลิกข้อมูลทั้งหมดของหน้าจอ
{
    cancelAction();
    /* var arryID = new Array;
     arryID = IDname.split(",");
     for(i=0; i < arryID.length; i++)
     {
     if(arryID[i] == "status_d" || arryID[i] == "chkstatus")
     getId(arryID[i]).value = "3";
     else if(arryID[i] == "chkNull"){
     
     }else
     getId(arryID[i]).value = "";
     }*/
}
//---------------------------------------------------------------------
function ChkParameter(ChkNull)//ตรวจสอบข้อมูลที่กำหนดว่ามีการกรอกหรือยังไม่ทำการกรอกถ้ายังกรอกไม่ครบจะทำการระบุช่องที่กรอกข้อมูลให้
{
    var re = true;
    if (ChkNull[0] === 'chkNull') {
        var arryID = new Array;
        arryID = getId(ChkNull[0]).value.split(",");
        for (var i = 0; i < arryID.length; i++)
        {
            if (getId(arryID[i]).value === "") {
                alert('ข้อมูลไม่ครบถ้วน !' + getId(arryID[i]).value);
                getId(arryID[i]).focus();
                re = false;
                break;
            }
        }
    }
    return re;
}

//---------------------------------------------------------------------

function gettoShowpage4(dataInput, getIdshow)//การบันทึกหน้าจอของ CS_004
{
    var arryData = new Array;
    var arryID = new Array;
    arryData = dataInput.split(",");

    //alert(arryData.valueOf()+arryData.length);
    arryID = getIdshow.split(",");
    //alert(arryID.valueOf());
    for (i = 0; i < arryData.length - 1; i++)
    {
        if (arryData[i] === arryID[i])
        {
            senddataPopup(arryID[i]).checked = true;
            senddataPopup(arryID[i]).value = arryData[i];
        }
        else
        {
            senddataPopup(arryID[i]).checked = false;
        }
        //else
        //{
        //	senddataPopup(arryID[i]).checked = false;
        //}

        senddataPopup(arryID[i]).value = arryData[i];

    }
    window.close();
}
//---------------------------------------------------------------------
function cancelAction()//การ Reset หน้าจอทั้งหมด
{
    var formInputs = document.getElementsByTagName('input');
    for (var i = 0; i < formInputs.length; i++) {
        var theInput = formInputs[i];
        if (theInput.type === 'text' || theInput.type === 'checkbox' || theInput.type === 'radio' || theInput.type === 'password') {
            if (theInput.type === 'checkbox' || theInput.type === 'radio') {
                theInput.checked = false;
                theInput.disabled = false;
            } else {
                if (theInput.id !== "process_id1" && theInput.id !== "process_name1") {
                    theInput.value = '';
                    theInput.checked = false;
                    theInput.disabled = false;
                }

            }
        }
    }
    var formArea = document.getElementsByTagName('textarea');
    for (var j = 0; j < formArea.length; j++) {
        var theArea = formArea[j];
        theArea.value = '';
    }
}
//---------------------------ไว้โชว์ข้อมูลส่วน Detail แบบ Ajax------------------------------------------
function sendShow_Detail(URLShowDetail, DivShow, Valueinput) {
    var obj = senddataPopup(DivShow);
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {

        requestObject.open("GET", URLShowDetail + Valueinput + "&ts=" + Math.random() + new Date().getTime());
        requestObject.onreadystatechange = function()
        {
            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                obj.innerHTML = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }
}

function gettoShow_Doc_id(dataInput, getIdshow, URLShowDetail, DivShow, Valueinput)
{
    sendShow_Detail(URLShowDetail, DivShow, Valueinput);
    var arryData = new Array;
    var arryID = new Array;
    arryData = dataInput.split("|");
    arryID = getIdshow.split("|");
    for (var i = 0; i < arryData.length; i++)
    {
        //alert(arryData[i] );
        //senddataPopup(arryID[0]).readOnly =true;
        if (arryData[i] !== "null") {
            //alert(arryData[i]);
            //opener.document.getElementById(arryID[i]).value = arryData[i];
            if (arryID[i] === "approve_status") { //---> ตรวจสอบการ Approve
                if (arryData[i] !== "Y") { //---> ตรวจสอบ ค่า Null
                    opener.document.getElementById("radio1").checked = true;
                    opener.document.getElementById("radio1").disabled = false;
                    opener.document.getElementById("radio2").disabled = false;
                } else {
                    opener.document.getElementById("radio2").checked = true;
                    opener.document.getElementById("radio1").disabled = true;
                    opener.document.getElementById("radio2").disabled = true;
                }
            }

            if (arryID[i] === "status") { //---> ตรวจสอบการ status
                if (arryData[i] !== "Y") { //---> ตรวจสอบ ค่า Null
                    opener.document.getElementById("radio1").checked = true;
                } else {
                    opener.document.getElementById("radio2").checked = true;
                }
            }

            if (arryID[i] === "remark") {
                for (var y = 0; y < arryData[i].length; y++) {
                    arryData[i] = arryData[i].replace('<br>', '\n');
                }
                opener.document.getElementById(arryID[i]).value = arryData[i].replace('<br>', '\n');
            } else if (arryID[i] === "price_flag") {
                opener.document.getElementById(arryID[i]).value = arryData[i];
                opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
            } else if (arryID[i] === "document_confirm_flag") {
                opener.document.getElementById(arryID[i]).value = arryData[i];
                opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
                opener.document.getElementById(arryID[i]).disabled = arryData[i] === "N" ? false : true;
            } else if (arryID[i] === "product_confirm") {
                opener.document.getElementById(arryID[i]).value = arryData[i];
                opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
                opener.document.getElementById(arryID[i]).disabled = arryData[i] === "N" ? false : true;
            } else if (arryID[i] === "quality_confirm") {
                opener.document.getElementById(arryID[i]).value = arryData[i];
                opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
                opener.document.getElementById(arryID[i]).disabled = arryData[i] === "N" ? false : true;
            } else if (arryID[i] === "wh_emp_confirm") {
                opener.document.getElementById(arryID[i]).value = arryData[i];
                opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
                opener.document.getElementById(arryID[i]).disabled = arryData[i] === "N" ? false : true;
            } else if (arryID[i] === "wh_leader_confirm") {
                opener.document.getElementById(arryID[i]).value = arryData[i];
                opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
                opener.document.getElementById(arryID[i]).disabled = arryData[i] === "N" ? false : true;
            } else if (arryID[i] === "A_complete_flag") {
                opener.document.getElementById(arryID[i]).value = arryData[i];
                opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
                opener.document.getElementById(arryID[i]).disabled = arryData[i] === "N" ? false : true;
            } else if (arryID[i] === "complete_flag") {
                opener.document.getElementById(arryID[i]).value = arryData[i];
                opener.document.getElementById(arryID[i]).checked = arryData[i] === "N" ? false : true;
                opener.document.getElementById(arryID[i]).disabled = arryData[i] === "N" ? false : true;
            } else {
                opener.document.getElementById(arryID[i]).value = arryData[i];
            }
            //senddataPopup(arryID[i]).value = arryData[i];
        } else {

            senddataPopup(arryID[i]).value = "";
            //opener.document.getElementById(arryID[i]).value = '';
        }
        //senddataPopup(arryID[i]).value = arryData[i];

    }
    //gettoShow(dataInput, getIdshow);
    senddataPopup("status_cancle").value = "1";
    setTimeout('window.close()', 1000);
}

function gettoShow_Code_id(dataInput, getIdshow, URLShowDetail, DivShow, Valueinput)
{
    sendShow_Detail(URLShowDetail, DivShow, Valueinput);
    var arryData = new Array;
    var arryID = new Array;
    arryData = dataInput.split("|");
    arryID = getIdshow.split("|");
    for (var i = 0; i < arryData.length; i++)
    {
        //alert(arryData[i]);

        //senddataPopup(arryID[0]).readOnly =true;

        if (arryData[i] !== "null") {

            //alert(arryData[i]);
            //opener.document.getElementById(arryID[i]).value = arryData[i];

            if (arryID[i] === "status") { //---> ตรวจสอบการ status
                if (arryData[i] !== "Y") { //---> ตรวจสอบ ค่า Null
                    opener.document.getElementById("radio1").checked = true;
                } else {
                    opener.document.getElementById("radio2").checked = true;
                }
            }

            if (arryID[i] === "remark") {
                for (var y = 0; y < arryData[i].length; y++) {
                    arryData[i] = arryData[i].replace('<br>', '\n');
                }
                opener.document.getElementById(arryID[i]).value = arryData[i].replace('<br>', '\n');
            }

            opener.document.getElementById(arryID[i]).value = arryData[i];

        } else {

            senddataPopup(arryID[i]).value = "";
            //opener.document.getElementById(arryID[i]).value = '';
        }
        //senddataPopup(arryID[i]).value = arryData[i];

    }
    //gettoShow(dataInput, getIdshow);
    //alert("Final Out = ");
    senddataPopup("status_cancle").value = "1";
    setTimeout('window.close()', 1000);
}


//---------------------------------------------------------------------
function Delete_Line_no(URL)
{
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {
        // alert(URL+getId(Valueinput).value+"&ts="+Math.random()+new Date().getTime());
        requestObject.open("GET", URL + "&ts=" + Math.random() + new Date().getTime());

        //alert(URL+senddataPopup(Valueinput).value+"&ts="+Math.random()+"&ts2="+new Date().getTime());

        //alert(requestObject.responseText);
        requestObject.onreadystatechange = function()
        {
            //alert(requestObject.responseText);

            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                //alert("สำเร็จ");
                //obj.innerHTML = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }
//window.close();
}
//---------------------------------------------------------------------

function getIDElements(inputType, Check_indexOf) {
    var strId = "";
    var formInputs = document.getElementsByTagName(inputType);
    for (var i = 0; i < formInputs.length; i++) {

        var theInput = formInputs[i];
        //if(theInput.type == 'text' || theInput.type){
        if (theInput.id.toString().indexOf(Check_indexOf) !== -1) {
            strId += theInput.id.toString() + ",";
        }

//}

    }
    return strId;
}

function showTableNonPopup(DivShow, Valueinput, URL)//ส่งพารามิเตอร์ได้1ตัว
{
    var obj = getId(DivShow);
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {
        // alert(URL+getId(Valueinput).value+"&ts="+Math.random()+new Date().getTime());
        requestObject.open("GET", URL + getId(Valueinput).value + "&ts=" + Math.random() + new Date().getTime());

        //alert(URL+senddataPopup(Valueinput).value+"&ts="+Math.random()+"&ts2="+new Date().getTime());

        //alert(requestObject.responseText);
        requestObject.onreadystatechange = function()
        {
            //alert(requestObject.responseText);

            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                //alert("สำเร็จ");
                obj.innerHTML = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }
//window.close();


}
//---------------------------------------------------------------------
function showTableNonPopup2(DivShow, Valueinput1, URL)//ส่งพารามิเตอร์ได้หลายตัว
{
    var obj = getId(DivShow);
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {
        var split_id = Valueinput1.split(",");
        for (var i = 0; i < split_id.length; i++) {
            if (i === 0) {
                URL += "?" + split_id[i] + "=" + encodeToHex(getId(split_id[i]).value);
            } else {
                URL += "&" + split_id[i] + "=" + encodeToHex(getId(split_id[i]).value);
            }
        }
        //alert(URL);
        requestObject.open("GET", URL + "&ts=" + Math.random() + new Date().getTime());
        requestObject.onreadystatechange = function()
        {
            //alert(requestObject.responseText);

            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                //alert("สำเร็จ");
                obj.innerHTML = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }
//window.close();


}
//---------------------------------------------------------------------
//---------------------------------------------------------------------
function showTableNonPopupApprove(DivShow, Value_Process, Value_Table, Value_doc_id, URL)
{
    var obj = getId(DivShow);
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {
        //alert(URL+"?process_id="+getId(Value_Process).value+"&table="+getId(Value_Table).value+"&doc_id="+getId(Value_doc_id).value+"&ts="+Math.random()+new Date().getTime());
        requestObject.open("GET", URL + "?process_id=" + getId(Value_Process).value + "&table=" + getId(Value_Table).value + "&doc_id=" + getId(Value_doc_id).value + "&ts=" + Math.random() + new Date().getTime());

        //alert(URL+senddataPopup(Valueinput).value+"&ts="+Math.random()+"&ts2="+new Date().getTime());

        //alert(requestObject.responseText);
        requestObject.onreadystatechange = function()
        {
            //alert(requestObject.responseText);

            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                //alert("สำเร็จ");
                obj.innerHTML = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }
//window.close();


}
//---------------------------------------------------------------------
function showTable(DivShow, Valueinput, URL)
{
    var obj = senddataPopup(DivShow);
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {

        requestObject.open("GET", URL + senddataPopup(Valueinput).value + "&ts=" + Math.random() + new Date().getTime());
        requestObject.onreadystatechange = function()
        {
            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                obj.innerHTML = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }


}
//---------------------------------------------------------------------
function showTable2(DivShow, Valueinput1, URL)
{
    var obj = senddataPopup(DivShow);
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {
        var split_id = Valueinput1.split(",");
        for (var i = 0; i < split_id.length; i++) {
            if (i === 0) {
                URL += "?" + split_id[i] + "=" + encodeToHex(getId(split_id[i]).value);
            } else {
                URL += "&" + split_id[i] + "=" + encodeToHex(getId(split_id[i]).value);
            }
        }
        //alert(URL);
        requestObject.open("GET", URL + "&ts=" + Math.random() + new Date().getTime());
        requestObject.onreadystatechange = function()
        {
            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                obj.innerHTML = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }


}
//---------------------------------------------------------------------

var my_window = null;
var t;

function openBrWindow(table, page, jsp) { //v2.0

    if (my_window === null) {
        openpopup(table, page, jsp);
    } else {
        closepopup();
        openpopup(table, page, jsp);
    }
}

function openpopup(table, page, jsp) {

    if (jsp.trim() === ("Search_Config_Display.jsp")) {
        t = '../SEARCHSCREEN/' + jsp + '?page=' + page + '&table=' + table;
        my_window = window.open(t, "mywindow", "status=1,width=730,height=480");
        //alert(" t1 = " + t);   
    } else if (jsp.trim() === ("Search_Doc_id.jsp") || jsp.trim() === ("Search_Doc_id2.jsp") || jsp.trim() === ("Search_Detail_Carbon_Size.jsp")
            || jsp.trim() === ("Search_Detail_Desc.jsp") || jsp.trim() === ("Search_Detail_Desc2.jsp")) {
        t = '../SEARCHSCREEN/' + jsp + '?page=' + page + '&table=' + table;
        my_window = window.open(t, "mywindow", "status=1,width=560,height=530");
    } else if (jsp.trim() === ("Search_Config.jsp")) {
        t = '../SEARCHSCREEN/' + jsp + '?page=' + page + '&table=' + table;
        my_window = window.open(t, "mywindow", "status=1,width=560,height=560");
    } else if (jsp.trim() === ("Search_Detail.jsp") || jsp.trim() === ("Search_Config_Integer.jsp")) {
        t = '../SEARCHSCREEN/' + jsp + '?page=' + page + '&table=' + table;
        my_window = window.open(t, "mywindow", "status=1,width=560,height=520");
    } else if (jsp.trim() === ("Search_Config2.jsp") || jsp.trim() === ("SearchWareHouse.jsp")) {
        t = '../SEARCHSCREEN/' + jsp + '?page=' + page + '&table=' + table;
        my_window = window.open(t, "mywindow", "status=1,width=560,height=530");
    } else if (jsp.trim() === ("Search_ConfigProductPrice.jsp")|| jsp.trim() === ("Search_ConfigRawMatt.jsp")) {
        t = '../SEARCHSCREEN/' + jsp + '?page=' + page + '&table=' + table;
        my_window = window.open(t, "mywindow", "status=1,width=730,height=520");
    } else if (jsp.trim() === ("Search_Config2_1.jsp") || jsp.trim() === ("Search_Detail_ProductID.jsp")) {
        t = '../SEARCHSCREEN/' + jsp + '?page=' + page + '&table=' + table;
        my_window = window.open(t, "mywindow", "status=1,width=730,height=600");
    } else {
        t = '../SEARCHSCREEN/' + jsp + '?page=' + page + '&table=' + table;
        my_window = window.open(t, "mywindow", "status=1,width=560,height=520");
    }
}

function closepopup() {
    if (false === my_window.closed) {
        my_window.close();
    }
}

//---------------------------------------------------------------------
function IsNumber2(sText, obj) {
    var ValidChars = "0123456789.";
    var IsNumber = true;
    var Char;
    for (i = 0; i < sText.length && IsNumber === true; i++)
    {
        Char = sText.charAt(i);
        if (ValidChars.indexOf(Char) === -1)
        {
            IsNumber = false;
            break;
        }
    }

    if (IsNumber === false) {
        alert("ป้อนเป็นตัวเลขเท่านั้น !!!");
        //obj.value=sText.substr(0,sText.length-1);
        obj.value = 0;
    }
}
//--------------------------------------------------------------------
function IsNuber(sText, obj)//javascript ตัวเลขอย่างเดียว  keyup sText= this.value,obj = this;
{
    var ValidChars = "0123456789.";
    var IsNumber = true;
    var Char;
    var Isdot = 0;
    var ckreplate = 0;
    for (i = 0; i < sText.length && IsNumber === true; i++)
    {
        Char = sText.charAt(i);
        if (ValidChars.indexOf(Char) === -1)
        {
            IsNumber = false;
        }
        //alert(sText);

        Isdot = (Char.indexOf(".") !== -1) ? Isdot + 1 : Isdot;
        //alert(Isdot);

    }
    /*for(var i = 0 ; i<sText.length ;i++){
     Isdot = (sText.indexOf(".",) != -1)?Isdot+1:Isdot;
     }*/
    if (IsNumber === false) {
        alert("ป้อนเป็นตัวเลขเท่านั้น !!!");
        //obj.value=sText.substr(0,sText.length-1);
        obj.value = 0;
    }

    if (Isdot > 1) {
        for (var i = 0; i < sText.length; i++) {
            Char = sText.charAt(i);
            if (Char.indexOf(".") !== -1 && ckreplate === 0) {
                ckreplate = 1;
            }
            else if (Char.indexOf(".") !== -1 && ckreplate === 1) {
                sText = sText.substr(0, i);
                obj.value = parseFloat(sText).toFixed(2);
                break;
            }

        }
    }
}
//---------------------------------------------------------------------
function MyDate(lang) {
    NDate = new Date();
    var thday = new Array("อาทิตย์", "จันทร์", "อังคาร", "พุธ", "พฤหัส", "ศุกร์", "เสาร์");
    var engDay = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
    var thmonth = new Array("มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม");
    var engMonth = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
    var thDate = thday[NDate.getDay()] + ", " + NDate.getDate() + " " + thmonth[NDate.getMonth()] + " " + (NDate.getUTCFullYear() + 543);
    var engDate = engDay[NDate.getDay()] + ", " + NDate.getDate() + " " + engMonth[NDate.getMonth()] + " " + NDate.getUTCFullYear();
    var result = "";
    if (lang === "tha") {
        result = thDate;
    } else {
        result = engDate;
    }
    document.write(result);
}

//---------------------------------------------------------------------
function MyCurrentDate(lang) {
    NDate = new Date();
    var thDate = NDate.getDate() + "-" + NDate.getMonth() + "-" + (NDate.getUTCFullYear() + 543);
    var result = "";
    if (lang === "tha") {
        result = thDate;
    } else {
        result = engDate;
    }
    document.write(result);
}



//---------------------------------------------------------------------
function getData_d_rawmatt_receive(URL, idshow)
{
    var arrayidshow = new Array;
    var arraycal = new Array;
    arrayidshow = idshow.split(",");
    var requestObject = createRequestObject();
    if (requestObject)
    {
        requestObject.open("GET", URL);
        requestObject.onreadystatechange = function()
        {
            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                if (parseInt(Trim(requestObject.responseText), 10) !== 0) {
                    var arraycal = Trim(requestObject.responseText).split(",");
                    for (i = 0; i < arraycal.length; i++) {
                        getId(arrayidshow[i]).value = arraycal[i];
                    }
                }
                else {
                    alert("ไม่สามารถคำนวณได้");
                }
            }
        };
        requestObject.send(null);
    }
}
function Delete_Line_no(URL)
{
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {
        // alert(URL+getId(Valueinput).value+"&ts="+Math.random()+new Date().getTime());
        requestObject.open("GET", URL + "&ts=" + Math.random() + new Date().getTime());

        //alert(URL+senddataPopup(Valueinput).value+"&ts="+Math.random()+"&ts2="+new Date().getTime());

        //alert(requestObject.responseText);
        requestObject.onreadystatechange = function()
        {
            //alert(requestObject.responseText);

            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                //alert("เธชเธณเน€เธฃเน�เธ�");
                //obj.innerHTML = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }
//window.close();
}

function Delete_Line_no_ShowTotal(URL, IDshowTotal)//140754
{

    var requestObject = createRequestObject();
    if (requestObject !== null)
    {
        requestObject.open("GET", URL + "&ts=" + Math.random() + new Date().getTime());
        requestObject.onreadystatechange = function()
        {

            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                //alert(Trim(requestObject.responseText));
                if (Trim(requestObject.responseText) !== "-1")
                    getId(IDshowTotal).value = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }
//window.close();
}
function Delete_Line_no_ShowTotal2(URL, IDshowTotal)//140754
{
    var arryID = new Array;
    var arryShow = new Array;
    arryID = IDshowTotal.split(",");
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {
        // alert(URL+getId(Valueinput).value+"&ts="+Math.random()+new Date().getTime());
        requestObject.open("GET", URL + "&ts=" + Math.random() + new Date().getTime());

        //alert(URL+senddataPopup(Valueinput).value+"&ts="+Math.random()+"&ts2="+new Date().getTime());

        //alert(requestObject.responseText);
        requestObject.onreadystatechange = function()
        {

            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                //alert(Trim(requestObject.responseText));

                if (Trim(requestObject.responseText) !== "-1") {
                    arryShow = Trim(requestObject.responseText).split(",");
                    for (i = 0; i < arryID.length; i++) {
                        getId(arryID[i]).value = arryShow[i];
                    }
                }

            }

        };
        requestObject.send(null);

    }
//window.close();
}
function gettoShow_Doc_id2(dataInput, getIdshow, URLShowDetail, DivShow, DivShow2, Valueinput)
{
    var splitURL = URLShowDetail.split(",");
    sendShow_Detail(splitURL[0], DivShow, Valueinput);
    sendShow_Detail(splitURL[1], DivShow2, Valueinput);
    var arryData = new Array;
    var arryID = new Array;
    arryData = dataInput.split("|");
    arryID = getIdshow.split("|");

    //alert("Data Array = " + arryID);

    for (var i = 0; i < arryData.length; i++)
    {
        //senddataPopup(arryID[0]).disabled =true;
        if (arryID[i] === "mark_sign" || arryID[i] === "base_plate") {
            if (arryData[i] === "Y" && arryID[i] === "mark_sign") {
                senddataPopup("chkbox_mark_sign").checked = true;
                senddataPopup("mark_sign_desc").disabled = false;
            } else if (arryData[i] === "Y" && arryID[i] === "base_plate") {
                senddataPopup("chkbox_base_plate").checked = true;
                senddataPopup("base_plate_desc").disabled = false;
            } else if (arryData[i] === "N" && arryID[i] === "mark_sign") {
                senddataPopup("chkbox_mark_sign").checked = false;
                senddataPopup("mark_sign_desc").disabled = true;
            } else if (arryData[i] === "N" && arryID[i] === "base_plate") {
                senddataPopup("chkbox_base_plate").checked = false;
                senddataPopup("base_plate_desc").disabled = true;
            }
        }

        if (arryID[i] === "sale_confirm" || arryID[i] === "quality_confirm" || arryID[i] === "prod_confirm" || arryID[i] === "wh_confirm" || arryID[i] === "document_confirm_flag" || arryID[i] === "product_confirm" || arryID[i] === "wh_emp_confirm" || arryID[i] === "wh_leader_confirm" || arryID[i] === "A_complete_flag" || arryID[i] === "complete_flag")
        {
            senddataPopup(arryID[i]).checked = arryData[i] === "Y" ? true : false;
            senddataPopup(arryID[i]).value = arryData[i] === "Y" ? "Y" : "N";
            senddataPopup(arryID[i]).disabled = arryData[i] === "N" ? false : true;
        }

        //************************CS_036****************************

        if (arryID[i] === "job_id_end") {
            senddataPopup("job_id_end").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("job_id_end").value = (arryData[i] === "Y") ? "Y" : "N";
        }
        if (arryID[i] === "job_id_complete") {
            senddataPopup("job_id_complete").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("job_id_complete").value = (arryData[i] === "Y") ? "Y" : "N";
        }
        if (arryID[i] === "mashed_machine_chk") {
            senddataPopup("mashed_machine_chk").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("mashed_machine").disabled = (arryData[i] === "Y") ? false : true;
        }
        if (arryID[i] === "pan_chk") {
            senddataPopup("pan_chk").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("pan").disabled = (arryData[i] === "Y") ? false : true;
        }
        if (arryID[i] === "ball_mill_chk") {
            senddataPopup("ball_mill_chk").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("ball_mill").disabled = (arryData[i] === "Y") ? false : true;
        }
        if (arryID[i] === "pill_flat_chk") {
            senddataPopup("pill_flat_chk").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("pill_flat").disabled = (arryData[i] === "Y") ? false : true;
        }
        if (arryID[i] === "mag_chk") {
            senddataPopup("mag_chk").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("mag").disabled = (arryData[i] === "Y") ? false : true;
        }
        if (arryID[i] === "job_edit_chk") {
            senddataPopup("job_edit_chk").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("job_edit").disabled = (arryData[i] === "Y") ? false : true;
        }
        if (arryID[i] === "wash_chk") {
            senddataPopup("wash_chk").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("wash").disabled = (arryData[i] === "Y") ? false : true;
        }
        if (arryID[i] === "roast_chk") {
            senddataPopup("roast_chk").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("roast").disabled = (arryData[i] === "Y") ? false : true;
        }
        if (arryID[i] === "roast_edit_chk") {
            senddataPopup("roast_edit_chk").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("roast_edit").disabled = (arryData[i] === "Y") ? false : true;
        }
        if (arryID[i] === "confirm_document") {
            senddataPopup("confirm_document").checked = (arryData[i] === "Y") ? true : false;
            //senddataPopup("confirm_document").value = (arryData[i] === "Y")?"Y":"N";
        }
        //***********************************************************


        //** PACKING
        if (arryID[i] === "pack_repacking_status") {
            senddataPopup("pack_repacking_status").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("pack_repacking_status").value = (arryData[i] === "Y") ? "Y" : "N";
        }

        if (arryID[i] === "carbon_trap_status") {
            senddataPopup("carbon_trap_status").checked = (arryData[i] === "Y") ? true : false;
            senddataPopup("carbon_trap_status").value = (arryData[i] === "Y") ? "Y" : "N";
        }

        //**

        if (arryData[i] !== "null") {
            //alert(arryData[i]);
            //opener.document.getElementById(arryID[i]).value = arryData[i];
            if (arryID[i] === "remark") {
                for (var y = 0; y < arryData[i].length; y++) {
                    arryData[i] = arryData[i].replace('<br>', '\n');
                }
                senddataPopup(arryID[i]).value = arryData[i].replace('<br>', '\n');
            } else {
                senddataPopup(arryID[i]).value = arryData[i];
            }
        } else {

            senddataPopup(arryID[i]).value = "";
        }
        senddataPopup("status_cancle").value = "1";
    }


    setTimeout('window.close()', 1000);
}
//**************************************เข้ารหัสเป็น ASCII *************************************************
function encodeToHex(str) {
    var r = "";
    var e = str.length;
    var c = 0;
    var h;
    while (c < e) {
        h = str.charCodeAt(c++).toString(16);
        if (h.indexOf("e") === 0)
        {
            h = (parseInt(h, 16) - parseInt("D60", 16)).toString(16);
            r += "%" + h;
        }
        else {
            if (h !== "d" && h !== "a") {
                r += "%" + h;
            } else {
                r += "<br>";
                //c++;
            }

        }

    }
    //alert(str);
    return r;
}

//*****************************Search_Detail.jsp*****************************************

function gettoShow_Detail(dataInput, getIdshow) {
    if (dataInput.indexOf("|") !== -1 && getIdshow.indexOf("|") !== -1) {
        var arryData = new Array;
        var arryID = new Array;
        arryData = dataInput.split("|");
        arryID = getIdshow.split("|");
        for (var i = 0; i < arryData.length; i++)
        {
            senddataPopup(arryID[i]).value = arryData[i];
        }
    } else {
        if (dataInput.indexOf("|") !== -1) {
            dataInput = dataInput.substr(0, dataInput.indexOf("|"));
        }
        //alert(dataInput);
        senddataPopup(getIdshow).value = dataInput;
    }
    window.close();

}
function cancle_chkboxAll(IDcheckboxall, thisvalue) {

    if (thisvalue === false) {
        getId(IDcheckboxall).checked = false;
    }
}
/*
 function SendReport(URL)
 {
 var requestObject = createRequestObject();
 //alert(URL[0]);
 if(requestObject != null)
 {
 // alert(URL+getId(Valueinput).value+"&ts="+Math.random()+new Date().getTime());
 requestObject.open("GET",URL[0]+"&ts="+Math.random()+new Date().getTime());
 
 //alert(URL+senddataPopup(Valueinput).value+"&ts="+Math.random()+"&ts2="+new Date().getTime());
 
 //alert(requestObject.responseText);
 requestObject.onreadystatechange = function()
 {
 //alert(requestObject.responseText);
 
 if(requestObject.readyState == 4 && requestObject.status == 200)
 {
 //alert("เธชเธณเน€เธฃเน�เธ�");
 //obj.innerHTML = requestObject.responseText;
 }
 
 }
 requestObject.send(null);
 
 }
 //window.close();
 
 }*/

function select_value() {
    getId("product_id_select").value = getId("product_id").value;
}
function click_value() {
    getId("product_id").value = getId("product_id_select").value;
}
function select_value_c() {
    getId("c_type_select").value = getId("c_type").value;
}
function click_value_c() {
    getId("c_type").value = getId("c_type_select").value;
}
function format_Date(str) {
    return str.substr(6, 4) + "-" + str.substr(3, 2) + "-" + str.substr(0, 2);
}
function SelectBoxSearch(value, inputname, stadment) {
    var str = "";
    str = " and " + value + " = '" + getId(inputname).value + "'";
    getId(stadment).value = str;
}
function getsaveApprove(Data, textArea) {
    var count = 0;
    var URL = Data[0];
    var IDname = Data[1];
    var xhr = createRequestObject();
    var al;
    if (xhr !== null)
    {
        xhr.open("GET", URL);
        getId(textArea).value = "กำลังอนุมัติเอกสาร..........กรุณารอสักครู่";
        xhr.onreadystatechange = function()
        {
            if (xhr.readyState === 4 && xhr.status === 200)
            {

                al = xhr.responseText;
                al = Trim(al);
                getId(textArea).value = al;

            }
        };
    }
    xhr.send(null);
//}
}

function getsaveApprove2(Data, textArea) {
    var count = 0;
    var URL = Data[0];
    var IDname = Data[1];
    var xhr = createRequestObject();
    var al;
    if (xhr !== null)
    {
        xhr.open("GET", URL);
        getId(textArea).value = "กำลังประมวลผล..........กรุณารอสักครู่";
        xhr.onreadystatechange = function()
        {
            if (xhr.readyState === 4 && xhr.status === 200)
            {

                al = xhr.responseText;
                al = Trim(al);
                getId(textArea).value = al;

            }
        };
    }
    xhr.send(null);
//}
}

function getsaveApprove3(Data, textArea, progressbar) {
    var count = 0;
    var URL = Data[0];
    var IDname = Data[1];
    var xhr = createRequestObject();
    var al;
    if (xhr !== null)
    {
        xhr.open("GET", URL);
        getId(textArea).value = "กำลังประมวลผล..........กรุณารอสักครู่";
        xhr.onreadystatechange = function()
        {
            if (xhr.readyState === 4 && xhr.status === 200)
            {

                al = xhr.responseText;
                al = Trim(al);
                getId(textArea).value = al;
                alert("al = " + al);
                getId(progressbar).value = "100";
            }
        };
    }
    xhr.send(null);
//}
}


function AjaxRun_id(TextShow, URL) {
    var xhr = createRequestObject();
    if (xhr !== null)
    {
        xhr.open("GET", URL);
        xhr.onreadystatechange = function()
        {
            //getId(textArea).value = "กำลังอนุมัติเอกสาร..........กรุณารอสักครู่";

            if (xhr.readyState === 4 && xhr.status === 200)
            {
                getId(TextShow).value = Trim(xhr.responseText);
            }
        };
    }
    xhr.send(null);
}
function ChkDate(Date_from, Date_to) {
    var return_chk = false;
    var number_day_from = parseInt(Date_from.substr(0, 2), 10);
    var number_month_from = parseInt(Date_from.substr(3, 2), 10);
    var number_year_from = parseInt(Date_from.substr(6, 4), 10);
    var number_day_to = parseInt(Date_to.substr(0, 2), 10);
    var number_month_to = parseInt(Date_to.substr(3, 2), 10);
    var number_year_to = parseInt(Date_to.substr(6, 4), 10);
    var ans_day = number_day_to - number_day_from;
    //alert(ans_day);
    var ans_month = number_month_to - number_month_from;
    //alert(ans_month);
    var ans_year = number_year_to - number_year_from;
    //alert(ans_year);
    if (ans_year < 0) {
        return_chk = true;
    } else if (ans_year === 0) {
        if (ans_month < 0) {
            return_chk = true;
        } else if (ans_month === 0) {
            if (ans_day < 0) {
                return_chk = true;
            } else if (ans_day === 0) {
                return_chk = false;
            } else {
                return_chk = false;
            }
        } else {

            return_chk = false;
        }
    } else {
        return_chk = false;
    }
    return return_chk;
}
function getLogin(Data) {

    var URL = Data[0];
    var IDname = Data[1];
    var xhr = createRequestObject();
    var al;
    if (xhr !== null)
    {
        xhr.open("GET", URL);
        document.getElementById("imgLoading").style.display = '';
        document.getElementById("button").style.display = 'none';
        xhr.onreadystatechange = function()
        {
            if (xhr.readyState === 4 && xhr.status === 200)
            {

                al = xhr.responseText;
                al = Trim(al);
                if (al === "LOGIN") {
                    window.location.href = "SCREEN/main.html";
                } else {
                    alert(al);
                    document.getElementById("imgLoading").style.display = 'none';
                    document.getElementById("button").style.display = '';
                    ResetParameter();
                }
            }
        };
    }
    xhr.send(null);
//}
}
//----------------------------เป็นการนับจำนวนวันตั้งแต่วันถึงวัน-------------จะได้ค่าจำนวยวันทั้งหมดเช่น from 01-01-2554,to 10-01-2554  จะได้ทั้งหมด 10วัน
function Count_Date(value_date_from, value_date_to) {
    var count_date = 0;
    var day_2 = 0;
    //--------------------date_to---------------------------
    var d_to = parseInt(value_date_to.substr(0, 2), 10);
    var m_to = parseInt(value_date_to.substr(3, 2), 10);
    var y_to = parseInt(value_date_to.substr(6, 4), 10);
    //--------------------date_from-------------------------
    var d_from = parseInt(value_date_from.substr(0, 2), 10);
    var m_from = parseInt(value_date_from.substr(3, 2), 10);
    var y_from = parseInt(value_date_to.substr(6, 4), 10);
    //-------------------------------------------------------
    if ((y_to - y_from) === 0) {
        if ((m_to - m_from) === 0) {
            count_date = (d_to - d_from) + 1;
        } else if ((m_to - m_from) === 1) {
            if (m_from === 2) {
                day_2 = ((y_from - 543) % 4) === 0 ? 29 : 28;
                day_2 = (day_2 - d_from) + 1;
                count_date = day_2 + d_to;
            } else if (m_from === 4 || m_from === 6 || m_from === 9 || m_from === 11) {
                count_date = (30 - d_from) + 1;
                count_date = count_date + d_to;
            } else {
                count_date = (31 - d_from) + 1;
                count_date = count_date + d_to;
            }
        } else {
            count_date = 0;
        }

    }
    return count_date;
}

function getsave_imgload(Data) {

    var URL = Data[0];
    var IDname = Data[1];
    var xhr = createRequestObject();
    var chknull = new Array;
    chknull = IDname.split(",");
    var al;
    if (ChkParameter(chknull)) {
        if (xhr !== null)
        {
            xhr.open("GET", URL);
            xhr.onreadystatechange = function()
            {
                document.getElementById("imgLoading").style.display = '';
                document.getElementById("showpage").style.display = 'none';

                if (xhr.readyState === 4 && xhr.status === 200)
                {

                    al = xhr.responseText;
                    al = Trim(al);
                    if (al === "edit") {
                        confirmDialogEdit_img(Data);
                    } else {
                        if (al !== "") {
                            alert(al);
                            document.getElementById("imgLoading").style.display = 'none';
                            document.getElementById("showpage").style.display = '';
                            ResetParameter();
                        } else {
                            document.getElementById("imgLoading").style.display = 'none';
                            document.getElementById("showpage").style.display = '';
                            ResetParameter(IDname);
                        }
                    }
                }
            };
        }
        xhr.send(null);
    }
//}
}
function Trim2(stringinput) {
    var count = 0;
    while (count < stringinput.length) {
        if (stringinput.charAt(count) === "\r") {
            stringinput = stringinput.replace("\r", "");
        } else if (stringinput.charAt(count) === "\n") {
            stringinput = stringinput.replace("\n", "");
        } else {
            count += 1;
        }
    }
    return stringinput;
}

//-----------------------------เวลาเลือกหน้าหย่อยของส่วนdetail----------------------------------------
function showTableNonPopup_Detail(DivShow, Valueinput, Screen, URL)//ส่งพารามิเตอร์ได้2ตัว
{
    var obj = getId(DivShow);
    var requestObject = createRequestObject();
    if (requestObject !== null)
    {
        // alert(URL+getId(Valueinput).value+"&ts="+Math.random()+new Date().getTime());
        //alert(URL+getId(Valueinput).value+"&screen="+getId(Screen).value+"&ts="+Math.random()+new Date().getTime());
        requestObject.open("GET", URL + getId(Valueinput).value + "&screen=" + getId(Screen).value + "&ts=" + Math.random() + new Date().getTime());

        //alert(URL+senddataPopup(Valueinput).value+"&ts="+Math.random()+"&ts2="+new Date().getTime());

        //alert(requestObject.responseText);
        requestObject.onreadystatechange = function()
        {
            //alert(requestObject.responseText);

            if (requestObject.readyState === 4 && requestObject.status === 200)
            {
                //alert("สำเร็จ");
                obj.innerHTML = requestObject.responseText;
            }

        };
        requestObject.send(null);

    }
    //window.close();

    function checkTime(field)
    {
        var errorMsg = "";
        // regular expression to match required time format 
        re = /^(\d{1,2}):(\d{2})(:00)?([ap]m)?$/;
        if (field.value !== '')
        {
            if (regs === field.value.match(re))

            {
                if (regs[4]) { // 12-hour time format with am/pm if(regs[1] < 1 || regs[1] > 12) 

                    {
                        errorMsg = "Invalid value for hours: " + regs[1];
                    }
                } else
                { // 24-hour time format if(regs[1] > 23) 
                    {
                        errorMsg = "Invalid value for hours: " + regs[1];
                    }
                }
                if (!errorMsg && regs[2] > 59) {
                    errorMsg = "Invalid value for minutes: " + regs[2];
                }
            } else {
                errorMsg = "Invalid time format: " + field.value;
            }
        }
        if (errorMsg !== "")

        {
            alert(errorMsg);
            field.focus();
            return false;
        }
        return true;
    }


}

//--------------------------------------------------------------------
function IsStringNum(sText, obj)//javascript ตัวเลขอย่างเดียว  keyup sText= this.value,obj = this;
{
    //alert("OK");
    var ValidChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-";
    var IsNumber = true;
    var Char;
    var Isdot = 0;
    var ckreplate = 0;
    for (i = 0; i < sText.length && IsNumber === true; i++)
    {
        Char = sText.charAt(i);
        if (ValidChars.indexOf(Char) === -1)
        {
            IsNumber = false;
        }
        //alert(sText);

        Isdot = (Char.indexOf(".") !== -1) ? Isdot + 1 : Isdot;
        //alert(Isdot);

    }
    /*for(var i = 0 ; i<sText.length ;i++){
     Isdot = (sText.indexOf(".",) != -1)?Isdot+1:Isdot;
     }*/
    if (IsNumber === false) {
        alert("กรุณาพิมพ์เฉพาะตัวอักษรภาษาอังกฤษ(ตัวใหญ่)และตัวเลขเท่านั้น");
        //obj.value=sText.substr(0,sText.length-1);
        obj.value = '';
    }

    if (Isdot > 1) {
        for (var i = 0; i < sText.length; i++) {
            Char = sText.charAt(i);
            if (Char.indexOf(".") !== -1 && ckreplate === 0) {
                ckreplate = 1;
            }
            else if (Char.indexOf(".") !== -1 && ckreplate === 1) {
                sText = sText.substr(0, i);
                obj.value = parseFloat(sText).toFixed(2);
                break;
            }

        }
    }

    function getCurrentDate(sText) {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear() + 543;

        if (dd < 10) {
            dd = '0' + dd;
        }

        if (mm < 10) {
            mm = '0' + mm;
        }

        stringinput = mm + '-' + dd + '-' + yyyy;
        return stringinput;
    }

}

function confirmSave_Data(a_element, message, action) {

    alertify.confirm("ต้องการบันทึกข้อมูลหรือไม่ ?", function(e) {

        if (e) {
            if (action) {

                getSave_Data(action);
                action(a_element);
            } else {
                alertify.alert("2" + action);
            }
        }
    });
}

function confirmDelete_Data(a_element, message, action) {


    alertify.confirm("ต้องการลบข้อมูลหรือไม่ ?", function(e) {


        if (e) {
            // a_element is the <a> tag that was clicked
            if (action) {
                getSave_Data(action);
                action(a_element);
            } else {
                alertify.alert("2" + action);
            }
        }
    });
}

function getSave_Data(array)//การส่งข้อมูลแบบ Ajax
{
    //var obj = getId(show);
    var URL = array[0];
    var IDname = array[1];
    var xhr = createRequestObject();
    var chknull = new Array;
    chknull = IDname.split(",");
    var al;
    if (ChkParameter_Data(chknull)) {
        if (xhr !== null)
        {
            //alert(xhr);
            xhr.open("GET", URL);
            xhr.onreadystatechange = function()
            {
                if (xhr.readyState === 4 && xhr.status === 200)
                {
                    al = xhr.responseText;
                    al = Trim(al);

                    if (al === "LOGIN") {
                        window.location.href = "SCREEN/main.html";
                    } else if (al === "edit") {
                        //confirmDialogEdit(array);
                        confirmDialogEdit_Data(array);
                    } else {
                        if (al !== "") {
                            //alert(al);    
                            alertify.alert(al);
                            ResetParameter(IDname);
                        } else {
                            ResetParameter(IDname);
                        }
                        //ResetParameter();
                    }

                }
                //obj.innerHTML = "status:" + xhr.responseText;
            };
        }
        xhr.send(null);
    }
    /*if(al !== ""){
     
     }*/
}

function ChkParameter_Data(ChkNull)//ตรวจสอบข้อมูลที่กำหนดว่ามีการกรอกหรือยังไม่ทำการกรอกถ้ายังกรอกไม่ครบจะทำการระบุช่องที่กรอกข้อมูลให้
{
    var re = true;
    if (ChkNull[0] === 'chkNull') {
        var arryID = new Array;
        arryID = getId(ChkNull[0]).value.split(",");
        for (var i = 0; i < arryID.length; i++)
        {
            if (getId(arryID[i]).value === "") {
                //alert('ข้อมูลไม่ครบถ้วน !' + getId(arryID[i]).value);
                alertify.alert('ข้อมูลไม่ครบถ้วน !' + getId(arryID[i]).value);
                getId(arryID[i]).focus();
                re = false;
                break;
            }
        }
    }
    return re;
}

function confirmDialogEdit_Data(URL)
{
    alertify.confirm("ต้องการแก้ไขข้อมูลที่มีอยู่แล้วใช่หรือไม่ ?", function(e) {
        if (e) {
            getEdit_Data(URL);
            //alertify.success("เสร็จสิ้น");
        } else {
            alertify.error("คุณไม่ได้บันทึกข้อมูลที่มีการแก้ไข");
        }
    }
    );
}

function getEdit_Data(array)//การส่งข้อมูลแบบ Ajax
{
    //var obj = getId(show);
    var URL = array[0];
    var IDname = array[1];
    var xhr = createRequestObject();
    var chknull = new Array;
    chknull = IDname.split(",");
    var al;
    if (ChkParameter(chknull)) {
        if (xhr !== null)
        {
            xhr.open("GET", URL + "&confirm=true");
            xhr.onreadystatechange = function()
            {
                if (xhr.readyState === 4 && xhr.status === 200)
                {
                    al = xhr.responseText;
                    al = Trim(al);

                    if (al !== "") {
                        //alertify.alert(al);
                        alertify.success(al);
                        ResetParameter(IDname);
                    } else {
                        ResetParameter(IDname);
                    }


                }
            };
        }
        xhr.send(null);
    }
    /*if(al !== ""){
     
     }*/

    function toFixed_Decimal(num, pre) {
        num *= Math.pow(10, pre);
        num = (Math.round(num, pre) + (((num - Math.round(num, pre)) >= 0.5) ? 1 : 0)) / Math.pow(10, pre);
        return num.toFixed(pre);
    }


}



