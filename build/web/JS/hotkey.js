//----------------------------------------------HOT KEY ---------------------------------------------->
// f6=save 
//f7=update
//f8=delete
//f9=search
//function myKeyDownHandler(){
    
//}

//if(document.layers)
//     document.captureEvents(Event.KEYDOWN);
//	document.onkeydown = key;
        
function myKeyDownHandler(e){
	key=event.keyCode;	
	alert(key);
	if(key==113){
        alert(key);//GoSave();
	}else if(key==118){
        alert(key);//  GoUpdate();
	}else if(key==119){
            alert(key);//GoDelete();
	}else  if(key==120){
           alert(key);//GoSearch();
	}else  if(key==121){
           alert("f10");
	}
}
//--------------------------------------------------------------------------------------------->
