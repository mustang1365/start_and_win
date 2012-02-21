function pngInit(){
try {
	document.execCommand("BackgroundImageCache", false, true); /* TredoSoft Multiple IE doesn't like this, so try{} it */
} catch(r) {}
DD_belatedPNG.createVmlNameSpace();
DD_belatedPNG.createVmlStyleSheet();
}
function png(){
  DD_belatedPNG.fix('.wrapper');
  DD_belatedPNG.fix('.autorization_man');
  DD_belatedPNG.fix('div.login');
  DD_belatedPNG.fix('div.logo img');
  DD_belatedPNG.fix('input');
  DD_belatedPNG.fix('.top_menu');
  DD_belatedPNG.fix('.main_menu');
  DD_belatedPNG.fix('.bottom_menu');
  DD_belatedPNG.fix('.nol');
  DD_belatedPNG.fix('.list');
  DD_belatedPNG.fix('.top_list');
  DD_belatedPNG.fix('.top_list img');
  DD_belatedPNG.fix('.news img');
 
}
png();