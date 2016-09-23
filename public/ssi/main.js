<!--
var http_request = false;
var target='f2';

function xRequest(url, parameters) {
   http_request = false;
   if (window.XMLHttpRequest) { // Mozilla, Safari,...
      http_request = new XMLHttpRequest();
      if (http_request.overrideMimeType) {
         http_request.overrideMimeType('text/html');
      }
   } else if (window.ActiveXObject) { // IE
      try {
         http_request = new ActiveXObject("Msxml2.XMLHTTP");
      } catch (e) {
         try {
            http_request = new ActiveXObject("Microsoft.XMLHTTP");
         } catch (e) {}
      }
   }
   if (!http_request) {
      alert('Cannot create XMLHTTP instance');
      return false;
   }
   
   http_request.onreadystatechange = xShow;
   http_request.open('POST', url, true);
   http_request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
   http_request.setRequestHeader("Content-length", parameters.length);
   http_request.setRequestHeader("Connection", "close");
   http_request.send(parameters);
}

function xShow() {
   if (http_request.readyState == 4) {
      if (http_request.status == 200) {
         //alert(http_request.responseText);
         result = http_request.responseText;
         document.getElementById(target).innerHTML = result;
      } else {
         alert('There was a problem with the request.');
      }
   }
}

function xed(tgt,sc_e,poststr,flt) {
   target=tgt;
   document.getElementById(tgt).style.top=(document.documentElement.scrollTop+32)+'px';
   document.getElementById(tgt).style.visibility="visible";
   if(flt){
      flt = prompt("Filter : ", "");
      poststr +='&flt='+flt;
   }
   poststr = 'edn='+sc_e+'&'+'target='+target+'&'+poststr;
   xRequest('/xed', poststr);
}

function xShut(id) {
   document.getElementById(id).style.visibility="hidden";
   document.getElementById(id).innerHTML="loading..";
}

function ow(url,w,h,t,name){
var q=window.screen.width;
eval('window.open("'+url+'","'+name+'","top='+t+',left='+(q-w-9)+',width='+w+',height='+h+',resizable=1,scrollbars=1")');
}
function vis(id) {
	if(document.getElementById(id).style.display=='none'){
		document.getElementById(id).style.display='';
	}
	else{document.getElementById(id).style.display='none';}
}


//-->