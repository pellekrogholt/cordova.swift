#!/usr/bin/env node

var fs = require('fs-extra');
var walk = function(dir) {
    var results = []
    var list = fs.readdirSync(dir)
    list.forEach(function(file) {
        file = dir + '/' + file
        var stat = fs.statSync(file)
        if (stat && stat.isDirectory()) results = results.concat(walk(file))
        else results.push(file)
    })
    return results
};

console.log('==========================================');
console.log('hooks/before_run/010_copy_ios_src.js start');
console.log('');

process.chdir('./ios-app/');
files = walk('HelloCordova/Classes');
// note: add more dirs here ~ simply concatenate
// files = files.concat(walk('HelloCordova/test'));

files.forEach(function(file) {
  var stat = fs.statSync(file);
  var target = '../platforms/ios/' + file;
  console.log(file);
  console.log(target);
  fs.copySync(file, target);
  fs.utimesSync(target, stat.atime, stat.mtime);
});

process.chdir('..');

console.log('');
console.log('hooks/before_run/010_copy_ios_src.js end');
console.log('========================================');
