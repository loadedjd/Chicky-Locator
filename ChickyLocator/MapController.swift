//
//  MapController.swift
//  ChickyLocator
//
//  Created by Jared Williams on 12/16/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapController : UIViewController, LocationServiceObserver, MKMapViewDelegate {
    
    private var request = MKLocalSearch.Request()
    private var selectedPlaceMark: CustomAnnotation?
    private var lastLocation: CLLocation?
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 8, y: 8, width: 35, height: 35))
        button.layer.cornerRadius = button.frame.width / 2
        button.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        button.setTitle("X", for: .normal)
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        return button
    }()
    
    private lazy var mapView: MKMapView = {
       let view = MKMapView()
        view.showsUserLocation = true
        view.delegate = self
        return view
    }()
    
    private lazy var locateButton: UIButton = {
       let button = UIButton(type: .system)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "futura", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(red: 3/255, green: 155/255, blue: 255/255, alpha: 0.9)
        button.layer.cornerRadius = 25
        button.setTitle("LOCATE CHICKY 🐓", for: .normal)
        button.addTarget(self, action: #selector(self.setupMapQuery), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        LocationService.sharedInstance.addObserver(observer: self)
        self.setupView()
    }
    
    @objc func setupMapQuery() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        request.naturalLanguageQuery = "chicken"
        let region = MKCoordinateRegion(center: self.mapView.region.center, latitudinalMeters: 3000, longitudinalMeters: 3000)
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start() { (response, error) in
            if error == nil, let items = response?.mapItems {
                items.forEach() { (item) in
                    let annotation = CustomAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.placemark.name ?? ""
                    
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.locateButton)
        
        self.constrainSubViews()
    }
    
    func constrainSubViews() {
        self.mapView.frame = self.view.frame
        self.locateButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16).isActive = true
        self.locateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.locateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.locateButton.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48).isActive = true
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func newLocation(location: CLLocation?) {
        if let loc = location {
            
            if lastLocation == nil {
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: loc.coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                
            } else {
                let distance = lastLocation?.distance(from: loc).magnitude ?? 0
                if distance > 1000 {
                    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    let region = MKCoordinateRegion(center: loc.coordinate, span: span)
                    self.mapView.setRegion(region, animated: true)
                }
            }
            
            self.lastLocation = loc
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "chicky"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if annotation is MKUserLocation {
            view?.image = UIImage(named: "m")
            return view
        }
        
        if view == nil {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            view?.canShowCallout = true
        } else {
            view?.annotation = annotation
        }
        
        if annotation is CustomAnnotation {
            view?.image = UIImage(named: "chicken")
            let button = UIButton(type: .system)
            button.setTitle("Get Directions to Chicky", for: .normal)
            button.addTarget(self, action: #selector(self.getDirections), for: .touchUpInside)
            view?.detailCalloutAccessoryView = button
            
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let customView = view.annotation as? CustomAnnotation {
            self.selectedPlaceMark = customView
        }
    }
    
    @objc func getDirections() {
        if let annotation = self.selectedPlaceMark, let coordinate = self.selectedPlaceMark?.coordinate {
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
            mapItem.name = annotation.title
            mapItem.openInMaps(launchOptions: [:])
        }
    }
}

