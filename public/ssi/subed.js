<!--

var http_request = false;
var target='f2';

function se() {
   alert('afefwefwf');
}

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
         document.getElementById(target).innerHTML = result;
      } else {
         alert('There was a problem with the request.');
      }
   }
}

function sed(sq_id,qid,i,sc_e,rid) {
   target='se'+sq_id;
   var poststr = "sq_id="+sq_id+"&qid="+qid+"&i="+i+"&rid="+rid;
   //alert(poststr);
   udRequest('/'+sc_e, poststr);
}

function xed(tgt,sc_e,poststr,flt) {
   //alert(poststr);
   target=tgt;
   document.getElementById(target).style.top=(document.documentElement.scrollTop+32)+'px';
   document.getElementById(target).style.visibility="visible";
   if(flt){
      flt = prompt("Filter : ", "");
      poststr +='&flt='+flt;
   }
   udRequest('/cgi-bin/'+sc_e+'.pl', poststr);
}

function slook(sq_id,qid,i,sc_e,rid,t,pic1,pic2) {
   target='se'+sq_id;
   if(t.title=='Hide'){ t.src=pic1; t.title='Show'; document.getElementById(target).innerHTML =''; }
   else{ t.src=pic2; t.title='Hide'; sed(sq_id,qid,i,sc_e,rid); }
}

function sdel(sq_id,qid,i,sc_e,rid) {
   if(confirm('Удалить?')){
      target='se'+sq_id;
      var poststr = "sq_id="+sq_id+"&qid="+qid+"&i="+i+"&rid="+rid+"&del="+1+"&a="+1;
      udRequest('/cgi-bin/'+sc_e+'.pl', poststr);
   }
}

function ud(uid) {
   target='ud';
   document.getElementById('ud').style.top=(document.documentElement.scrollTop+32)+'px';
   document.getElementById('ud').style.visibility="visible";
   var poststr = "uid="+uid;
   udRequest('/cgi-bin/user_details.pl', poststr,'ud');
}

function udShut() {
   document.getElementById('ud').style.visibility="hidden";
   document.getElementById('ud').innerHTML="loading..";
}

function sePost(sq_id,sc_e) {
   target='se'+sq_id;
   var fm='es'+sq_id;
   var poststr = document.forms[fm].elements[0].name + "=" + encodeURI(document.forms[fm].elements[0].value) +
         "&" + document.forms[fm].elements[1].name + "=" + encodeURI(document.forms[fm].elements[1].value);
   var i=2;
   while (i<document.forms[fm].elements.length){
      poststr += "&" + document.forms[fm].elements[i].name + "=" + encodeURIComponent(document.forms[fm].elements[i].value);
      i++
   }
   udRequest(sc_e, poststr);
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