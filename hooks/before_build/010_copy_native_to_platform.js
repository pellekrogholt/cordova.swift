#!/usr/bin/env node

var fs = require('fs-extra');
var ignore = require('ignore');
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

console.log('=================================================');
console.log('before_build/010_copy_native_to_platform.js start');
console.log('=================================================');

process.chdir('./ios-app/');
files = walk('.');

var ig = ignore().addPattern(
  [
    '.git/',
    '.gitignore',
    'build',
    'project.xcworkspace/',
    'xcuserdata',
    'cordova',
    'CordovaLib',
    'platform_www',
    'www',
    'HelloCordova/config.xml',
    'HelloCordova/Resources/'
  ]);


// todo:
// there are more candidates to merged / ignored etc
// - HelloCordova/config.xml (might need to be merged ?)
// - HelloCordova/Resources

files = files.map(function(file) {
    return file.substring(2);
});

files = ig.filter(files);

files.forEach(function(file) {
  var stat = fs.statSync(file);
  var target = '../platforms/ios/' + file;
  console.log(file);
  console.log(target);
  fs.copySync(file, target);
  fs.utimesSync(target, stat.atime, stat.mtime);
});

process.chdir('..');


console.log('===============================================');
console.log('before_build/010_copy_native_to_platform.js end');
console.log('===============================================');
