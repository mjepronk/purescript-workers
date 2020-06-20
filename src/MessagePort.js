exports._close = function (port) {
    return function () {
        port.close();
    };
};

exports._start = function (port) {
    return function () {
        port.start();
    };
};

exports._onMessage = function (port) {
    return function (f) {
        return function () {
            port.onmessage = function (e) {
                f(e.data)();
            };
        };
    };
};

exports._onMessageError = function (port) {
    return function (f) {
        return function () {
            port.onmessageerror = function (e) {
                f(e.target.error)(); // FIXME
            };
        };
    };
};
