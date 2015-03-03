#!/usr/bin/env node

var fs = require('fs-extra');
var walk = function(dir) {
    var results = [];
    var list = fs.readdirSync(dir);
    list.forEach(function(file) {
        file = dir + '/' + file;
        var stat = fs.statSync(file);
        if (stat && stat.isDirectory()) results = results.concat(walk(file));
        else results.push(file);
    });
    return results
};

console.log('=======================================================');
console.log('after_platform_add/010_copy_native_to_platform.js start');
console.log('=======================================================');

console.log('~~~~~~~~ lets remove some objective-c files ~~~~~~~~~~~');
process.chdir('platforms/ios/HelloCordova/Classes');
files = walk('.');
files = files.map(function(file) {
    return file.substring(2);
});
files.forEach(function(file) {
  console.log(file);
  fs.unlinkSync(file);
});

process.chdir('..');
var mFile = 'main.m';
console.log(mFile);
fs.unlinkSync(mFile);

process.chdir('../../..');

console.log('=====================================================');
console.log('after_platform_add/010_copy_native_to_platform.js end');
console.log('=====================================================');
