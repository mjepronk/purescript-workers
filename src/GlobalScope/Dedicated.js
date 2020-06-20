exports.name = function _name() {
    return function () {
        return self.name;
    };
};

exports._postMessage = function _postMessage(msg) {
    return function (transfer) {
        return function () {
            self.postMessage(msg, transfer.length > 0 ? transfer : undefined);
        };
    };
};

exports.onMessage = function _onMessage(f) {
    return function () {
        self.onmessage = function onMessage(e) {
            f(e.data)();
        };
    };
};

exports.onMessageError = function _onMessageError(f) {
    return function () {
        self.onmessageerror = function onMessageError(e) {
            f(e.target.error);
        };
    };
};
