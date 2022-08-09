//
//  ViewController.swift
//  WeatherApp-UIKit
//
//  Created by SIMONOV on 09.08.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
       startLocationManager()
    }
    private func startLocationManager() {
        locationManager.requestWhenInUseAuthorization() /
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation() 
        }
    }

}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }
    }
}

