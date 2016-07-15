//
//  NetworkResult.swift
//  WeatherManCLI
//
//  Created by ERIC DEJONCKHEERE on 07/06/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Foundation

public struct NetworkResult {
    let success: Bool
    let json: JSON!
    let error: NSError?
}
