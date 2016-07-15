//
//  WeatherResult.swift
//  WeatherManCLI
//
//  Created by ERIC DEJONCKHEERE on 08/06/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Foundation

public struct WeatherResult {
    let success: Bool
    let weather: CurrentWeather!
    let error: NSError?
}