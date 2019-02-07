//
//  Constants.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 1/21/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation

class Constants {
    static let apiKey = "AIzaSyD0ebZ2sxXHZyR8KwXtpoCaM4poSd3Ukpk"
   // AIzaSyAb406IbqnOim8znFXOqql2uEuRsGdQqzs"
    //
    static let sheme = "https"
    static let host = "maps.googleapis.com"
    static let textPlaceSearch = "/maps/api/place/textsearch/json"
    static let nearbySearch = "/maps/api/place/nearbysearch/json"
    static let details = "/maps/api/place/details/json"
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("PlaceDetails")
}
