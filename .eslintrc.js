module.exports = {
  root: false,
  env: {
    node: true
  },
  // extends: ["plugin:vue/essential", "@vue/prettier"],
  extends: ["plugin:vue/base"],
  rules: {
    "no-console": process.env.NODE_ENV === "production" ? "error" : "off",
    "no-debugger": process.env.NODE_ENV === "production" ? "error" : "off"
  },
  parserOptions: {
    parser: "babel-eslint",
    "eqeqeq": 0,
    "no-eq-null": 0,
    "indent": ["error", "tab"]
  }
};
