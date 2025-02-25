module.exports = {
    "parser": "@typescript-eslint/parser",
    "plugins": ["@typescript-eslint"],
    rules: {
        '@typescript-eslint/no-unused-expressions': 'error',
        '@typescript-eslint/no-redeclare': 'error',
        curly: 'error',
        '@typescript-eslint/naming-convention': ['error', { selector: 'class', format: ['PascalCase'] }],
        semi: 'error',
        eqeqeq: 'error',
        quotes: ['error', 'single', { avoidEscape: true }],
        'no-debugger': 'error',
        'no-empty': 'error',
        '@typescript-eslint/no-var-requires': 'error',
        'no-unsafe-finally': 'error',
        'new-parens': 'error',
        'no-throw-literal': 'error',
        'no-restricted-imports': ['error', 'require'],
      },
};
