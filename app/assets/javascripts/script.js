$(function(){
	$('.navbar-toggle').click(function(){$('body').toggleClass('navbar-wrap');return false;});
	$('.case-faq .item .capt a').click(function(){$(this).parents('.item').toggleClass('item_open');return false;});
	$('.js-switcher label').click(function(){$(this).addClass('current').siblings().removeClass('current');});
	if($('.chosen-select').length){$('.chosen-select').chosen({});};
});


window.jQuery(function ($) {
    'use strict';
    var menu = $('.page-header-top .navbar .items'),
        items = menu.find('.collapsable').not('.first'),
        firstItem = menu.find('.collapsable.first'),
        cart = $('.page-header-top .cart'),
        cartPinned = false,
        win = $(window),
        navbar = $('header .navbar .navbar-cnt');

    // Разворачивание буковок меню
    function unfoldLetters() {
        menu.removeClass('collapsed');
    }

    // Сворачивание буковок меню
    function foldLetters() {
        menu.addClass('collapsed');
    }

    // Нажатие на кнопку "Купить" сворачивает меню
    $('.btn.btn-orn.js-thanks').click(foldLetters);
    // Клик по точкам в меню восстанавливает свернутое меню
    menu.find('.item.dots').click(unfoldLetters);

    // При скроллинге вниз добавим заливку корзине
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
