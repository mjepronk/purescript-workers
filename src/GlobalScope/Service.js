/* Global Scope */

exports._caches = function () {
    return self.caches;
};

exports._clients = function () {
    return self.clients;
};

exports._registration = function () {
    return self.registration;
};

exports._skipWaiting = function () {
    self.skipWaiting();
};

exports._onInstall = function (f) {
    return function () {
        self.oninstall = function oninstall(e) {
            e.waitUntil(new Promise(function waitUntil(resolve, reject) {
                try {
                    f(reject, resolve);
                } catch (err) {
                    reject(err);
                }
            }));
        };
    };
};

exports._onActivate = function (f) {
    return function () {
        self.onactivate = function (e) {
            e.waitUntil(new Promise(function waitUntil(resolve, reject) {
                try {
                    f(reject, resolve);
                } catch (err) {
                    reject(err);
                }
            }));
        };
    };
};

exports._onFetch = function (toNullable) {
    return function (respondWith) {
        return function (waitUntil) {
            return function () {
                self.onfetch = function onfetch(e) {
                    e.respondWith(new Promise(function respondWithCb(resolve, reject) {
                        try {
                            respondWith(e.request)(function onSuccess(mres) {
                                var mres_ = toNullable(mres);
                                if (mres_ != null) {
                                    resolve(mres_);
                                    return;
                                }

                                self.fetch(e.request).then(resolve, reject);
                            }, reject);
                        } catch (err) {
                            reject(err);
                        }
                    }));

                    e.waitUntil(new Promise(function waitUntilCb(resolve, reject) {
                        try {
                            waitUntil(e.request)(resolve, reject);
                        } catch (err) {
                            reject(err);
                        }
                    }));
                };
            };
        };
    };
};

exports._onMessage = function(f) {
    return function () {
        self.onmessage = function(e) {
            e.waitUntil(new Promise(function (resolve, reject) {
                try {
                    f(e.source.id)(e.data)(reject, resolve);
                } catch (err) {
                    reject(err);
                }
            }));
        };
    };
};

/* Clients Interface */

exports._get = function(clients) {
    return function(id) {
        return function (error, success) {
            try {
                clients.get(id).then(success, error);
            } catch (err) {
                error(err);
            }
        };
    };
};

exports._matchAll = function(clients) {
    return function(opts) {
        return function(error, success) {
            try {
                clients.matchAll(opts)
                       .then(function onSuccess(matches) {
                           success(Array.prototype.slice.apply(matches));
                       })
                       .catch(error);
            } catch (err) {
                error(err);
            }
        };
    };
};

exports._openWindow = function(clients) {
    return function(url) {
        return function (error, success) {
            try {
                clients.openWindow(url).then(success, error);
            } catch (err) {
                error(err);
            }
        };
    };
};

exports._claim = function(clients) {
    return function(error, success) {
        try {
            clients.claim().then(success, error);
        } catch (err) {
            error(err);
        }
    };
};

/* Client Interface */

exports._url = function(client) {
    return client.url;
};

exports._frameType = function(toFrameType) {
    return function(client) {
        return toFrameType(client.frameType);
    };
};

exports._clientId = function(client) {
    return client.id;
};

/* Window Client Interface */

exports._visibilityState = function(toVisibilityState) {
    return function(client) {
        return toVisibilityState(client.visibilityState);
    };
};

exports._focused = function(client) {
    return client.focused;
};

exports._focus = function(client) {
    return function (error, success) {
        try {
            client.focus().then(success, error);
        } catch (err) {
            error(err);
        }
    };
};

exports._navigate = function(client) {
    return function(url) {
        return function (error, success) {
            client.navigate(url).then(success, error);
        };
    };
};
