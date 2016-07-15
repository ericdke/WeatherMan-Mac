//
//  MainViewcontroller.swift
//  WeatherMan-Mac
//
//  Created by ERIC DEJONCKHEERE on 15/07/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Cocoa
import CoreLocation

class MainViewController: NSViewController, CLLocationManagerDelegate {
    
    let meteo = Meteo(appID: "d21991d7851f849bfe8cc24d12c795d0")
    let descriptor = WeatherDescriptor()
    let manager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    override func awakeFromNib() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        startMonitoring()
        _ = Timer.scheduledTimer(timeInterval: 60 * 5, // every 5 minutes
                                 target: self,
                                 selector: #selector(startMonitoring),
                                 userInfo: nil,
                                 repeats: true)
    }
    
    @IBOutlet weak var mainView: MainView!
    
    func startMonitoring() {
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            log("LOCATION SERVICES: AUTHORIZED")
        case .restricted, .denied:
            Alert.criticalInfo(title: "Not authorized",
                            text: "Location services have been denied for this app - it can't run and will quit immediately.")
            NSApplication.shared().terminate(nil)
        case .notDetermined:
            log("LOCATION SERVICES: STATUS UNKNOWN")
        default:
            log("LOCATION SERVICES: DAFUQ?")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateTo newLocation: CLLocation, from oldLocation: CLLocation) {
        log("LOCATION SERVICES: NEW LOCATION UPDATE")
        geoCoder.reverseGeocodeLocation(newLocation) { (placemarks, error) in
            if let places = placemarks, place = places.last where error == nil {
                if let loc = place.locality, c = place.country {
                    self.manager.stopUpdatingLocation()
                    self.getWeather(city: loc, country: c)
                }
            } else {
                log("UNKNOWN ERROR IN \(#function)")
            }
        }
    }
    
    private func getWeather(city: String, country: String) {
        log("FETCHING API RESPONSE")
        meteo.currentWeather(city: city, country: country) { (result) in
            if result.success {
                log("RECEIVED API RESPONSE")
                self.populateView(with: result)
            } else {
                if let error = result.error {
                    log(error)
                } else {
                    log("UNKNOWN ERROR IN \(#function)")
                }
            }
        }
    }
    
    private func populateView(with result: WeatherResult) {
        if let w = result.weather {
            DispatchQueue.main.sync(execute: {
                self.mainView.weather.stringValue = self.descriptor.describe(weather: w, style: .gui)
                self.mainView.temp.stringValue = "\(w.celsius) °C"
            })
            self.meteo.getIcon(url: w.iconURL, completion: { (icon) in
                DispatchQueue.main.sync(execute: {
                    self.mainView.iconView.image = icon
                })
            })
        } else {
            log("INVALID API RESPONSE")
        }
    }
    
}
