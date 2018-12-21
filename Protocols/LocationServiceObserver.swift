//
//  LocationServiceObserver.swift
//  ChickyLocator
//
//  Created by Jared Williams on 12/16/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import MapKit

protocol LocationServiceObserver {
    func newLocation(location: CLLocation?)
}
