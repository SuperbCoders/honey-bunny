$(function(){
	$('.navbar-toggle').click(function(){$('body').toggleClass('navbar-wrap');return false;});
	if($('.case-sort').length){$(window).on('load resize',function() {var windowWidth = $(window).width(); if (windowWidth < 960) {$('.case-sort .current a').click(function(){$('.case-sort').toggleClass('case-sort_open');return false;});} }); };
	$('.case-faq .item .capt a').click(function(){$(this).parents('.item').toggleClass('item_open');return false;});
	$('.switcher label').click(function(){$(this).addClass('current').siblings().removeClass('current');});
	if($('.chosen-select').length){$('.chosen-select').chosen({});};
});