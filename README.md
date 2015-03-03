# Cordova.swift

![Logo](./cordova-swift.png)

## About

This project is porting Swift to the Apache Cordova.

Currently based upon this version of Cordova:

    $ cordova --version
    3.6.3-0.2.13

## Objective & Goals

* Provide Swift-language based project template to Cordova user.
* Porting to the Swift Cordova.

It can be used for Cordova projects that have native code not served
within separate plugins. Lets say code that should always run even
when Cordova app is closed.

## Install

    $ git clone https://github.com/masahirosuzuka/cordova.swift.git
    $ cd cordova.swift
    $ npm install

Make Cordova hooks executable

    $ find hooks/ -name '*.js' | xargs chmod +x

Ok lets add ios:

    $ cordova platform add ios
    $ cordova build ios

Now we are finally ready to `run`:

    $ cordova run ios

Don't emulate because all hooks not set up for that ~ simply always use `run`
it fall-backs to `emulate` but still ensures that the required hook was done.

## Inspect ios project in Xcode

    $ open PROJECT_DIR/ios-app/HelloCordova.xcodeproj

Don't modify the ios project under `PROJECT_DIR/platforms` it likely
get removed and/or modified because we move the required parts from
`PROJECT_DIR/ios-app` with Cordova hooks.


## Todo

- Clean up swift code for missing migrations.
- Clean up hooks for missing files not copied, added and removed etc..?
- Optimize the hooks and reuse common functions ~ walk is a number 1 candidate :)
- If possible add the executabel task to `npm install` roughly:

    ...
    "scripts": {
    "postinstall": "find hooks/ -name '*.js' | xargs chmod +x"
    }



----
<masahiro.suzuka@gmail.com>
<pellekrogholt@gmail.com>
