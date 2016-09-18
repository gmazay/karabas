<!--

//---------------------------------------------------//
var previ='';
var http_request = false;
var target='f2';
var newTr;
var IE=0;
var foc=1;
var lol=1;
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
		res = result.split('<!>',2);
	 	//if (IE) {target='f2';}
		if (!IE || target=='f2') {
			document.getElementById(target).innerHTML = res[0];
			if (target!='f2') {document.getElementById(target).style.backgroundColor='#ccffcc';}
			else{
			document.forms['ed'].elements[foc+7].focus();
			document.forms['ed'].elements[foc+7].select();
			}
		}
		else{eval(res[0]);}
		if(res[1]){eval(res[1]);}
		if(res[2]){eval(res[2]);}
		if (target=='f2') {lolc();}
		f_tcalInit();f_tcalCancel();
         } else {
            alert('There was a problem with the request.');
         }
      }
   }

   function get(sc_e,ai) {
	//encodeURI( document.getElementById("mytextarea1").value )
	   target=previ;
	   var poststr = document.forms['ed'].elements[0].name + "=" + encodeURI(document.forms['ed'].elements[0].value) +
			   "&" + document.forms['ed'].elements[1].name + "=" + encodeURI(document.forms['ed'].elements[1].value);
	   if(document.forms['ed'].quetype[0].checked){poststr += "&quetype=1";}
	   else{
		   poststr += "&quetype=2";
		   newTr = document.createElement('TR');
		   //document.getElementById('tb').insertBefore(newTr, document.getElementById('previ'));
		   document.getElementById('tb').appendChild(newTr);

		   newTr.style.backgroundColor='#ccffff';
		   newTr.style.cursor='crosshair';
		   imax++;
		   var im=imax;
		   newTr.id='s'+imax;
		   target = 's'+imax;
		   newTr.onclick=function(){edit(im,ai)};
	   }
	   var i=5;
	   while (i<document.forms['ed'].elements.length){
		   poststr += "&" + document.forms['ed'].elements[i].name + "=" + encodeURIComponent(document.forms['ed'].elements[i].value);
		   //poststr += "&" + document.forms['ed'].elements[i].name + "=" + document.forms['ed'].elements[i].value;
		   i++
	   }
      //alert(encodeURIComponent(document.forms['ed'].elements['name'].value));
	   if (IE) { poststr +="&iex="+previ;}
	   else { poststr +="&iex=2"; }
	   shut();
	   makePOSTRequest(sc_e, poststr);
   }

function put(sc_e,qid,i) {
	if (window.ActiveXObject) {IE=1;}
	document.getElementById('f2').style.visibility="visible";
	//document.getElementById('f2').innerHTML="loading..";
	var poststr = "qid=" + qid + "&i=" + i;
	target='f2';
	makePOSTRequest(sc_e, poststr);
   }

   function shut() {
	document.getElementById('f2').style.visibility="hidden";
	document.getElementById('f2').innerHTML="loading..";
	f_tcalCancel();
}

function drag(d,e)
{
  if(lol){return 0;}
  function agent(v) { return(Math.max(navigator.userAgent.toLowerCase().indexOf(v),0)); }
  function xy(e,v) { return(v?(agent('msie')?event.clientY+document.body.scrollTop:e.pageY):(agent('msie')?-event.clientX-document.body.scrollTop:-e.pageX)); }
  function drag0(e) { if(!stop) { d.style.top=(tX=xy(e,1)+oY-eY+'px'); d.style.right=(tY=xy(e)+oX-eX+'px'); } }
  var oX=parseInt(d.style.right),oY=parseInt(d.style.top),eX=xy(e),eY=xy(e,1),tX,tY,stop;
  document.onmousemove=drag0; document.onmouseup=function(){ stop=1; document.onmousemove=''; document.onmouseup=''; };
}

function lola(a)
{
  if(lol){
	lol=0;
	document.getElementById('f2').style.position='absolute';
	document.getElementById('f2').style.top=(window.pageYOffset+10)+'px';
	if(a){return 0;}
	document.getElementById('plo').src='/pic/loc.gif';
  }
  else{
	lol=1;
	document.getElementById('f2').style.position='fixed';
	document.getElementById('f2').style.top='10px';
	document.getElementById('f2').style.right='10px';
	if(a){return 0;}
	document.getElementById('plo').src='/pic/unl.gif';
  }
}

function lolc()
{
  if(lol){document.getElementById('plo').src='/pic/unl.gif';}
  else{document.getElementById('plo').src='/pic/loc.gif';}
}

function act_editor(a,mode,h) {
   if (document.forms['ed'].elements[a].style.display=='none'){
      document.forms['ed'].elements[a].style.display='';
      document.getElementById(a).style.display='none';
      return;
   }
   var edic = ace.edit(a);
   edic.setTheme("ace/theme/textmate");
   edic.getSession().setMode("ace/mode/"+mode);
   edic.getSession().setValue(document.forms['ed'].elements[a].value)
   document.getElementById(a).style.display='';

   if(h>0){ document.getElementById(a).style.height=h+'px'; }
   else{ document.getElementById(a).style.height=(window.innerHeight-200)+'px'; }

   document.forms['ed'].elements[a].style.display='none';
   edic.getSession().on('change', function(){
      document.forms['ed'].elements[a].value=edic.getSession().getValue();
   });
}
//---------------------------------------------------------------//
//-->