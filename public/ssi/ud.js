<!--

   var http_request = false;
   function udRequest(url, parameters) {
      http_request = false;
      if (window.XMLHttpRequest) { // Mozilla, Safari,...
         http_request = new XMLHttpRequest();
         if (http_request.overrideMimeType) {
         	// set type accordingly to anticipated content type
            //http_request.overrideMimeType('text/xml');
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
      
      http_request.onreadystatechange = udAlert;
      http_request.open('POST', url, true);
      http_request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      http_request.setRequestHeader("Content-length", parameters.length);
      http_request.setRequestHeader("Connection", "close");
      http_request.send(parameters);
   }

   function udAlert() {
      if (http_request.readyState == 4) {
         if (http_request.status == 200) {
            //alert(http_request.responseText);
            result = http_request.responseText;
            document.getElementById('ud').innerHTML = result;
         } else {
            alert('There was a problem with the request.');
         }
      }
   }

   function ud(uid) {
//  	if(document.getElementById('ud').style.visibility=="visible"){
//      		document.getElementById('ud').style.visibility="hidden";
//	}
//	else{
		document.getElementById('ud').style.top=(document.documentElement.scrollTop+32)+'px';
		document.getElementById('ud').style.visibility="visible";
		var poststr = "uid="+uid;
		udRequest('/cgi-bin/user_details.pl', poststr);
//	}
   }

   function udShut() {
	document.getElementById('ud').style.visibility="hidden";
	document.getElementById('ud').innerHTML="loading..";
   }

   function udPost() {
	   var poststr = document.forms['ud'].elements[0].name + "=" + encodeURI(document.forms['ud'].elements[0].value) +
			   "&" + document.forms['ud'].elements[1].name + "=" + encodeURI(document.forms['ud'].elements[1].value);
	   var i=2;
	   while (i<document.forms['ud'].elements.length){
		   poststr += "&" + document.forms['ud'].elements[i].name + "=" + encodeURIComponent(document.forms['ud'].elements[i].value);
		   i++
	   }
	   //udShut();
	   udRequest('/cgi-bin/user_details.pl', poststr);
   }

function vis(id){
	obj=layer(id);
	if (obj.style.display=="none"){obj.style.display=''}
	else {obj.style.display="none"}
}
function vis2(id,ch){
	obj=layer(id);
	if (document.forms['ud'].elements[ch].checked){obj.style.display=''}
	else {obj.style.display="none"}
}

//-->