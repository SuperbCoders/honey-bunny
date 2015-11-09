// Требует jQuery, GreenSock libs
// Верстка должна быть сохранена в первозданном виде

function Subscriber (id) {

	var subscriber = $(id),
		wasClicked = false,
		buble = subscriber.find('.subscriber-buble'),
		kolobokCnt = subscriber.find('.kolobok-cnt'),
		kolobokWink = kolobokCnt.find('.kolobok-wink'),
		btnClose = $('#subscriber-close'),
		timelineShowMe = new TimelineLite({paused: true}),
		timelineGoodbye = new TimelineLite({paused: true}),
		jumpTween = new TimelineMax({
			paused: true,
			repeat: 1
		}),
		jumpInterval;
		emailConfirmEl = $('#subscriber-email-confirm');

		this.getDiv = function() {
			return subscriber;
		};
	/*
	 * Анимашки
	 */

	// Первое появление (после загрузки страницы)
	timelineShowMe
		// колобок
		.fromTo(subscriber, 0.5, {y:85}, {y:0, ease:Back.easeOut})
		// зелёный бабл
		// .fromTo(buble, 0.5, {rotationY:90}, {
		// 	rotationY:0,
		// 	transformOrigin:'right',
		// 	onComplete: function() { timelineShowMe.kill() }
		// })
		.fromTo(buble, 0.5, {rotation: -90, opacity: 0}, {
			rotation: 0, opacity: 1,
			transformOrigin:'right bottom',
			ease: Back.easeOut,
			onComplete: function() { timelineShowMe.kill() }
		})

	// Подпрыгивание
	jumpTween
		.to(kolobokCnt, 0.2, {y:-30, ease:Power2.easeOut})
		.to(kolobokCnt, 0.4, {y:0, ease:Bounce.easeOut, onComplete: function() {
			if (wasClicked) {
				stopJumping();
				jumpTween.kill();
			}
		}});

	// Убираем морду после того как человек подписался
	this.timelineGoodbye =timelineGoodbye;
 	timelineGoodbye
		.to(subscriber, 0.5, {
			y:85, ease:Back.easeIn, onComplete: killme
		}, '+=2')

	/*
	 * Обработчики
	 */

	// Через 2.5 секунды после создания показываемся
	showmeTimer = setTimeout(function() {
		timelineShowMe.play(0)
	}, 2500);

	// Пусть колобок иногда подпрыгивает, пока на него не обратят внимание
	jumpInterval = setInterval(function () {
		if (!wasClicked) jumpTween.play(0)
	}, 5000);

	function stopJumping () {
		wasClicked = true;
		clearInterval(jumpInterval);
		subscriber.addClass('clicked');
		// Пригодится после закрытия окошка
		subscriber.removeClass('closed');
		// Если анимация в движении, пусть остановится уже после проигрывания
		// в onComplete()
		if (jumpTween.progress() === 1) jumpTween.kill();
	}

	// Перестаем прыгать после клика где-нибудь в контейнере
	subscriber.click(function(e) {
		if (e.target == buble[0] || e.target ==  kolobokWink[0]) stopJumping()
	});

	// Кнопка закрытия
	btnClose.click(function() {
		//subscriber.removeClass('clicked').addClass('closed')
		killme()
	});

	// Показываем финальный экранчик (подтверждение подписки)
	function showFinal () {
		subscriber.find('.error').hide();
		subscriber.removeClass('clicked').addClass('subscribed');
		var timer = setTimeout(function () {
			subscriber.removeClass('subscribed').addClass('closed');
			goodbye();
			clearInterval(timer);
		}, 5000);
	}

	// Убираем все безвозвратно
	function killme () {
		if (timelineShowMe) timelineShowMe.kill();
		if (timelineGoodbye) timelineGoodbye.kill();
		if (jumpTween) jumpTween.kill();
		if (showmeTimer) clearTimeout(showmeTimer);
		if (jumpInterval) clearInterval(jumpInterval);
		subscriber.remove();
	}

	// Завершение цикла
	function goodbye () {
		timelineGoodbye.play()
	}

	//subscriber.find('.subscribe-button').click(showFinal);

	// Отображение введенной почты в финальном экранчике
	subscriber.find('.subscriber-email').keyup(function(e) {
		emailConfirmEl.text(e.target.value);
	});

	Subscriber.prototype.success = function() {
	 showFinal();
	};

}

// Обьект занимается анимациями и переключением окошек
var subscriber = new Subscriber("#subscriber");

subscriber.getDiv().show();

// Когда в поле ввода почты в футере есть текст, то вешаем на неё класс has-text
// для того, чтобы работала подсветка кнопки справа
var footerEmailInput = $('.page-footer .mailer input.email');
var footerEmailSubmit = footerEmailInput.next();
footerEmailInput.keyup(function(event) {
	if (this.value.length) {
		footerEmailInput.addClass('has-text');
		footerEmailSubmit.removeAttr('disabled')
	} else {
		footerEmailInput.removeClass('has-text');
		footerEmailSubmit.attr('disabled', 'true');
	}
});
