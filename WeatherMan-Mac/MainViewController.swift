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
    
    @IBOutlet weak var mainView: MainView!
    
    let weatherMan = WeatherMan(appID: "d21991d7851f849bfe8cc24d12c795d0")
    let descriptor = WeatherDescriptor()
    let locManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    override func awakeFromNib() {
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        startMonitoring()
        _ = Timer.scheduledTimer(timeInterval: 60 * 5, // every 5 minutes
                                 target: self,
                                 selector: #selector(startMonitoring),
                                 userInfo: nil,
                                 repeats: true)
    }
    
    func startMonitoring() {
        locManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            log(AppStatus.locationAuthorized.rawValue)
        case .restricted, .denied:
            Alert.denied()
            NSApplication.shared().terminate(nil)
        case .notDetermined:
            log(AppStatus.locationStatusUnknown.rawValue)
        default:
            log(AppStatus.locationUnknownError.rawValue)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateTo newLocation: CLLocation,
                         from oldLocation: CLLocation) {
        log(AppStatus.locationUpdate.rawValue)
        geoCoder.reverseGeocodeLocation(newLocation) { (placemarks, error) in
            if let places = placemarks, place = places.last where error == nil {
                if let pl = place.locality, pc = place.country {
                    self.locManager.stopUpdatingLocation()
                    self.getWeather(city: pl, country: pc)
                }
            } else {
                if let error = error {
                    log(error)
                } else {
                    log(AppStatus.locationUnknownError.rawValue)
                }
            }
        }
    }
    
    private func getWeather(city: String, country: String) {
        log(AppStatus.apiFetching.rawValue)
        weatherMan.currentWeather(city: city, country: country) { (result) in
            if result.success {
                log(AppStatus.apiReceived.rawValue)
                self.populateView(with: result)
            } else {
                if let error = result.error {
                    log(error)
                } else {
                    log(AppStatus.apiError.rawValue)
                }
            }
        }
    }
    
    private func populateView(with result: WeatherResult) {
        if let w = result.weather {
            DispatchQueue.main.sync(execute: {
                mainView.weather.stringValue = descriptor.describe(weather: w)
                mainView.temp.stringValue = "\(w.celsius) °C"
            })
            weatherMan.getIcon(url: w.iconURL, completion: { (icon) in
                DispatchQueue.main.sync(execute: {
                    self.mainView.iconView.image = icon
                })
            })
        } else {
            log(AppStatus.apiInvalid.rawValue)
        }
    }
    
}
