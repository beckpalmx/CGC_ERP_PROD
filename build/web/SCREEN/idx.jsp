<%@page import="org.json.JSONObject"%>
<%@page import="javax.json.Json"%>
<%@page import="java.io.PrintWriter"%>
<script src="jquery-1.10.2.js" type="text/javascript"></script>
<input type="button" value="send" onclick="dook();"/>
<script>
function dook() {
    var datas = ({"msg":'Test Message'});
    var jsonobj=JSON.stringify(datas);
    $.ajax({
        data: {para:jsonobj},
        dataType: 'json',
        url: 'newjsp.jsp',
        type: 'POST',
        success: function(ans){
            alert(ans.res);    
        },
        error: function() {
            alert('Ajax readyState: '+xhr.readyState+'\nstatus: '+xhr.status + ' ' + err);
        }
    });
}
</script>