exports.name = function () {
    return self.name;
};

exports.applicationCache = function () {
    return self.applicationCache;
};

exports._onConnect = function (nonEmpty) {
    return function (f) {
        return function () {
            self.onconnect = function (e) {
                const head = e.ports[0];
                const queue = Array.prototype.slice.call(e.ports, 1);
                f(nonEmpty(head)(queue))();
            };
        };
    };
};
