!function() {
    "use strict";
    $(document).ready(function() {
        var t = $(".counter");
        t.countUp({
            delay: 30,
            time: 3000
        });
    });

    $.fn.countUp = function(t) {
        var n = $.extend({
            time: 400,
            delay: 10
        }, t);
        return this.each(function() {
            var t = $(this),
                u = n,
                e = function() {
                    var n = [],
                        e = u.time / u.delay,
                        a = parseInt(t.text().replace(/,/g, "")),
                        o = /^[0-9]+$/.test(a),
                        c = /^[0-9]+\.[0-9]+$/.test(a),
                        i = c ? (a.toString().split(".")[1] || "").length : 0;
                    for (var d = e; d >= 1; d--) {
                        var s = Math.round(a / e * d);
                        if (c) {
                            s = parseFloat(a / e * d).toFixed(i);
                        }
                        if (o) {
                            while (/(\d+)(\d{3})/.test(s.toString())) {
                                s = s.toString().replace(/(\d+)(\d{3})/, "$1,$2");
                            }
                        }
                        n.unshift(s);
                    }
                    t.data("countup-nums", n);
                    t.text("0");
                    var r = function() {
                        var nums = t.data("countup-nums");
                        if (nums && nums.length) {
                            t.text(nums.shift());
                            setTimeout(t.data("countup-func"), u.delay);
                        } else {
                            t.data("countup-nums", null);
                            t.data("countup-func", null);
                        }
                    };
                    t.data("countup-func", r);
                    setTimeout(t.data("countup-func"), u.delay);
                    this.destroy();
                };
            t.waypoint(e, {
                offset: "100%"
            });
        });
    }
}();
