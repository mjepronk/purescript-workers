/* Fetch */

exports._fetch = function (req) {
    return function (error, success) {
        try {
            fetch(req).then(success, error);
        } catch (err) {
            error(err);
        }
    };
};


/* Clone */

exports._clone = function (obj) {
    return function () {
        return obj.clone();
    };
};


/* Hasbody */

exports._text = function (body) {
    return function (error, success) {
        try {
            body.text().then(success, error);
        } catch (err) {
            error(err);
        }
    };
};


exports._json = function (body) {
    return function (error, success) {
        try {
            body.json().then(success, error);
        } catch (err) {
            error(err);
        }
    };
};


/* Request */

exports._new = function (url) {
    return new Request(url);
};

exports._newPrime = function (url, init) {
    return new Request(url, init);
};

exports._requestCache = function (constructor) {
    return function (req) {
        return constructor(req.cache);
    };
};

exports._requestCredentials = function (constructor) {
    return function (req) {
        return constructor(req.credentials);
    };
};

exports._requestDestination = function (constructor) {
    return function (req) {
        return constructor(req.destination);
    };
};

exports._requestHeaders = function (Header) {
    return function (constructor) {
        return function (req) {
            var headers = [];
            var gen = req.headers.entries();
            var entry = gen.next();
            while (!entry.done) {
                headers.push(constructor(Header(entry.value[0]))(entry.value[1]));
                entry = gen.next();
            }

            return headers;
        };
    };
};

exports._requestIntegrity = function (req) {
    return req.integrity;
};

exports._requestKeepAlive = function (req) {
    return req.keepalive;
};

exports._requestMethod = function (constructor) {
    return function (req) {
        return constructor(req.method);
    };
};

exports._requestMode = function (constructor) {
    return function (req) {
        return constructor(req.mode);
    };
};

exports._requestRedirect = function (constructor) {
    return function (req) {
        return constructor(req.redirect);
    };
};

exports._requestReferrer = function (req) {
    return req.referrer;
};

exports._requestReferrerPolicy = function (constructor) {
    return function (req) {
        return constructor(req.referrerPolicy);
    };
};

exports._requestURL = function (req) {
    return req.url;
};

exports._requestType = function (constructor) {
    return function (req) {
        return constructor(req.type);
    };
};


/* Response */

exports._responseError = function (res) {
    return res.error();
};

exports._responseHeaders = function (Header) {
    return function (constructor) {
        return function (res) {
            var headers = [];
            var gen = res.headers.entries();
            var entry = gen.next();
            while (!entry.done) {
                headers.push(constructor(Header(entry.value[0]))(entry.value[1]));
                entry = gen.next();
            }

            return headers;
        };
    };
};

exports._responseOk = function (res) {
    return res.ok;
};

exports._responseRedirect = function (res) {
    return function (url) {
        return function (statusCode) {
            return res.redirect(url, statusCode || undefined);
        };
    };
};

exports._responseRedirected = function (res) {
    return res.redirected;
};

exports._responseStatus = function (constructor) {
    return function (res) {
        return constructor(res.status);
    };
};

exports._responseStatusCode = function (res) {
    return res.status;
};

exports._responseType = function (constructor) {
    return function (res) {
        return constructor(res.type);
    };
};

exports._responseURL = function (res) {
    return res.url;
};
