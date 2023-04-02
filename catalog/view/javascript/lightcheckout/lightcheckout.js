function LightcheckoutThemes(theme, total){
	if (theme == 'lightcart'){
		$('.top_line #cart-total').html(total);
		$('#top #cart-total').html(total);
	}
	if (theme == 'multimarket'){
		
		$('.top_line #cart > ul').load('index.php?route=common/cart/info ul li');
		$('.container #cart > ul').load('index.php?route=common/cart/info ul li');
		
		setTimeout(function () {
			$('#cart > button').html('<i class="fa fa-shopping-cart" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;' + total + '<span class="shopping-cart"><img src="catalog/view/theme/multimarket/image/cart-img.png" /></span>');
		}, 100);
	}
	if (theme == 'onlytemplate'){
		updateCart();
		$('.top_line #cart-total').html(total);
		$('.container #cart-total').html(total);
		$('.top_line #cart > .dropdown-menu ul').load('index.php?route=common/cart/info ul li');
		$('.container #cart > .dropdown-menu ul').load('index.php?route=common/cart/info ul li');
	}
	if (theme == 'oct_ultrastore') {
		$('#cart .us-cart-text').html(total);
		$('#cart .us-cart-text').find('img').remove();
		$('#cart .us-cart-text').find('.header-cart-index').remove();
		var text_total = $('#cart .us-cart-text .smart-hide').text().replace('(','').replace(')','');
		$('#cart .us-cart-text .smart-hide').text(text_total);
		$('#cart .us-cart-text .smart-hide').removeClass('smart-hide');
	}
}
function ButtonConfirmOrder(){
	setTimeout(function(){
		$('#button-confirm').trigger('click');
	}, 0);
}
function LightcheckoutThemesJs(theme){
	if (theme == 'oct_feelmart') {
		$('.breadcrumb').addClass('fm-breadcrumb');
		$('.breadcrumb > li').addClass('breadcrumb-item fm-breadcrumb-item');
	}
	if (theme == 'oct_ultrastore') {
		$('.breadcrumb').addClass('us-breadcrumb');
		$('.breadcrumb > li').addClass('breadcrumb-item us-breadcrumb-item');
		$('#checkout-checkout').wrapInner('<div class="us-content"></div>');
		$('#checkout-checkout').addClass('oct_ultrastore');
		$('#accordion .panel-title').addClass('us-content-title');
		setTimeout(function(){
			$('.btn-primary').removeClass('btn-primary').addClass('us-module-cart-btn');	
		}, 3000);		
	}
	if (theme == 'materialize') {
		$('.breadcrumb').wrap('<nav id="breadcrumbs" class="breadcrumb-wrapper transparent z-depth-0"></nav>');
		$('.breadcrumb').addClass('nav-wrapper breadcrumb-wrap href-underline');
		$('.breadcrumb > li > a').addClass('breadcrumb waves-effect black-text').unwrap();
	}
}
// Autocomplete */
(function($) {
	$.fn.autocomplete = function(option) {
		return this.each(function() {
			this.timer = null;
			this.items = new Array();

			$.extend(this, option);

			$(this).attr('autocomplete', 'off');

			// Focus
			$(this).on('focus', function() {
				this.request();
			});

			// Blur
			$(this).on('blur', function() {
				setTimeout(function(object) {
					object.hide();
				}, 200, this);
			});

			// Keydown
			$(this).on('keydown', function(event) {
				switch(event.keyCode) {
					case 27: // escape
						this.hide();
						break;
					default:
						this.request();
						break;
				}
			});

			// Click
			this.click = function(event) {
				event.preventDefault();

				value = $(event.target).parent().attr('data-value');

				if (value && this.items[value]) {
					this.select(this.items[value]);
				}
			}

			// Show
			this.show = function() {
				var pos = $(this).position();

				$(this).siblings('ul.dropdown-menu').css({
					top: pos.top + $(this).outerHeight(),
					left: pos.left
				});

				$(this).siblings('ul.dropdown-menu').show();
			}

			// Hide
			this.hide = function() {
				$(this).siblings('ul.dropdown-menu').hide();
			}

			// Request
			this.request = function() {
				clearTimeout(this.timer);

				this.timer = setTimeout(function(object) {
					object.source($(object).val(), $.proxy(object.response, object));
				}, 200, this);
			}

			// Response
			this.response = function(json) {
				html = '';

				if (json.length) {
					for (i = 0; i < json.length; i++) {
						this.items[json[i]['value']] = json[i];
					}

					for (i = 0; i < json.length; i++) {
						if (!json[i]['category']) {
							html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
						}
					}

					// Get all the ones with a categories
					var category = new Array();

					for (i = 0; i < json.length; i++) {
						if (json[i]['category']) {
							if (!category[json[i]['category']]) {
								category[json[i]['category']] = new Array();
								category[json[i]['category']]['name'] = json[i]['category'];
								category[json[i]['category']]['item'] = new Array();
							}

							category[json[i]['category']]['item'].push(json[i]);
						}
					}

					for (i in category) {
						html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

						for (j = 0; j < category[i]['item'].length; j++) {
							html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
						}
					}
				}

				if (html) {
					this.show();
				} else {
					this.hide();
				}

				$(this).siblings('ul.dropdown-menu').html(html);
			}

			$(this).after('<ul class="dropdown-menu"></ul>');
			$(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

		});
	}
})(window.jQuery);