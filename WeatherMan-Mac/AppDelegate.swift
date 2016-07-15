//
//  AppDelegate.swift
//  WeatherMan-Mac
//
//  Created by ERIC DEJONCKHEERE on 15/07/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationWillFinishLaunching(_ notification: Notification) {
        window.titlebarAppearsTransparent = true
        window.isMovableByWindowBackground = true
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

