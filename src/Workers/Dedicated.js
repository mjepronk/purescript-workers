exports._new = function (src) {
    return function (opts) {
        return function () {
            return new Worker(src, opts);
        };
    };
};

exports._terminate = function (wrk) {
    return function () {
        wrk.terminate();
    };
};

exports._onMessage = function (wrk) {
    return function (f) {
        return function () {
            wrk.onmessage = function (e) {
                f(e.data)();
            };
        };
    };
};

exports._onMessageError = function (wrk) {
    return function (f) {
        return function () {
            wrk.onmessageerror = function (e) {
                f(e.target.error)(); // FIXME
            };
        };
    };
};
