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
        window.setFrameUsingName("WeatherMan-Mac")
        
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.orderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        window.saveFrame(usingName: "WeatherMan-Mac")
    }


}

