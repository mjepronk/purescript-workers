exports._onError = function (wrk) {
    return function (f) {
        return function () {
            wrk.onerror = function (err) {
                f(err)();
            };
        };
    };
};

exports._postMessage = function (channel) {
    return function (msg) {
        return function (transfer) {
            return function () {
                channel.postMessage(msg, transfer.length > 0 ? transfer : undefined);
            };
        };
    };
};
