exports._new = function (src) {
    return function (opts) {
        return function () {
            return new SharedWorker(src, opts);
        };
    };
};

exports._port = function (wrk) {
    return wrk.port;
};
