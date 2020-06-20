exports._location = function (toLocation) {
    return function () {
        // NOTE A Plain JS Object is created because the WorkerLocation object
        // can't be serialized and may lead to weird behavior.
        return toLocation({
            origin: location.origin || '',
            protocol: location.protocol || '',
            host: location.host || '',
            hostname: location.hostname || '',
            port: location.port || '',
            pathname: location.pathname || '',
            search: location.search || '',
            hash: location.hash || '',
        });
    };
};

exports._navigator = function (toNavigator) {
    return function () {
        // NOTE A Plain JS Object is created because the WorkerNavigator object
        // can't be serialized and may lead to weird behavior.
        return toNavigator({
            appCodeName: navigator.appCodeName || '',
            appName: navigator.appName || '',
            appVersion: navigator.appVersion || '',
            platform: navigator.platform || '',
            product: navigator.product || '',
            productSub: navigator.productSub || '',
            userAgent: navigator.userAgent || '',
            vendor: navigator.vendor || '',
            vendorSub: navigator.vendorSub || '',
            language: navigator.language || '',
            languages: Array.prototype.slice.apply(navigator.languages || []),
            onLine: navigator.onLine || false,
        });
    };
};

exports.close = function () {
    self.close();
};

exports.onError = function (f) {
    return function () {
        self.onerror = function (msg) {
            f(new Error(msg))();
            // NOTE indicates that the error has been handled,
            // so it isn't propagated to the parent
            return true;
        };
    };
};

exports.onLanguageChange = function (f) {
    return function () {
        self.onlanguagechange = function () {
            f();
        };
    };
};

exports.onOffline = function (f) {
    return function () {
        self.onoffline = function () {
            f();
        };
    };
};

exports.onOnline = function (f) {
    return function () {
        self.ononline = function () {
            f();
        };
    };
};

exports.onRejectionHandled = function (f) {
    return function () {
        self.onrejectionhandled = function () {
            f();
        };
    };
};

exports.onUnhandledRejection = function (f) {
    return function () {
        self.onrejectionunhandled = function () {
            f();
        };
    };
};
