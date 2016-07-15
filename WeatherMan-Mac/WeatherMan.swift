//
//  Meteo.swift
//  WeatherMan-Mac
//
//  Created by ERIC DEJONCKHEERE on 16/07/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Cocoa

public class WeatherMan {
    
    private let appID: String
    public var history: [WeatherResult] = []
    
    public init(appID: String) {
        self.appID = appID
    }
    
    public func currentWeather(city: String,
                               country code: String? = nil,
                                       completion: (weatherResult: WeatherResult)->()) {
        guard let url = makeURL(city, country: code) else {
            completion(weatherResult:
                WeatherResult(success: false, weather: nil, error: nil)
            ); return
        }
        getResponse(url) { (networkResult) in
            if let current = self.makeCurrentWeather(networkResult.json)
                where networkResult.success {
                let wr = WeatherResult(success: true, weather: current, error: nil)
                self.history.append(wr)
                completion(weatherResult: wr)
            } else {
                let wr = WeatherResult(success: false, weather: nil, error: networkResult.error)
                completion(weatherResult: wr)
            }
        }
    }
    
    public func getIcon(url: URL, completion:(icon: NSImage)->()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data where error == nil {
                if let image = NSImage(data: data) {
                    completion(icon: image)
                }
            }
        }.resume()
    }
    
    private func getResponse(_ url: URL, completion: (networkResult: NetworkResult)->()) {
        URLSession.shared.dataTask(with: url) { (
            data: Data?, response: URLResponse?, error: NSError?
            ) -> Void in
            if let data = data where error == nil {
                completion(networkResult:
                    NetworkResult(success: true, json: JSON(data: data), error: nil))
            } else {
                completion(networkResult:
                    NetworkResult(success: false, json: nil, error: error))
            }
        }.resume()
    }
    
    private func makeCurrentWeather(_ json: JSON) -> CurrentWeather? {
        guard let temp = json["main"]["temp"].int,
            speed = json["wind"]["speed"].double,
            cat = json["weather"][0]["main"].string,
            icon = json["weather"][0]["icon"].string,
            iconURL = URL(string: "http://openweathermap.org/img/w/\(icon).png"),
            desc = json["weather"][0]["description"].string,
            city = json["name"].string,
            country = json["sys"]["country"].string else {
                return nil
        }
        return CurrentWeather(date: Date(),
                              city: city,
                              country: country,
                              celsius: temp,
                              category: cat,
                              subCategory: desc,
                              windSpeed: speed,
                              windDirection: json["wind"]["deg"].int,
                              iconURL: iconURL)
    }
    
    private func makeURL(_ city: String, country code: String? = nil) -> URL? {
        guard let city = city.percentEncoded() else {
            return nil
        }
        if let c = code, country = c.percentEncoded() {
            return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city),\(country)&appid=\(appID)&units=metric&lang=fr")
        }
        return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appID)&units=metric&lang=fr")
    }
    
}
