
if (typeof usi_load === 'undefined') {
	usi_load = {
		Campaign: function (options) {
			this.id = options.id;
			this.cdn = usi_commons.cdn;
			this.company_id = options.company_id;
			this.site_id = options.site_id;
			this.email_id = options.email_id;
			this.config_id = options.config_id;
			this.cookie_append = options.cookie_append;
			this.launch_cookie = options.launch_cookie;
			this.click_cookie = options.click_cookie;
			this.sale_window = options.sale_window;
			this.affiliate_link = options.affiliate_link;
			this.affiliate_deep_link = options.affiliate_deep_link;
			this.error_reported = 0;
			this.css = options.css;
			this.do_not_encode_deeplink = options.do_not_encode_deeplink;
			this.original_site_id = options.original_site_id;
			this.link = function (url, new_window) {
				try {
					if (!url) url = this.affiliate_link;
					if (!url) return;
					usi_cookies.set("usi_clicked_1", "1", 60);
					usi_cookies.set('usi_click_id', this.id, this.sale_window, true);
					if (this.click_cookie && this.click_cookie > 0) this.set_launch_cookie(this.click_cookie);
					var destination = usi_commons.domain + '/link.jsp?id=' + this.id + '&cid=' + this.company_id + '&sid=' + this.site_id + '&duration=' + this.sale_window + '&url=' + encodeURIComponent(url);
					if (new_window) window.open(destination);
					else location.href = destination;
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.deep_link = function (url, new_window) {
				try {
					if (!url) url = location.href;
					if (this.do_not_encode_deeplink != 1) {
						url = encodeURIComponent(url);
					}
					this.link(this.affiliate_deep_link + url, new_window);
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.link_clicked = function() {
				try{
					usi_cookies.set('usi_click_id', this.id, this.sale_window, true);
					usi_cookies.set("usi_clicked_1", "1", 60);
					if (this.click_cookie && this.click_cookie > 0) this.set_launch_cookie(this.click_cookie);
					usi_commons.load_script(usi_commons.domain + '/link.jsp?id=' + this.id + '&cid=' + this.company_id + '&sid=' + this.site_id + '&duration=' + this.sale_window + "&ajax=2");
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.link_injection = function(url, callback) {
				try {
					this.link_clicked();
					var iframe = document.createElement("iframe");
					iframe.style.width = "1px";
					iframe.style.height = "1px";
					if (url) {
						iframe.src = url;
					} else if (this.affiliate_link != "") {
						iframe.src = this.affiliate_link;
					} else if (this.affiliate_deep_link != "") {
						iframe.src = this.affiliate_deep_link + encodeURIComponent(location.href);
					}
					if (typeof callback == "function") iframe.onload = callback;
					document.getElementsByTagName('body')[0].appendChild(iframe);
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.place_css = function(css) {
				try {
					var usi_css = document.createElement("style");
					usi_css.type = "text/css";
					if(usi_css.styleSheet) usi_css.styleSheet.cssText = css;
					else usi_css.innerHTML = css;
					usi_css.className = "usi_load_style";
					document.getElementsByTagName('head')[0].appendChild(usi_css);
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.load = function () {
				try {
					if (usi_cookies.get("usi_loaded"+this.cookie_append) == null) {
						if (typeof(this.loaded) === "undefined" || this.loaded == false) {
							this.loaded = true;
							this.place_css(this.css);
							if (!options.extra_javascript.apply(this)) {
								return false;
							}
							if (this.launch_cookie && this.launch_cookie > 0) this.set_launch_cookie(this.launch_cookie);
							usi_commons.load_script(usi_commons.domain + '/load.jsp?id=' + this.id + '&url=' + encodeURIComponent(location.href));
						}
					}
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.current_time = function() {
				try {
					var d = new Date();
					return d.getTime();
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.set_launch_cookie = function(time){
				try {
					usi_cookies.set("usi_loaded"+this.cookie_append, "t"+this.current_time(), time, true);
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.get_session = function () {
				try {
					var sess = "";
					if (usi_cookies.get("usi_sess") != null) {
						sess = usi_cookies.get("usi_sess");
					} else {
						sess = "usi_sess_" + this.site_id + "_" + Math.round(1000 * Math.random()) + "_" + (new Date()).getTime();
						usi_cookies.set("usi_sess", sess, 30 * 24 * 60 * 60, true);
					}
					return sess;
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.send_data = function (name, value) {
				try {
					usi_commons.load_script(usi_commons.domain + "/hound/saveData.jsp?siteID=" + this.email_id +
						"&onsite_configID=" + this.config_id +
						"&USI_value=" + encodeURIComponent(value) + "&USI_name=" + encodeURIComponent(name) +
						"&USI_Session=" + this.get_session() + "&id=" + this.id + "&bustCache=" + (new Date()).getTime());
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.error_report = function(err) {
				try {
					if (err == null) return;
					if (typeof err === 'string') err = new Error(err);
					if (!(err instanceof Error)) return;
					if (typeof(usi_commons.error_reported) !== "undefined") {
						return;
					}
					if(this.error_reported == 0) {
						this.error_reported = 1;
						if (location.href.indexOf('usishowerrors') !== -1) throw err;
						else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
					}
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
			this.validate_email = function (email) {
				try {
					var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
					return re.test(email);
				} catch(err) {
					if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
				}
			};
		}
	};
}
usi_35075 = new usi_load.Campaign({
	id: '10534041090283578574650',
	company_id: '8397',
	site_id: '35075',
	email_id: '0',
	config_id: '67479',
	sale_window: '1209600',
	cookie_append: '35075',
	launch_cookie: 0,
	click_cookie: 0,
	affiliate_link: '',
	affiliate_deep_link: 'https://click.linksynergy.com/deeplink?id=JNLJ1ZP2xGI&mid=43027&murl=',
	do_not_encode_deeplink: '0',
	css: ".ajaxcart__product { margin-bottom:0rem !important; }.usi_35075_head {\tpadding: .2em; \tfont-weight: bold;  text-align: center;  font-size: 1.2em;  text-transform: uppercase;  color: white;  background-color: #204878;  margin-bottom: 6%;}.usi_35075_products {  padding: 0 5%;  /*height: 35em;*/  /*overflow: scroll;*/}.usi_35075_product {  margin: 2% 0;  padding: 0px 0px 5px 0px;  border-bottom: 1px solid #204878;}.usi_35075_prod_image_link {\tpadding: 1em;\ttext-align: center;\tdisplay: inline-block;\twidth: 40%;\tvertical-align: top;}.usi_35075_prod_image {\tmax-width: 100%;  max-height: 100%;}.usi_35075_product_info {\tdisplay: inline-block;\twidth: 60%;\tvertical-align: top;  text-align: left;}.usi_35075_name {  overflow: hidden;  color: #000000;  text-decoration: none;}.usi_35075_original_price {\twidth: 100%;  text-decoration: line-through;}.usi_35075_price {  padding: 0.5em 0;  font-weight: bold;  color: #204878;  width: 100%;}.usi_35075_msrp {\ttext-decoration: line-through;\tcolor: #817e7e;}.usi_35075_link {\tpadding: 0.5em;\ttext-align: center;\tmargin: auto;\tdisplay: block;\ttext-decoration: none;\twidth: 100%;}.usi_35075_link:hover {\ttext-decoration: none;}/* Submit Button */.usi_35075_submitbutton:hover {\tbackground-color:#253D85;  color:#FFFFFF;\toutline: none;  height: 2em;\tbox-shadow: none;}.usi_35075_submitbutton {  position:relative;  background-color:#F45B28;  color:#FFFFFF;\twidth: 80%;  left: 10%;\theight: 2em;\tmargin: 0;\tpadding: 0;\tdisplay: inline-block;\toutline: none;\tborder: none;\tcursor: pointer;\ttext-align: center;\tbox-shadow: none;}/*@media only screen and (max-height: 600px) {  #header-cart {    height: 40em !important;  }  .usi_35075_products {  \theight: 10em !important;  }}@media only screen and (max-width: 480px) {  #header-cart {    height: 54em !important;  }  .usi_35075_products {  \theight: 20em !important;  }  .header-minicart .mini-products-list {    height: 163px !important;  }}*/",
	launch_methods: '3,',
	original_site_id: '35075',
	extra_javascript: function(){
		/** Extra Javascript: START */
		try {
			usi_35075.click_cta = function(i){
  usi_35075.deep_link(usi_app.product_rec["product" + i].url);
};

usi_35075.product_html = '<div class="usi_35075_inpage"><div class="usi_35075_head">Recommended for you:</div><div class="usi_35075_products">';
for (var i = 1; i <= 3; i++) {
	if (usi_app.product_rec["product" + i] == undefined) {
		break;
	}
  var extra = JSON.parse(usi_app.product_rec["product" + i].extra.replaceAll("&quot;", '"'));
	var name = usi_app.product_rec["product" + i].productname;
	var price = usi_app.product_rec["product" + i].price;
	var image = usi_app.product_rec["product" + i].image;
  var original_price = extra.original_price;
  if (original_price != "") {
  	original_price = '<span class="usi_35075_original_price">' + original_price + '</span>&nbsp;&nbsp;&nbsp;';
  }
  if (name.length > 150) {
  	name = name.substring(0, 149);
    name = name.substring(0, name.lastIndexOf(" ")) + "...";
  }
  usi_35075.product_html += [
  	'<div class="usi_35075_product usi_35075_product',i,'">',
			'<a href="javascript:usi_',usi_35075.site_id,'.click_cta(',i,');" class="usi_35075_prod_image_link">',
				'<img src="', image, '" border="0" alt="product image" class="usi_35075_prod_image"/>',
			'</a>',
			'<div class="usi_35075_product_info">',
				'<a href="javascript:usi_',usi_35075.site_id,'.click_cta(',i,');" class="usi_35075_name">', name, '</a><br/>',
				original_price, '<span class="usi_35075_price">', price, '</span>',
			'</div>',
    	//'<a href="javascript:usi_',this.site_id,'.click_cta(',i,');" class="usi_35075_link"><img src="https://www.upsellit.com/chatskins/8397/AmScope-TT-3-2021-Minicart-dsktp-CTA.png" alt="add to cart" style="max-width: 100%; max-height: 100%;" /></a>',
    	'<button class="usi_35075_submitbutton" onclick="usi_',usi_35075.site_id,'.click_cta(',i,');" type="button">View Product</button>',
		'</div>'
	].join('');
}
usi_35075.product_html += '</div></div>';

usi_35075.p1_html = [
	usi_35075.product_html
].join('');


var target_element = document.querySelector(".ajaxcart__inner");
if (target_element == null && document.getElementById("usi_load_div") != null) {
	target_element = document.getElementById("usi_load_div");
  var usi_container = document.createElement("div");
  usi_container.setAttribute("id", "usi_container");
  usi_container.innerHTML = (usi_35075.p1_html);
  target_element.appendChild(usi_container);
} else {
  usi_35075.wait_for_mini_cart = function() {
    var target_element = document.querySelector(".ajaxcart__inner");
    if (target_element != null) {
      if (document.getElementsByClassName("ajaxcart__product").length == 1) {
        var usi_container = document.createElement("div");
        usi_container.setAttribute("id", "usi_container");
        usi_container.innerHTML = (usi_35075.p1_html);
        target_element.appendChild(usi_container);
      }
    } else {
    	setTimeout(usi_35075.wait_for_mini_cart, 1000);
    }
  };
  usi_35075.wait_for_mini_cart();
}
		} catch(err) {
			if (typeof usi_commons !== "undefined") usi_commons.report_error(err);
			return false;
		}
		return true;
		/** Extra Javascript: END */
	}
});

setTimeout(function(){
	usi_35075.load()
}.bind(this), 0);
