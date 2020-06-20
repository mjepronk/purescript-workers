const statusDict = {
    0: 'uncached',
    1: 'idle',
    2: 'checking',
    3: 'downloading',
    4: 'updateready',
    5: 'obsolete',
};

exports.abort = function abort(appCache) {
    return function () {
        return appCache.abort();
    };
};

exports._status = function _status(toStatus) {
    return function (appCache) {
        return toStatus(statusDict[appCache.status]);
    };
};

exports.swapCache = function swapCache(appCache) {
    return function () {
        appCache.swapCache();
    };
};

exports.update = function update(appCache) {
    return function () {
        appCache.update();
    };
};
