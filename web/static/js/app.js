"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const build_1 = require("./build");
const ui_1 = require("./ui");
window.onload = () => {
    build_1.OnWindowLoadBuild();
    ui_1.OnWindowLoadUI();
};
