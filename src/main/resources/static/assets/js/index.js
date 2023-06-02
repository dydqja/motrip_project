(function() {
	"use strict";
	$(document).ready(function(){
		var head_font = 'Montserrat';
		var body_font = 'Source Sans Pro';
		var base_color = '#111111';
		$('.color-scheme-btn').click(function(){

			showloading();
			var primary = $(this).attr('data-hex');

			Cookies.set('primarycolor', primary, { expires: 1 });
			Cookies.set('basecolor', base_color, { expires: 1 });
			Cookies.set('headfont', head_font, { expires: 1 });
			Cookies.set('bodyfont', body_font, { expires: 1 });

			var headimport = head_font.split(' ').join('+');
			var bodyimport = body_font.split(' ').join('+');

			// $.ajax({
			// 	type: "POST",
			// 	url: "rendercss.php",
			// 	data: { 'primary_color': primary, 'base_color': base_color, 'head_font': head_font, 'body_font': body_font, 'head_import': headimport, 'body_import': bodyimport},
			// 	cache: false,
			// 	success: function(data)
			// 	{	
			// 		$('#moldcustomize').html(data).promise().done(function(){
			// 			hideloading();
			// 		});
			// 	}
			// });

			if (primary == '#4d5886') {
				$('#maincss').attr('href', 'assets/css/main4d5886.css');
			}
			else if (primary == '#7c8c3c') {
				$('#maincss').attr('href', 'assets/css/main7c8c3c.css');
			}
			else if (primary == '#8c6c26') {
				$('#maincss').attr('href', 'assets/css/main8c6c26.css');
			}
			else if(primary == '#e75c61'){
				$('#maincss').attr('href', 'assets/css/maine75c61.css');
			}

			setTimeout(function(){
			  hideloading();
			}, 2000);
			

		});

		$('#clearstyle').on('click', function(){
			$('#hexrefresh').trigger('click');
			$('#maincss').attr('href', 'assets/css/main.css');
		});

	});

	function showloading(){
		$('.pre-loader').show();
	}
	function hideloading(){
		$('.pre-loader').fadeOut('slow');
	}

	$('.select-icon-class').on('click', function(){
		this.select();
	});

	$("#testimonial1").owlCarousel({
		animateOut: 'fadeOut',
		autoplay: true,
		items:1,
		margin:30,
		loop:true,
		dots:false,
		nav:true,
		navText: ['<span class="icon-arrow-left"><span>','<span class="icon-arrow-right"><span>'],
		stagePadding:0,
	});
	$("#testimonial2").owlCarousel({
		animateOut: 'fadeOut',
		autoplay: true,
		items:2,
		margin:30,
		loop:true,
		dots:false,
		nav:true,
		navText: ['<span class="icon-arrow-left"><span>','<span class="icon-arrow-right"><span>'],
		stagePadding:0,
	});

	$('.counter').countUp({
		delay: 30,
		time: 3000
	});

	var heights = $('.feature-list > [class^="col-"]').map(function ()
	{
		return $(this).height();
	}).get(),
	maxHeight = Math.max.apply(null, heights);
	$('.feature-list > [class^="col-"]').height(maxHeight);
})();