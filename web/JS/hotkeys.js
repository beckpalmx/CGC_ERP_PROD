
document.onkeydown = checkKeycode

function checkKeycode(e) {
var keycode;
if (window.event) keycode = window.event.keyCode;
else if (e) keycode = e.which;
     if(keycode == 113){
       //void(0);
       alert(keycode);
     } else if (keycode == 115){
       alert(keycode);  
     } else if (keycode == 120){
       alert(keycode);  
     }    
}