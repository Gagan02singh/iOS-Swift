//
//  GooglePlacesAPI.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 1/21/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation
import CoreLocation

class GooglePlacesAPI {
    class func requestPlaces(_ query: String, completion: @escaping(_ status: Int,_ json: [String: Any]?) -> Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.sheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.textPlaceSearch
        
        urlComponents.queryItems =
        [URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        if let url = urlComponents.url {
            NetworkingLayer.getRequest(with: url, timeoutInterval: 500){
                (status, data) in
                if let responseData = data, let jsonResponse = try? JSONSerialization.jsonObject(with:responseData,
                options: .allowFragments)
                as?
                [String: Any]{
                    completion(status, jsonResponse)
                }else{
                    completion(status,nil)
                }
            }
        }
    }



    class func requestPlacesNearby(for coordinate:CLLocationCoordinate2D,radius:Double, _ query: String?, completion: @escaping(_ status: Int,_ json: [String: Any]?) -> Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.sheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.nearbySearch
        
        urlComponents.queryItems =
            [URLQueryItem(name: "location", value: "\(coordinate.latitude),\(coordinate.longitude)"),
             URLQueryItem(name: "radius", value: "\(Int(radius))"),
             
             URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        if let keyword = query {
            urlComponents.queryItems?.append(URLQueryItem(name: "keyword", value: keyword))
        }
        if let url = urlComponents.url {
            NetworkingLayer.getRequest(with: url, timeoutInterval: 500){
                (status, data) in
                if let responseData = data, let jsonResponse = try? JSONSerialization.jsonObject(with:responseData,
                                                                                                 options: .allowFragments)
                    as?
                        [String: Any]{
                    completion(status, jsonResponse)
                }else{
                    completion(status,nil)
                }
            }
        }
    }

    
    class func requestDetails(_ place_Id: String, completion: @escaping(_ status: Int,_ json: [String: Any]?) -> Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.sheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.details
        
        urlComponents.queryItems =
            [URLQueryItem(name: "place_id", value: place_Id),
             URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        if let url = urlComponents.url {
            NetworkingLayer.getRequest(with: url, timeoutInterval: 500){
                (status, data) in
                if let responseData = data, let jsonResponse = try? JSONSerialization.jsonObject(with:responseData,
                                                                                                 options: .allowFragments)
                    as?
                        [String: Any]{
                    completion(status, jsonResponse)
                }else{
                    completion(status,nil)
                }
            }
        }
    }

}
