'use strict';

$(function(){
	$('.navbar-toggle').click(function(){$('body').toggleClass('navbar-wrap');return false;});
	$('.case-faq .item .capt a').click(function(){$(this).parents('.item').toggleClass('item_open');return false;});
	$('.js-switcher label').click(function(){$(this).addClass('current').siblings().removeClass('current');});
	if($('.chosen-select').length){$('.chosen-select').chosen({});};
});


window.jQuery(function ($) {

    var menu = $('.page-header-top .navbar .items'),
        items = menu.find('.collapsable').not('.first'),
        firstItem = menu.find('.collapsable.first'),
        cart = $('.page-header-top .cart'),
        cartPinned = false,
        win = $(window),
        navbar = $('header .navbar .navbar-cnt');

    function unfoldLetters() {
        menu.removeClass('collapsed');
    }

    function foldLetters() {
        menu.addClass('collapsed');
    }

    $('.btn.btn-orn.js-thanks').click(foldLetters);
    menu.find('.item.dots').click(unfoldLetters);

    win.scroll(function () {
        if (win.scrollTop() > 75 && !cartPinned) {
            cart.addClass('bg-filled');
            cartPinned = true;
        } else if (win.scrollTop() < 76 && cartPinned) {
            cart.removeClass('bg-filled');
            cartPinned = false;
        }
    });
});


window.jQuery(function ($) {
	$('.ingredients-popup').webuiPopover({
		placement: 'top',
		trigger: 'hover',
		width: 380,
		content:function(){
			var ingredient_id = $(this).data('id');
			var source = $("#"+ingredient_id);
			var html = "<section class='ingr-popup'>" +
										"<div class='icon-wrap'><div class='icon "+source.find('.type').data('type')+"'></div></div>"+
										"<h1>"+source.find('.title').text()+"</h1>"+
										"<p>"+source.find('.desc').text()+"</p>"+
								 "</section>";
	    return html;
	  }
	});

	$('.bi-button .short').click(function () {
		$(this).siblings().removeClass('current');
		$(this).addClass('current');
		$('section.ingredients .short-descr').show();
		$('section.ingredients .full-descr').hide();
	});
	$('.bi-button .full').click(function () {
		$(this).siblings().removeClass('current');
		$(this).addClass('current');
		$('section.ingredients .short-descr').hide();
		$('section.ingredients .full-descr').show();
	});
});
