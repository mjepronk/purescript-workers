module.exports = (config) => {
    config.set({
        autoWatch: true,
        singleRun: false,
        browsers: ['Chrome', 'Firefox'],
        browserConsoleLogOptions: {
            level:  "debug",
            terminal: true
        },
        basePath: 'dist/karma',
        customHeaders: [{
            match: '.*',
            name: 'Service-Worker-Allowed',
            value: '/',
        }],
        files: [
            'index.js',
            {
                watched: false,
                pattern: 'worker*.js',
                included: false,
                served: true,
            },
        ],
        frameworks: [
            'mocha',
        ],
        plugins: [
            'karma-chrome-launcher',
            'karma-firefox-launcher',
            'karma-spec-reporter',
            'karma-mocha',
        ],
        reporters: ['spec', 'progress'],
        client: {
            captureConsole: true,
            mocha: {
                timeout: 10000,
            },
        },
    });
};
