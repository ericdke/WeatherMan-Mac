//
//  Statuses.swift
//  WeatherMan-Mac
//
//  Created by ERIC DEJONCKHEERE on 16/07/2016.
//  Copyright © 2016 AYA.io. All rights reserved.
//

import Foundation

enum AppStatus: String {
    case locationAuthorized = "LOCATION SERVICES: AUTHORIZED"
    case locationStatusUnknown = "LOCATION SERVICES: STATUS UNKNOWN"
    case locationUnknownError = "LOCATION SERVICES: DAFUQ?"
    case locationUpdate = "LOCATION SERVICES: NEW LOCATION UPDATE"
    case apiFetching = "FETCHING API RESPONSE"
    case apiReceived = "RECEIVED API RESPONSE"
    case apiInvalid = "INVALID API RESPONSE"
    case apiError = "UNKNOWN API ERROR"
}
