//
//  Globals.swift
//  WeatherMan-Mac
//
//  Created by ERIC DEJONCKHEERE on 15/07/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Foundation

public func log(_ obj: AnyObject) {
    if let error = obj as? NSError {
        NSLog("%@", error.debugDescription)
    } else if let text = obj as? String {
        NSLog("%@", text)
    } else {
        NSLog("%@", "\(obj)")
    }
}
