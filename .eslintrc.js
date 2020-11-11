module.exports = {
    env: {
        browser: true,
        commonjs: true,
        es6: true,
        jquery: true
    },
    extends: [
        'airbnb-base'
    ],
    parserOptions: {
        ecmaVersion: 2018,
    },
    rules: {
        indent: ['error', 4],
        'linebreak-style': ['error', 'unix'],
    },
};

