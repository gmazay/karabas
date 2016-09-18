<!--

//---------------------------------------------------//
   var http_request = false;
   var qs = 0;
   function makePOSTRequest(url, parameters) {
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
      
      http_request.onreadystatechange = alertContents;
      http_request.open('POST', url, true);
      http_request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      http_request.setRequestHeader("Content-length", parameters.length);
      http_request.setRequestHeader("Connection", "close");
      http_request.send(parameters);
   }

   function alertContents() {
      if (http_request.readyState == 4) {
         if (http_request.status == 200) {
            //alert(http_request.responseText);
            result = http_request.responseText;
            document.getElementById('myspan').innerHTML = result;
            qs=0;
         } else {
            alert('There was a problem with the request.');
         }
      }
   }
   
   function get(obj) {
      //encodeURI( document.getElementById("mytextarea1").value )
      var poststr = "d1=" + document.getElementById('d1').innerHTML +
                    "&d2=" + document.getElementById('d2').innerHTML +
                    "&d3=" + document.getElementById('d3').innerHTML +
                    "&d4=" + document.getElementById('d4').innerHTML;
      makePOSTRequest('/perl/xj.pl', poststr);
   }
   function put(d,digit) {
	if(!qs){
      		document.getElementById(d).innerHTML=digit;
      		get(document.getElementById('myform'));
   	}
	qs=1;
   }
//---------------------------------------------------------------//
//-->