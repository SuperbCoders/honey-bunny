$(function(){
	$('.navbar-toggle').click(function(){$('body').toggleClass('navbar-wrap');return false;});
	$('.case-faq .item .capt a').click(function(){$(this).parents('.item').toggleClass('item_open');return false;});
	$('.js-switcher label').click(function(){$(this).addClass('current').siblings().removeClass('current');});
	if($('.chosen-select').length){$('.chosen-select').chosen({});};
});