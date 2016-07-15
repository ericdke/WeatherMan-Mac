//
//  Extensions.swift
//  WeatherManCLI
//
//  Created by ERIC DEJONCKHEERE on 07/06/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Foundation

public extension String {
    func percentEncoded() -> String? {
        return self.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed
        )
    }
}

public extension Double {
    func roundedOneDecimal() -> Double {
        return round(self * 10.0) / 10.0
    }
}

public extension Int {
    func degreesToCompass() -> String {
        let compass = ["Nord","Nord Nord-Est","Nord-Est","Est-Nord-Est","Est","Est-Sud-Est","Sud-Est","Sud-Sud-Est","Sud","Sud-Sud-Ouest","Sud-Ouest","Ouest-Sud-Ouest","Ouest","Ouest-Nord-Ouest","Nord-Ouest","Nord-Nord-Ouest"]
        let index = Int((Double(self) / 22.5) + 0.5) % 16
        return compass[index]
    }
}
