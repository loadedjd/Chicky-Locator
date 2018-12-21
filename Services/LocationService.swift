//
//  LocationService.swift
//  ChickyLocator
//
//  Created by Jared Williams on 12/16/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import MapKit

class LocationService : NSObject, CLLocationManagerDelegate, LocationServiceProto {
    
    public static var sharedInstance = LocationService()
    
    private var locationManager: CLLocationManager?
    private var delegates: [LocationServiceObserver]?
    
    func addObserver(observer: LocationServiceObserver) {
        if self.delegates == nil {
            self.delegates = [LocationServiceObserver]()
        }
        
        self.delegates?.append(observer)
    }
    
    override init() {
        super.init()
    }
    
    public func setup() {
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.delegate = self
        
        self.locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            self.locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.delegates?.forEach( { (delegate) in delegate.newLocation(location: locations.last)})
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            self.locationManager?.startUpdatingLocation()
        }
    }
}
