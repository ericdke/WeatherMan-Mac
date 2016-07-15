//
//  WeatherDescriptor.swift
//  WeatherManCLI
//
//  Created by ERIC DEJONCKHEERE on 11/06/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Foundation

public class WeatherDescriptor {
    
    private let dateFormatter: DateFormatter
    
    public init() {
        dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyy/MM/dd HH:mm:ss"
    }
    
    public func describe(weather: CurrentWeather, style: WeatherDescriptionStyle = .gui) -> String {
        return makeDescription(weather, style: style)
    }
    
    private func makeDescription(_ weather: CurrentWeather, style: WeatherDescriptionStyle) -> String {
        let loc = "\(weather.city) (\(weather.country))"
        let ds = dateString(weather)
        let base = "\(loc), \(ds)."
        let temp = "Temp: \(weather.celsius) ºC."
        let normal = "\(base) \(temp)"
        let mood = "Ciel: \(weather.subCategory)."
        switch style {
        case .gui, .detailed:
            if let dir = weather.windDirection {
                return "\(base)\n\(mood) Vent: \(dir.degreesToCompass()) à \(weather.windSpeed) km/h."
            } else {
                return "\(base)\n\(mood) Vent: Négligeable."
            }
        case .string:
            return normal
        case .mini:
            return temp
        }
    }
    
    private func dateString(_ weather: CurrentWeather) -> String {
        return dateFormatter.string(from: weather.date as Date)
    }
}
