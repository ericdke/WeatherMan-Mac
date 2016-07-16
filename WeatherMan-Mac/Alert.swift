//
//  Alert.swift
//  WeatherMan-Mac
//
//  Created by ERIC DEJONCKHEERE on 15/07/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Cocoa

class Alert {
    
    class func criticalInfo(title: String, text: String) {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = title
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.critical
        myPopup.addButton(withTitle: "OK")
        myPopup.runModal()
    }
    
    class func denied() {
        criticalInfo(title: "Not authorized",
                     text: "Location services have been denied for this app - it can't run and will quit immediately.")
    }
}
