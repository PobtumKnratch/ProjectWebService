    /**
     * @license
     * Copyright 2021 Google LLC. All Rights Reserved.
     * Licensed under the Apache License, Version 2.0 (the "License");
     * you may not use this file except in compliance with the License.
     * You may obtain a copy of the License at
     *
     * http://www.apache.org/licenses/LICENSE-2.0
     *
     * Unless required by applicable law or agreed to in writing, software
     * distributed under the License is distributed on an "AS IS" BASIS,
     * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     * See the License for the specific language governing permissions and
     * limitations under the License.
     * =============================================================================
     */
    !(function (e, a) {
    "object" == typeof exports && "undefined" != typeof module
        ? a(
            exports,
            require("@tensorflow/tfjs-converter"),
            require("@tensorflow/tfjs-core")
        )
        : "function" == typeof define && define.amd
        ? define(
            ["exports", "@tensorflow/tfjs-converter", "@tensorflow/tfjs-core"],
            a
        )
        : a(((e = e || self).cocoSsd = e.cocoSsd || {}), e.tf, e.tf);
    })(this, function (e, a, i) {
    "use strict";
    function n(e, a, i, n) {
        return new (i || (i = Promise))(function (m, t) {
        function d(e) {
            try {
            o(n.next(e));
            } catch (e) {
            t(e);
            }
        }
        function s(e) {
            try {
            o(n.throw(e));
            } catch (e) {
            t(e);
            }
        }
        function o(e) {
            var a;
            e.done
            ? m(e.value)
            : ((a = e.value),
                a instanceof i
                ? a
                : new i(function (e) {
                    e(a);
                    })).then(d, s);
        }
        o((n = n.apply(e, a || [])).next());
        });
    }
    function m(e, a) {
        var i,
        n,
        m,
        t,
        d = {
            label: 0,
            sent: function () {
            if (1 & m[0]) throw m[1];
            return m[1];
            },
            trys: [],
            ops: [],
        };
        return (
        (t = { next: s(0), throw: s(1), return: s(2) }),
        "function" == typeof Symbol &&
            (t[Symbol.iterator] = function () {
            return this;
            }),
        t
        );
        function s(t) {
        return function (s) {
            return (function (t) {
            if (i) throw new TypeError("Generator is already executing.");
            for (; d; )
                try {
                if (
                    ((i = 1),
                    n &&
                    (m =
                        2 & t[0]
                        ? n.return
                        : t[0]
                        ? n.throw || ((m = n.return) && m.call(n), 0)
                        : n.next) &&
                    !(m = m.call(n, t[1])).done)
                )
                    return m;
                switch (((n = 0), m && (t = [2 & t[0], m.value]), t[0])) {
                    case 0:
                    case 1:
                    m = t;
                    break;
                    case 4:
                    return d.label++, { value: t[1], done: !1 };
                    case 5:
                    d.label++, (n = t[1]), (t = [0]);
                    continue;
                    case 7:
                    (t = d.ops.pop()), d.trys.pop();
                    continue;
                    default:
                    if (
                        !((m = d.trys),
                        (m = m.length > 0 && m[m.length - 1]) ||
                        (6 !== t[0] && 2 !== t[0]))
                    ) {
                        d = 0;
                        continue;
                    }
                    if (3 === t[0] && (!m || (t[1] > m[0] && t[1] < m[3]))) {
                        d.label = t[1];
                        break;
                    }
                    if (6 === t[0] && d.label < m[1]) {
                        (d.label = m[1]), (m = t);
                        break;
                    }
                    if (m && d.label < m[2]) {
                        (d.label = m[2]), d.ops.push(t);
                        break;
                    }
                    m[2] && d.ops.pop(), d.trys.pop();
                    continue;
                }
                t = a.call(e, d);
                } catch (e) {
                (t = [6, e]), (n = 0);
                } finally {
                i = m = 0;
                }
            if (5 & t[0]) throw t[1];
            return { value: t[0] ? t[1] : void 0, done: !0 };
            })([t, s]);
        };
        }
    }
    var t = {
        1: {
        id: 1,
        displayName: "signboard",
        },
        2: {
        id: 2,
        displayName: "electric pole",
        },
        3: {
        id: 3,
        displayName: "building",
        },
        4: {
        id: 4,
        displayName: "pipe",
        },
        5: {
        id: 5,
        displayName: "bridge railing",
        },
        6: {
        id: 6,
        displayName: "electric wire",
        },
        7: {
        id: 7,
        displayName: "roof",
        },
        8: {
        id: 8,
        displayName: "tree",
        },
        9: {
        id: 9,
        displayName: "grass",
        },
        10: {
        id: 10,
        displayName: "car",
        },
        11: {
        id: 11,
        displayName: "road",
        },
        12: {
        id: 12,
        displayName: "pork",
        },
        13: {
        id: 13,
        displayName: "mama",
        },
        14: {
        id: 14,
        displayName: "fork",
        },
        15: {
        id: 15,
        displayName: "spoon",
        },
        16: {
        id: 16,
        displayName: "noodle",
        },
        17: {
        id: 17,
        displayName: "Kale",
        },
        18: {
        id: 18,
        displayName: "pancake",
        },
        19: {
        id: 19,
        displayName: "mixed vegetables",
        },
        20: {
        id: 20,
        displayName: "Rice Crackers",
        },
        21: {
        id: 21,
        displayName: "papaya salad",
        },
        22: {
        id: 22,
        displayName: "three-flavored fish",
        },
        23: {
        id: 23,
        displayName: "glass",
        },
        25: {
        id: 25,
        displayName: "small basket",
        },
        26: {
        id: 26,
        displayName: "Stir Fried Mushrooms",
        },
        27: {
        id: 27,
        displayName: "food plate",
        },
        28: {
        id: 28,
        displayName: "seafood",
        },
        29: {
        id: 29,
        displayName: "mushroom",
        },
        30: {
        id: 30,
        displayName: "lettuce",
        },
        31: {
        id: 31,
        displayName: "tissue box",
        },
        32: {
        id: 32,
        displayName: "meatball",
        },
        33: {
        id: 33,
        displayName: "chopsticks",
        },
        34: {
        id: 34,
        displayName: "cashew nut",
        },
        35: {
        id: 35,
        displayName: "egg",
        },
        36: {
        id: 36,
        displayName: "Baked Shrimp with Glass Noodles",
        },
        37: {
        id: 37,
        displayName: "bean",
        },
        38: {
        id: 38,
        displayName: "jar",
        },
        39: {
        id: 39,
        displayName: "food",
        },
        40: {
        id: 40,
        displayName: "Human",
        },
        41: {
        id: 41,
        displayName: "garlic",
        },
        42: {
        id: 42,
        displayName: "rice",
        },
        43: {
        id: 43,
        displayName: "fried rice",
        },
        44: {
        id: 44,
        displayName: "fried fish",
        },
        45: {
        id: 45,
        displayName: "sink",
        },
        46: {
        id: 46,
        displayName: "Curry Rice",
        },
        47: {
        id: 47,
        displayName: "soup",
        },
        48: {
        id: 48,
        displayName: "side dishes",
        },
        49: {
        id: 49,
        displayName: "buddha",
        },
        50: {
        id: 50,
        displayName: "lamp",
        },
        51: {
        id: 51,
        displayName: "flower vase",
        },
        52: {
        id: 52,
        displayName: "fan",
        },
        53: {
        id: 53,
        displayName: "speaker",
        },
        54: {
        id: 54,
        displayName: "statue",
        },
        55: {
        id: 55,
        displayName: "picture",
        },
        56: {
        id: 56,
        displayName: "pagoda",
        },
        57: {
        id: 57,
        displayName: "vinyl",
        },
        58: {
        id: 58,
        displayName: "monk",
        },
        59: {
        id: 59,
        displayName: "buddha shelf",
        },
        60: {
        id: 60,
        displayName: "temple roof",
        },
        61: {
        id: 61,
        displayName: "wall",
        },
        62: {
        id: 62,
        displayName: "glass door",
        },
        63: {
        id: 63,
        displayName: "temple gate",
        },
        64: {
        id: 64,
        displayName: "window",
        },
        65: {
        id: 65,
        displayName: "motorcycle",
        },
        66: {
        id: 66,
        displayName: "temple",
        },
        67: {
        id: 67,
        displayName: "stairs",
        },
        68: {
        id: 68,
        displayName: "tuk tuk",
        },
        69: {
        id: 69,
        displayName: "sunshade",
        },
        70: {
        id: 70,
        displayName: "pole",
        },
        71: {
        id: 71,
        displayName: "light bulb",
        },
        72: {
        id: 72,
        displayName: "table",
        },
        73: {
        id: 73,
        displayName: "door",
        },
    };
    var d = (function () {
        function e(e, a) {
        this.modelPath =
            a ||
            "https://storage.googleapis.com/tfjs-models/savedmodel/" +
            this.getPrefix(e) +
            "/model.json";
        }
        return (
        (e.prototype.getPrefix = function (e) {
            return "lite_mobilenet_v2" === e ? "ssd" + e : "ssd_" + e;
        }),
        (e.prototype.load = function () {
            return n(this, void 0, void 0, function () {
            var e, n, t;
            return m(this, function (m) {
                switch (m.label) {
                case 0:
                    return (e = this), [4, a.loadGraphModel(this.modelPath)];
                case 1:
                    return (
                    (e.model = m.sent()),
                    (n = i.zeros([1, 300, 300, 3], "int32")),
                    [4, this.model.executeAsync(n)]
                    );
                case 2:
                    return (
                    (t = m.sent()),
                    [
                        4,
                        Promise.all(
                        t.map(function (e) {
                            return e.data();
                        })
                        ),
                    ]
                    );
                case 3:
                    return (
                    m.sent(),
                    t.map(function (e) {
                        return e.dispose();
                    }),
                    n.dispose(),
                    [2]
                    );
                }
            });
            });
        }),
        (e.prototype.infer = function (e, a, t) {
            return n(this, void 0, void 0, function () {
            var n, d, s, o, r, l, p, c, y, u, f, b;
            return m(this, function (m) {
                switch (m.label) {
                case 0:
                    return (
                    (n = i.tidy(function () {
                        return (
                        e instanceof i.Tensor || (e = i.browser.fromPixels(e)),
                        i.expandDims(e)
                        );
                    })),
                    (d = n.shape[1]),
                    (s = n.shape[2]),
                    [4, this.model.executeAsync(n)]
                    );
                case 1:
                    return (
                    (o = m.sent()),
                    (r = o[0].dataSync()),
                    (l = o[1].dataSync()),
                    n.dispose(),
                    i.dispose(o),
                    (p = this.calculateMaxScores(
                        r,
                        o[0].shape[1],
                        o[0].shape[2]
                    )),
                    (c = p[0]),
                    (y = p[1]),
                    (u = i.getBackend()),
                    "webgl" === i.getBackend() && i.setBackend("cpu"),
                    (f = i.tidy(function () {
                        var e = i.tensor2d(l, [o[1].shape[1], o[1].shape[3]]);
                        return i.image.nonMaxSuppression(e, c, a, t, t);
                    })),
                    (b = f.dataSync()),
                    f.dispose(),
                    u !== i.getBackend() && i.setBackend(u),
                    [2, this.buildDetectedObjects(s, d, l, c, b, y)]
                    );
                }
            });
            });
        }),
        (e.prototype.buildDetectedObjects = function (e, a, i, n, m, d) {
            for (var s = m.length, o = [], r = 0; r < s; r++) {
            for (var l = [], p = 0; p < 4; p++) l[p] = i[4 * m[r] + p];
            var c = l[0] * a,
                y = l[1] * e,
                u = l[2] * a,
                f = l[3] * e;
            (l[0] = y),
                (l[1] = c),
                (l[2] = f - y),
                (l[3] = u - c),
                o.push({
                bbox: l,
                class: t[d[m[r]] + 1].displayName,
                score: n[m[r]],
                });
            }
            return o;
        }),
        (e.prototype.calculateMaxScores = function (e, a, i) {
            for (var n = [], m = [], t = 0; t < a; t++) {
            for (var d = Number.MIN_VALUE, s = -1, o = 0; o < i; o++)
                e[t * i + o] > d && ((d = e[t * i + o]), (s = o));
            (n[t] = d), (m[t] = s);
            }
            return [n, m];
        }),
        (e.prototype.detect = function (e, a, i) {
            return (
            void 0 === a && (a = 20),
            void 0 === i && (i = 0.5),
            n(this, void 0, void 0, function () {
                return m(this, function (n) {
                return [2, this.infer(e, a, i)];
                });
            })
            );
        }),
        (e.prototype.dispose = function () {
            null != this.model && this.model.dispose();
        }),
        e
        );
    })();
    (e.ObjectDetection = d),
        (e.load = function (e) {
        return (
            void 0 === e && (e = {}),
            n(this, void 0, void 0, function () {
            var a, n, t;
            return m(this, function (m) {
                switch (m.label) {
                case 0:
                    if (null == i)
                    throw new Error(
                        "Cannot find TensorFlow.js. If you are using a <script> tag, please also include @tensorflow/tfjs on the page before using this model."
                    );
                    if (
                    ((a = e.base || "lite_mobilenet_v2"),
                    (n = e.modelUrl),
                    -1 ===
                        [
                        "mobilenet_v1",
                        "mobilenet_v2",
                        "lite_mobilenet_v2",
                        ].indexOf(a))
                    )
                    throw new Error(
                        "ObjectDetection constructed with invalid base model " +
                        a +
                        ". Valid names are 'mobilenet_v1', 'mobilenet_v2' and 'lite_mobilenet_v2'."
                    );
                    return [4, (t = new d(a, n)).load()];
                case 1:
                    return m.sent(), [2, t];
                }
            });
            })
        );
        }),
        (e.version = "2.2.2"),
        Object.defineProperty(e, "__esModule", { value: !0 });
    });
    //# sourceMappingURL=coco-ssd.min.js.map
