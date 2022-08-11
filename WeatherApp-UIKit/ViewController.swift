//
//  ViewController.swift
//  WeatherApp-UIKit
//
//  Created by SIMONOV on 09.08.2022.
//

import UIKit
import CoreLocation

final class ViewController: UIViewController {

    
    let locationManager = CLLocationManager()
    
    var model = WeatherData()
    
    var data = DataSource()
    
    var networkService = NetworkWeatherManager()

    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDiscriptionLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       startLocationManager()
    
    }
    
//MARK: - Func
    
    private func updateView() {
        cityNameLabel.text = model.name
        weatherDiscriptionLabel.text = data.weatherIDs[model.weather[0].id]
        temperatureLabel.text = model.main.temp.description + "°"
        weatherIconImageView.image = UIImage(named: model.weather[0].icon)
    }
    
    private func startLocationManager() {
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
}

//MARK: - extension

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
            networkService.updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude) { [weak self] data in
                if let strongSelf = self {
                    strongSelf.model = data
                    strongSelf.updateView()
                }
            }
        }
    }
}

