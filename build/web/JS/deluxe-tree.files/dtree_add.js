//**************************************************
//  Trial Version
//
//
//  Deluxe Tree (c) 2006 - 2011, by Deluxe-Tree.com
//  version 4.1
//  http://deluxe-tree.com
//  E-mail:  support@deluxe-menu.com
//
//  ------
//  Obfuscated by Javascript Obfuscator
//  http://javascript-source.com

//
//**************************************************

function tbdl(){return[tpo?tbpb.scrollLeft:pageXOffset,tpo?tbpb.scrollTop:pageYOffset];}function tbIj(tddp,c,n){var tcq=(n-c)/tddp;with(Math){if(abs(tcq)<1){tcq=abs(tcq)/tcq;}}return c+(c!=n?tcq:0)+"px";}function td1o(){if(tmoveRec.tIc){return;}for(var j=0;j<tI.length;j++){with(tI[j]){if(tbld&&tdd){var toq=tbd(id+"div");var tqd=tbdo(toq);if(isNaN(tqd[0])||isNaN(tqd[1])){return;}var tb1q=tbdl();var x=tb1q[0]+parseInt(left);var y=tb1q[1]+parseInt(top);if(tdbq&&tqd[0]!=x){toq.style.left=tbIj(tfloatIterations,tqd[0],x);}if(tdbc&&tqd[1]!=y){toq.style.top=tbIj(tfloatIterations,tqd[1],y);}}}}}var tbob=null;function tdld(){return tmoveRec.tIc?false:true;}function tbib(e){if(tbll&&tlo){e=window.event;}with(e){return[tlo||tIj?clientX:pageX,tlo||tIj?clientY:pageY];}}function tdqj(){if(dtdo.attachEvent){dtdo.attachEvent("onmousemove",tbii);if(tlo){dtdo.attachEvent("onselectstart",tdld);}}else{tbob=dtdo.onmousemove;dtdo.onmousemove=function(e){tbii(e);if(tbob){tbob();}return true;};}}function td1l(tdbb,tbb){with(tmoveRec){if(!tbdb||tIc){return;}tpq=tI[tbb];toq=tbd(tpq.id+"div");var tjc=tbib(tdbb);var tqd=tbdo(toq);var tlI=tpo?tbdl():[0,0];tboI=tjc[0]-tqd[0]+tlI[0];tboi=tjc[1]-tqd[1]+tlI[1];tIc=1;}}function tbii(event){with(tmoveRec){if(tIc&&tbdb){var tjc=tbib(event);var tlI=tpo?tbdl():[0,0];var tb1d=tjc[0]-tboI+tlI[0];var tb1p=tjc[1]-tboi+tlI[1];with(toq.style){left=(tb1d>=0?tb1d:0)+"px";top=(tb1p>=0?tb1p:0)+"px";}}}return true;}function td11(){with(tmoveRec){if(!tbdb||!tIc){return;}var tlI=tbdl();var tqd=tbdo(toq);tpq.left=tqd[0]-tlI[0];tpq.top=tqd[1]-tlI[1];tIc=0;}}