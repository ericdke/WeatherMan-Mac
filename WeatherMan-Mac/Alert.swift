//
//  Alert.swift
//  WeatherMan-Mac
//
//  Created by ERIC DEJONCKHEERE on 15/07/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Cocoa

class Alert {
    
    class func basicDialog(question: String, text: String) -> Bool {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = question
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.warning
        myPopup.addButton(withTitle: "OK")
        myPopup.addButton(withTitle: "Cancel")
        return myPopup.runModal() == NSAlertFirstButtonReturn
    }
    
    class func criticalInfo(title: String, text: String) {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = title
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlertStyle.critical
        myPopup.addButton(withTitle: "OK")
        myPopup.runModal()
    }
}
