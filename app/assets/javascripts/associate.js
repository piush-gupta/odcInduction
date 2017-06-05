$(document).ready(function(){
	var active_tab = 0;
	$('ul#update-nav li a').bind('click',function(){
		active_tab = $(this).attr('href').replace('#','');
		console.log(active_tab+"main");
	});
	if (active_tab != 0){
		$("ul#update-nav li#tab-"+ active_tab +" a").trigger('click');
		console.log(active_tab+"in if");
	}
	else{
		$('ul#update-nav li:first a').trigger('click');
		console.log(active_tab+"in else");
	}
});