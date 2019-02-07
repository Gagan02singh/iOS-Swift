//
//  LocationService.swift
//  GetGoingClass
//
//  Created by Diven Sambhwani on 1/30/19.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    //singleton
    static let shared = LocationService()
    //Mark:- Properties
    var locationManager: CLLocationManager?
    weak var delegate: LocationServiceDelegate?
    private override init(){
        super.init()
        locationManager = CLLocationManager()
        if CLLocationManager.authorizationStatus() == .notDetermined
        {
            locationManager?.requestWhenInUseAuthorization()
        }
        locationManager?.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager?.delegate = self
        
    }
    //Mark: - Location Manager
    
    
    func startUpdatingLocation(){
        locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation(){
        locationManager?.stopUpdatingLocation()
    }
    
    
}

extension LocationService: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]){
        print("latitude \(locations.last?.coordinate.latitude)longitude\(locations.last?.coordinate.longitude)")
        guard let location = locations.last else {return}
        delegate?.didUpdateLocation(location: location)
    }
}
//custom protocol
protocol LocationServiceDelegate: class{
    func didUpdateLocation(location: CLLocation)
}
