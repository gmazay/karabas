<!--

var z=1;
var ba1=0,ba1r=8,ba1t,ba2=0,ba2r=8,ba2t,ba3=0,ba3r=8,ba3t;

function cancelCloseMenu(submenulayer){
{
	if(eval('self.'+submenulayer+'tt') && eval(submenulayer+'r==10')){
	eval('clearTimeout('+submenulayer+'tt)');
	}
	if(eval('self.'+submenulayer+'t') && eval(submenulayer+'r<10')){
		eval('clearTimeout('+submenulayer+'t)');
		eval('clearTimeout('+submenulayer+'tt)');
		eval (submenulayer+'r=10');
		submenu=layer(submenulayer);
		submenu.style.MozOpacity=1;
		submenu.style.filter="alpha(opacity=100)";
		submenu.setZIndex(z); z++;
	}
}
}

function showMenu(menulayer,submenulayer){
		menu=layer(menulayer);
		submenu=layer(submenulayer);

	cancelCloseMenu(submenulayer);
	
	submenu.setZIndex(z); z++;
	submenu.moveTo(menu.getAbsoluteLeft(), menu.getAbsoluteTop() + menu.getHeight());
		submenu.style.MozOpacity=1;
		submenu.style.filter="alpha(opacity=100)";
	submenu.show();
	
//	Unhide(submenulayer);  //Uncomment this and comment strings with "Opacity"
}

function showMenu2(menulayer,submenulayer){
		menu=layer(menulayer);
		submenu=layer(submenulayer);

	cancelCloseMenu(submenulayer);
	
	submenu.setZIndex(z); z++;
	submenu.moveTo(menu.getAbsoluteLeft() + menu.getWidth() +1, menu.getAbsoluteTop());
		submenu.style.MozOpacity=1;
		submenu.style.filter="alpha(opacity=100)";
	submenu.show();
	
//	Unhide(submenulayer);
}

function Unhide(submenulayer){
	var opa;
		submenu=layer(submenulayer)
		eval('opa='+submenulayer);
	if (opa<16){
		opa++;
		submenu.style.MozOpacity=opa*0.05;
		submenu.style.filter="alpha(opacity="+(opa*5)+")";
		eval(submenulayer+'=opa');
	}
	else{
	eval(submenulayer+'=0');
	return; 
	}
	eval ('setTimeout(\"Unhide(\''+submenulayer+'\')\",150)');
}

function hideMenu(submenulayer){
	var apo;
		submenu=layer(submenulayer);
	eval ('apo='+submenulayer+'r');
	if (apo>1){
		apo--;
		submenu.style.MozOpacity=apo*0.1;
		submenu.style.filter="alpha(opacity="+(apo*10)+")";
			eval (submenulayer+'r=apo');
	}
	else{
	submenu.hide(); eval (submenulayer+'r=10'); return; 
	}
	eval (submenulayer+'t=setTimeout(\"hideMenu(\''+submenulayer+'\')\",100)');
}

function initiateHideMenu(submenulayer){
	eval(submenulayer+'tt=setTimeout(\"hideMenu(\''+submenulayer+'\')\",500)');
}

function show_panel(ba){
	panel=layer(ba);
	panel.setZIndex(0);
	panel.moveTo(40, 135);
	panel.show();
	Unhide(ba);
	eval ('setTimeout(\"hideMenu(\''+ba+'\')\",3000)');
}
function show_ban(){
	show_panel('ba1');
	setTimeout("show_panel('ba2')",4000)
	setTimeout("show_panel('ba3')",8000)
}
function submit_l(){
if(document.event.keyCode==13){document.forms['logi'].submit()}
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