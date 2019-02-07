//
//  APIParser.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 1/23/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation

class APIParser{
    
    
    
    class func parsePlacesResponse(jsonObj: [String: Any]) -> [PlaceDetails]{
        var places : [PlaceDetails] = []
        
        if let results = jsonObj["results"] as? [[String: Any]]{
         
            results.forEach{(result) in
                if let place = PlaceDetails(json: result){
                    places.append(place)
                }
                
            }
        }
        return places;
    }
    
    class func parsePlacesDetails(jsonObj: [String: Any]) -> [Details]{
        var details: [Details] = []
        if let result = jsonObj["result"] as? [String: Any] {
            if let detail = Details(json: result) {
                details.append(detail)
            }
        }
        return details;
        }
    
    

    
    
}
