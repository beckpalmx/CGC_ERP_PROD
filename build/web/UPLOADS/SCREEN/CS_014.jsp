<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>    

        <!-- Add fancyBox main JS and CSS files -->
        <script type="text/javascript" src="../JS/source/jquery.fancybox.js?v=2.1.4"></script>
        <link rel="stylesheet" type="text/css" href="../JS/source/jquery.fancybox.css?v=2.1.4" media="screen" />

        <!-- Add Button helper (this is optional) -->
        <link rel="stylesheet" type="text/css" href="../JS/source/helpers/jquery.fancybox-buttons.css?v=1.0.5" />
        <script type="text/javascript" src="../JS/source/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>

        <!-- Add Thumbnail helper (this is optional) -->
        <link rel="stylesheet" type="text/css" href="../JS/source/helpers/jquery.fancybox-thumbs.css?v=1.0.7" />
        <script type="text/javascript" src="../JS/source/helpers/jquery.fancybox-thumbs.js?v=1.0.7"></script>

        <!-- Add Media helper (this is optional) -->
        <script type="text/javascript" src="../JS/source/helpers/jquery.fancybox-media.js?v=1.0.5"></script>      

        <link href="../CSS/component.css" rel="stylesheet" type="text/css">   

        <!--link rel="stylesheet" href="../JS/source/lightbox/css/lightbox.css">
        <script src="../JS/source/lightbox/js/lightbox-plus-jquery.min.js"></script-->


        <script type="text/javascript">

            function Save_Data() {
                file_name = document.getElementById('upload-file-name').textContent;
                str = file_name.toLowerCase();
                suffix = ".jpg";
                suffix2 = ".png";
                var chk_val = 0;
                //alert("str = " + str);
                for (var i = 0; i < str.length; i++) {
                    //alert("str = " + str.charCodeAt(i));
                    if (str.charCodeAt(i) > 161) {
                        //return false;
                        chk_val++;
                    }
                }

                //alert(chk_val);

                if (chk_val == 0) {
                    document.getElementById("str_file").value = str;
                    if (!(str.indexOf(suffix, str.length - suffix.length) !== -1 ||
                            str.indexOf(suffix2, str.length - suffix2.length) !== -1)) {
                        alert('ไฟล์ที่นำเข้าต้องเป็นรูปภาพ  ,\nไฟล์ที่เป็นชนิด *.jpg,*.png เท่านั้น  !!!');
                        document.getElementById('upload-file-name').value = '';
                    } else {
                        confirmDialogSave(URLsend('chkNull,emp_id,name,lname,dept_id,status,remark,str_file', '../JSP/CS_014.jsp'));
                    }
                } else {
                    alert('ไฟล์ที่นำเข้าต้องชื่อไฟล์ภาษาอังกฤษเท่านั้น !!!');
                }
            }

        </script>             

        <script type="text/javascript">

            function submit_uploadfile() {

                document.frm_upload.submit();

            }

        </script>             

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>                             

        <script type="text/javascript">
            $(function() {
                $(":file").change(function() {
                    if (this.files && this.files[0]) {
                        var reader = new FileReader();
                        reader.onload = imageIsLoaded;
                        reader.readAsDataURL(this.files[0]);
                    }
                });
            });

            function imageIsLoaded(e) {
                $('#myImg').attr('src', e.target.result);
            }
            ;
        </script>

        <script type="text/javascript">
            $(document).ready(function() {
                /*
                 *  Simple image gallery. Uses default settings
                 */

                $('.fancybox').fancybox();

                /*
                 *  Different effects
                 */

                // Change title type, overlay closing speed
                $(".fancybox-effects-a").fancybox({
                    helpers: {
                        title: {
                            type: 'outside'
                        },
                        overlay: {
                            speedOut: 0
                        }
                    }
                });

                // Disable opening and closing animations, change title type
                $(".fancybox-effects-b").fancybox({
                    openEffect: 'none',
                    closeEffect: 'none',
                    helpers: {
                        title: {
                            type: 'over'
                        }
                    }
                });

                // Set custom style, close if clicked, change title type and overlay color
                $(".fancybox-effects-c").fancybox({
                    wrapCSS: 'fancybox-custom',
                    closeClick: true,
                    openEffect: 'none',
                    helpers: {
                        title: {
                            type: 'inside'
                        },
                        overlay: {
                            css: {
                                'background': 'rgba(238,238,238,0.85)'
                            }
                        }
                    }
                });

                // Remove padding, set opening and closing animations, close if clicked and disable overlay
                $(".fancybox-effects-d").fancybox({
                    padding: 0,
                    openEffect: 'elastic',
                    openSpeed: 500,
                    closeEffect: 'elastic',
                    closeSpeed: 500,
                    closeClick: true,
                    helpers: {
                        overlay: null
                    }
                });

                /*
                 *  Button helper. Disable animations, hide close button, change title type and content
                 */

                $('.fancybox-buttons').fancybox({
                    openEffect: 'none',
                    closeEffect: 'none',
                    prevEffect: 'none',
                    nextEffect: 'none',
                    closeBtn: false,
                    helpers: {
                        title: {
                            type: 'inside'
                        },
                        buttons: {}
                    },
                    afterLoad: function() {
                        this.title = 'Image ' + (this.index + 1) + ' of ' + this.group.length + (this.title ? ' - ' + this.title : '');
                    }
                });


                /*
                 *  Thumbnail helper. Disable animations, hide close button, arrows and slide to next gallery item if clicked
                 */

                $('.fancybox-thumbs').fancybox({
                    prevEffect: 'none',
                    nextEffect: 'none',
                    closeBtn: false,
                    arrows: false,
                    nextClick: true,
                    helpers: {
                        thumbs: {
                            width: 200,
                            height: 200
                        }
                    }
                });

                /*
                 *  Media helper. Group items, disable animations, hide arrows, enable media and button helpers.
                 */
                $('.fancybox-media')
                        .attr('rel', 'media-gallery')
                        .fancybox({
                            openEffect: 'none',
                            closeEffect: 'none',
                            prevEffect: 'none',
                            nextEffect: 'none',
                            arrows: false,
                            helpers: {
                                media: {},
                                buttons: {}
                            }
                        });

                /*
                 *  Open manually
                 */

                $("#fancybox-manual-a").click(function() {
                    $.fancybox.open('1_b.jpg');
                });

                $("#fancybox-manual-b").click(function() {
                    $.fancybox.open({
                        href: 'iframe.html',
                        type: 'iframe',
                        padding: 5
                    });
                });

                $("#fancybox-manual-c").click(function() {
                    $.fancybox.open([
                        {
                            href: '1_b.jpg',
                            title: 'My title'
                        }, {
                            href: '2_b.jpg',
                            title: '2nd title'
                        }, {
                            href: '3_b.jpg'
                        }
                    ], {
                        helpers: {
                            thumbs: {
                                width: 75,
                                height: 50
                            }
                        }
                    });
                });
            });

            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function(e) {
                        $('#picfile').attr('src', e.target.result);

                    }

                    reader.readAsDataURL(input.files[0]);
                }
            }


            function showResult(input) {
                if (confirm("คุณต้องการโหลดภาพใหม่หรือไม่")) {
                    showTableNonPopup("show", "emp_id", "../SHOWDETAILSCREEN/CS_Show014_IMG.jsp?emp_id=");
                }
            }

            function OpenDocID(input) {
                if (input == 1) {
                    openBrWindow('vemployee_fullname&stadment=and+status+=+\'Y\'', 14, 'Search_Code_id.jsp');
                } else {
                    openBrWindow('vemployee_fullname&stadment=and+status+=+\'N\'', 14, 'Search_Code_id.jsp');
                }
            }

            function Load_Image() {
                showTableNonPopup("show", "emp_id", "../SHOWDETAILSCREEN/CS_Show014_IMG.jsp?emp_id=");
            }

        </script>


        <style type="text/css">
            .fancybox-custom .fancybox-skin {
                box-shadow: 0 0 50px #222;
            }

        </style>        


        <script language="javascript">
            function getStatus() {
                if (document.getElementById("radio1").checked) {
                    document.getElementById("status").value = "Y";
                } else if ((document.getElementById("radio2").checked)) {
                    document.getElementById("status").value = "N";
                }
            }
            function MM_openBrWindow(theURL, winName, features) { //v2.0
                if (my_window == null) {
                    my_window = window.open(theURL, winName, features);
                } else {
                    closepopup();
                    my_window = window.open(theURL, winName, features);
                }
            }
        </script>        

    </head>
    <body onload="Load_Image();">    
        <form class="form-horizontal" name="frm_upload" id="frm_upload" target="uploadtaget" method="post" enctype="multipart/form-data" action="../JSP/CS_UPLOAD_IMAGE.jsp">                        
            <input type="hidden" id="chkstatus" value="1"/>
            <input type="hidden" id="str_file" name="str_file" value=""/>
            <input type="hidden" id="chkNull" value="emp_id,name,lname,dept_id">    
            <input type="hidden" id="status_cancle" value="">
            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-pencil" style="color:white"></span>&nbsp;
                        <b>ทะเบียนพนักงาน (CS_014)</b>
                    </div>                
                    <div class="panel-footer">                            
                        <div class="row">
                            <label class="control-label col-md-3 columnlabel1">รหัสพนักงาน*&nbsp;:&nbsp;</label>
                            <div class="col-md-3 text-primary">                                        
                                <input type='text' class="inputs" size="10" name="emp_id" id="emp_id">
                                <a href='javascript:;'><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' onClick="OpenDocID(1);" data-toggle="tooltip" title="พนักงานปัจจุบัน"></a>
                                &nbsp;<a href='javascript:;'><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' onClick="OpenDocID(2);" data-toggle="tooltip" title="พนักงานที่ลาออก/ปลดออก"></a>
                            </div>           

                            <div class="col-md-3 text-primary">                                        
                                <div id="show"></div>
                            </div>    
                            <div class="col-md-3 text-primary">                                                                                                                
                                <img id="myImg" src="../IMAGES/default.png"  width="100px" height="100px"/>                                    
                            </div>                                
                        </div>                                                   

                        <div class="row">&nbsp;</div>

                        <div class="row">                                
                            <div class="col-md-2 text-primary"></div>
                            <div class="col-md-8 text-primary">
                                <div class="btn btn-success btn-file" data-toggle="tooltip" title="กดเพื่อเลือกรูปพนักงาน">เลือกรูปพนักงาน ...<input type="file" onchange="$('#upload-file-name').html($(this).val());">
                                </div>
                                &nbsp;&nbsp;
                                <button type="button" class="btn btn-danger" data-toggle="tooltip" title="กดเพื่ออัพโหลดรูปภาพ" onClick="submit_uploadfile();"><b>Upload Image</b></button>
                            </div>
                        </div>

                        <div class="row">&nbsp;</div>

                        <div class="row">                                
                            <div class="col-md-2 text-primary"></div>
                            <div class="col-md-8 text-primary">
                                <span class='label label-info' id="upload-file-name"></span>
                            </div>
                        </div>            

                        <div class="row">&nbsp;</div>

                        <div class="row">
                            <label class="control-label col-md-3 columnlabel1">ชื่อ-นามสกุล*&nbsp;:&nbsp;</label>
                            <div class="col-md-6 text-primary">                                        
                                <input type='text' class="inputs" size="25" name="name" id="name">                                    
                                <input type='text' class="inputs" size="25" name="lname" id="lname">                                                              
                            </div>
                        </div>                                                                                                  

                        <div class="row">
                            <label class="control-label col-md-3 columnlabel1">รหัสแผนก*&nbsp;:&nbsp;</label>
                            <div class="col-md-6 text-primary">                                        
                                <input type='text' class="inputs" size="10" name="dept_id" id="dept_id">
                                <a href='javascript:;'><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' onClick="openBrWindow('mdepartment', 14, 'Search_Config2.jsp')" ></a>
                                <input type='text' class="inputs" size="30" name="dept_name" id="dept_name">                                                              
                            </div>
                        </div>    
                        <!--div class="row">&nbsp;</div-->
                        <div class="row">
                            <label class="control-label col-md-3 columnlabel1">สถานะ*&nbsp;:&nbsp;</label>
                            <div class="col-md-6 text-primary"> 
                                <input type="hidden" class="inputs" size="5" id="status" >                                    
                                <input type="radio" name="radio" id="radio1" onClick="getStatus()" checked>
                                ปกติ 
                                <input type="radio" name="radio" id="radio2" onClick="getStatus()">
                                ลาออก/ปลดออก
                            </div>
                        </div>                                
                        <!--div class="row">&nbsp;</div-->
                        <div class="row">
                            <label class="control-label col-md-3 columnlabel1">หมายเหตุ&nbsp;:&nbsp;</label>
                            <div class="col-md-6 text-primary">                              
                                <input type='text' class="inputs" size="70" name="remark" id="remark">
                                <!--textarea class="text_inputs" name="remark" id="remark" cols="45" rows="5"></textarea-->
                            </div>
                        </div>  

                        <div class="row">&nbsp;</div>

                        <table>
                            <tr>
                                <td colspan='2' class='blankspace'>
                                    <div align="center">
                                        <a href="javascript:;" onClick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="Save_Data();"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('emp_id,name,lname,dept_id,status,remark,chkstatus', '../JSP/CS_014.jsp'))"><img alt="" src="../IMAGES/BTN_DEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
