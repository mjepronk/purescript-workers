/* SERVICE WORKER CONTAINER */

exports._controller = function () {
    return navigator.serviceWorker.controller;
};

exports._getRegistration = function (url) {
    return function (error, success) {
        try {
            navigator.serviceWorker
                     .getRegistration(url || '')
                     .then(success, error);
        } catch (err) {
            error(err);
        }
    };
};

exports._onControllerChange = function (f) {
    return function () {
        navigator.serviceWorker.oncontrollerchange = function oncontrollerchange() {
            f();
        };
    };
};

exports._onMessage = function (f) {
    return function () {
        navigator.serviceWorker.onmessage = function onmessage(e) {
            f(e.data)();
        };
    };
};


exports._ready = function (error, success) {
    try {
        navigator.serviceWorker
                 .ready
                 .then(success, error);
    } catch (err) {
        error(err);
    }
};

exports._register = function (url) {
    return function (opts) {
        return function (error, success) {
            try {
                navigator.serviceWorker
                         .register(url, opts)
                         .then(success, error);
            } catch (err) {
                error(err);
            }
        };
    };
};

exports._startMessages = function () {
    navigator.serviceWorker
             .startMessages();
};

/* SERVICE WORKER */

exports._onStateChange = function (toState) {
    return function (service) {
        return function (f) {
            return function () {
                service.onstatechange = function (e) {
                    f(toState(e.source.state))();
                };
            };
        };
    };
};

exports._scriptURL = function (service) {
    return service.scriptURL;
};

exports._state = function (toState) {
    return function (service) {
        return toState(service.state);
    };
};

/* SERVICE WORKER REGISTRATION */

exports._active = function (registration) {
    return registration.active;
};

exports._installing = function (registration) {
    return registration.installing;
};

exports._waiting = function (registration) {
    return registration.waiting;
};

exports._scope = function (registration) {
    return registration.scope;
};

exports._update = function (registration) {
    return function (error, success) {
        try {
            registration.update().then(success, error);
        } catch (err) {
            error(err);
        }
    };
};

exports._unregister = function (registration) {
    return function (error, success) {
        try {
            registration.update().then(success, error);
        } catch (err) {
            error(err);
        }
    };
};

exports._onUpdateFound = function (registration) {
    return function (f) {
        return function () {
            registration.onupdatefound = function onupdatefound() {
                f();
            };
        };
    };
};
