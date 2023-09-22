
try {
if (typeof usi_app === 'undefined') {
	usi_app = {};
}
usi_app.product_rec = {};
usi_app.product_rec.pid_viewers = 188;
usi_app.product_rec.product0 = {pid:"c-sm-4b", productname:"Binocular Stereo Zoom Microscope w/Optional Digital Camera on Double Arm Boom Stand", image:"http://amscope.com/cdn/shop/files/1-SM-4B-main-hero_2f20c482-2147-4ecf-8c1c-5d53152e63cb_1024x1024.jpg?v=1692549514", price:"$464.99", url:"https://amscope.com/collections/stereo-microscopes/products/c-sm-4b", extra:"{&quot;original_price&quot;:&quot;$557.99&quot;,&quot;stock&quot;:&quot;INSTOCK&quot;}"};
usi_app.product_rec.product1 = {pid:"c-sm-4tp-30wy-af", productname:"Trincocular Simul-Focal Stereo Zoom Microscope w/30W LED Dual Gooseneck Fiber Optic Lights and Auto Focus Camera on Double Arm Boom Stand", image:"http://amscope.com/cdn/shop/products/1-SM-4T-30WY-AF-main-hero_36439b15-e015-4c56-972e-e27dee29ebd2_1024x1024.jpg?v=1661617965", price:"$1,093.99", url:"https://amscope.com/products/c-sm-4tp-30wy-af", extra:"{&quot;original_price&quot;:&quot;$2,484.99&quot;,&quot;stock&quot;:&quot;INSTOCK&quot;}"};
usi_app.product_rec.product2 = {pid:"c-t670q-pl-fl", productname:"Trinocular Fluorescence Microscope", image:"http://amscope.com/cdn/shop/products/compound-microscope-t670q-pl-fl-01_1_a095a134-60ca-43aa-a193-c46ce8038e31_1024x1024.jpg?v=1650344095", price:"$2,789.99", url:"https://amscope.com/products/c-t670q-pl-fl", extra:"{&quot;original_price&quot;:&quot;$3,347.99&quot;,&quot;stock&quot;:&quot;INSTOCK&quot;}"};
usi_app.product_rec.product3 = {pid:"c-sm-4ntp-56s", productname:"Trinocular Simul-Focal Lockable Stereo  Zoom Microscope w/56 LED Compact Ring Light and Optional Digital Camera on Double Arm Boom Stand", image:"http://amscope.com/cdn/shop/products/1-SM-4NTP-144S-main-hero_b804f18e-9cce-4906-ad92-6a6a9d75d043_1024x1024.jpg?v=1650338060", price:"$604.99", url:"https://amscope.com/products/c-sm-4ntp-56s", extra:"{&quot;original_price&quot;:&quot;$1,094.99&quot;,&quot;stock&quot;:&quot;INSTOCK&quot;}"};

	if (typeof usi_app.product_rec_callback === 'function' && typeof usi_app.product_rec.pid_viewers !== 'undefined') {
		usi_app.product_rec_callback(usi_app.product_rec);
	}
} catch (err) {
	if (typeof usi_commons != "undefined") {
		usi_commons.report_error(err);
	}
}
