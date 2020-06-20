/* Cache Storage */

exports._deleteCache = function _deleteCache(cacheStorage) {
    return function (cacheName) {
        return function (error, success) {
            try {
                cacheStorage.delete(cacheName).then(success, error);
            } catch (err) {
                error(err);
            }
        };
    };
};

exports._hasCache = function _hasCache(cacheStorage) {
    return function (cacheName) {
        return function (error, success) {
            try {
                cacheStorage.has(cacheName).then(success, error);
            } catch (err) {
                error(err);
            }
        };
    };
};

exports._openCache = function _openCache(cacheStorage) {
    return function (cacheName) {
        return function (error, success) {
            try {
                cacheStorage.open(cacheName).then(success, error);
            } catch (err) {
                error(err);
            }
        };
    };
};

exports._keysCache = function _keysCache(cacheStorage) {
    return function (error, success) {
        try {
            cacheStorage.keys()
                        .then(function onSuccess(xs) {
                            return Array.prototype.slice.apply(xs);
                        })
                        .then(success, error);
        } catch (err) {
            error(err);
        }
    };
};

/* Cache */

exports._add = function _add(cache) {
    return function (req) {
        return function (error, success) {
            try {
                cache.add(req).then(success, error);
            } catch (err) {
                error(err);
            }
        };
    };
};

exports._addAll = function _addAll(cache) {
    return function (xs) {
        return function (error, success) {
            try {
                cache.addAll(xs).then(success, error);
            } catch (err) {
                error(err);
            }
        };
    };
};

exports._delete = function _delete(cache) {
    return function (req) {
        return function (opts) {
            return function (error, success) {
                try {
                    cache.delete(req, opts).then(success, error);
                } catch (err) {
                    error(err);
                }
            };
        };
    };
};

exports._keys = function _keys(cache) {
    return function (req) {
        return function (opts) {
            return function (error, success) {
                try {
                    cache.keys(req, opts)
                         .then(function onSuccess(xs) {
                             return Array.prototype.slice.apply(xs);
                         })
                         .then(success, error);
                } catch (err) {
                    error(err);
                }
            };
        };
    };
};

exports._match = function _match(cache) {
    return function (req) {
        return function (opts) {
            return function (error, success) {
                try {
                    cache.match(req, opts).then(success, error);
                } catch (err) {
                    error(err);
                }
            };
        };
    };
};

exports._matchAll = function _matchAll(cache) {
    return function (xs) {
        return function (opts) {
            return function (error, success) {
                try {
                    cache.matchAll(xs, opts)
                         .then(function onSuccess(xs_) {
                             return Array.prototype.slice.apply(xs_);
                         })
                         .then(success, error);
                } catch (err) {
                    error(err);
                }
            };
        };
    };
};

exports._put = function _put(cache) {
    return function (req) {
        return function (res) {
            return function (error, success) {
                try {
                    cache.put(req, res).then(success, error);
                } catch (err) {
                    error(err);
                }
            };
        };
    };
};
