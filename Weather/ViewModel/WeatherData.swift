//
//  WeatherData.swift
//  Weather
//
//  Created by Adam Mikut on 11/04/2024.
//

import Foundation
import CoreLocation

struct WeatherData {
    let locationName: String
    let temperature: Double
    let condition: String
}

struct WeatherResponse: Codable {
    let name: String
    let main: MainWeather
    let weather: [Weather]
}


struct MainWeather: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

