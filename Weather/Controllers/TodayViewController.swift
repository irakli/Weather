//
//  TodayViewController.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/15/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//

import UIKit
import CoreLocation

class TodayViewController: UIViewController {
	let apiKey = "3ca7f3e781e516b3d94d0199865b0cf3"
	
	var locationManager: CLLocationManager = CLLocationManager()
	var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
	var isLoading: Bool = true
		
	@IBOutlet weak var weatherIcon: UIImageView!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var weatherLabel: UILabel!
	@IBOutlet weak var blurLoading: UIVisualEffectView!
	@IBOutlet weak var refreshButton: UIBarButtonItem!
	@IBOutlet weak var shareButton: UIBarButtonItem!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setupLocationManager()
    }
	
	func setupLocationManager() {
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
	
	func getWeatherData() {
		toggleLoadingAnimation()
		
		let configuration = URLSessionConfiguration.default
		let session = URLSession(configuration: configuration)
		
	  	let task = session.dataTask(with: constructRequest()) { [weak self] (data, response, error) in
			guard let data = data, let httpResponse = response as? HTTPURLResponse else {
				print("Error")
				return
			}
			guard (200 ..< 300) ~= httpResponse.statusCode else {
				print("Status code error")
				return
			}
				  
			if let result = try? JSONDecoder().decode(CurrentWeatherResult.self, from: data) {
				if let weather = result.weather.first {
					DispatchQueue.main.async {
						self!.locationLabel.text = result.name
						self!.weatherLabel.text = "\(result.main.temp)°C | \(weather.main)"
						
						self!.toggleLoadingAnimation()
					}
				}
			}
		}
		
		task.resume()
	}
	
	func constructRequest() -> URLRequest {
		let api = "https://api.openweathermap.org"
		let endpoint = "/data/2.5/weather"
		let query = "?lat=\(location.latitude)&lon=\(location.longitude)"
		let params = "&appid=\(apiKey)&units=metric"
		let url = URL(string: api + endpoint + query + params)
		
		var request = URLRequest(url: url!)
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		
		return request
	}
	
	func toggleLoadingAnimation() {
		isLoading = !isLoading
		
		self.blurLoading.isHidden = isLoading
		self.refreshButton.isEnabled = isLoading
		self.shareButton.isEnabled = isLoading
	}

	@IBAction func refresh(_ sender: Any) {
		print("refresh")
		locationManager.startUpdatingLocation()
	}
	
	@IBAction func share(_ sender: Any) {
		print("share")
	}
}

extension TodayViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Location error: \(error.localizedDescription)")
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		location = (manager.location?.coordinate)!
		print("Current location: \(location.latitude) \(location.longitude)")
		
		getWeatherData()
		locationManager.stopUpdatingLocation()
	}
}
