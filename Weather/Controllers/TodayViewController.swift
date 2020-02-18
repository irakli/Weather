//
//  TodayViewController.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/15/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//

import UIKit
import CoreLocation

class TodayViewController: WeatherViewController {	
	/* Main Components **/
	@IBOutlet weak var weatherIcon: UIImageView!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var weatherLabel: UILabel!
	@IBOutlet weak var refreshButton: UIBarButtonItem!
	@IBOutlet weak var shareButton: UIBarButtonItem!
	@IBOutlet weak var errorLabel: UILabel!
	
	/* Views **/
	@IBOutlet weak var errorView: UIView!
	@IBOutlet weak var detailsView: UIView!
	@IBOutlet weak var weatherView: UIView!
	@IBOutlet weak var loadingView: UIVisualEffectView!
	
	/* Details **/
	@IBOutlet weak var cloudiness: WeatherDetailView!
	@IBOutlet weak var humidity: WeatherDetailView!
	@IBOutlet weak var pressure: WeatherDetailView!
	@IBOutlet weak var wind: WeatherDetailView!
	@IBOutlet weak var windDirection: WeatherDetailView!
	
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
		
		getWeatherDetails(from: session)
	}
	
	func getWeatherDetails(from session: URLSession) {
		let task = session.dataTask(with: constructWeatherRequest()) { [weak self] (data, response, error) in
			guard let data = data, let httpResponse = response as? HTTPURLResponse else {
				self!.displayErrorText(with: "Error loading weather details")
				return
			}
			guard (200 ..< 300) ~= httpResponse.statusCode else {
				self!.displayErrorText(with: "Error loading weather details")
				return
			}
				  
			if let result = try? JSONDecoder().decode(CurrentWeatherResult.self, from: data) {
				if let weather = result.weather.first {
					DispatchQueue.main.async {
						self!.locationLabel.text = result.name
						self!.weatherLabel.text = "\(result.main.temp)°C | \(weather.main)"
						
						self!.cloudiness.info =  "\(result.clouds.all)%"
						self!.humidity.info = "\(result.main.humidity) mm"
						self!.pressure.info = "\(result.main.pressure) hPa"
						self!.wind.info = "\(result.wind.speed) km/h"
						self!.windDirection.info = String(result.wind.deg)
						
						// Get icon
						self!.getWeatherIcon(from: session, with: self!.constructIconRequest(with: weather.icon))
					}
				}
			}
		}
		
		task.resume()
	}
	
	func getWeatherIcon(from session: URLSession, with request: URLRequest) {
		let task = session.dataTask(with: request) { [weak self] (data, response, error) in
			guard let data = data, let httpResponse = response as? HTTPURLResponse else {
				self!.displayErrorText(with: "Error loading weather icon")
				return
			}
			guard (200 ..< 300) ~= httpResponse.statusCode else {
				self!.displayErrorText(with: "Error loading weather icon")
				return
			}

			if let image = UIImage(data: data) {
				DispatchQueue.main.async {
					self!.weatherIcon.image = image
					self!.toggleLoadingAnimation()
				}
			}
		}
		
		task.resume()
	}
	
	override func displayErrorText(with error: String) {
		self.errorLabel.text = error
		
		self.errorView.isHidden = false
		self.weatherView.isHidden = true
		self.detailsView.isHidden = true
	}
	
	func constructIconRequest(with name: String) -> URLRequest {
		let api = "https://openweathermap.org"
		let endpoint = "/img/wn"
		let query = "/\(name)"
		let params = "@2x.png"
		let url = URL(string: api + endpoint + query + params)
		
		var request = URLRequest(url: url!)
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "GET"
		
		return request
	}
	
	func constructWeatherRequest() -> URLRequest {
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
	
	override func toggleLoadingAnimation() {
		isLoading = !isLoading
		
		self.loadingView.isHidden = isLoading
		self.shareButton.isEnabled = isLoading
	}

	@IBAction func refresh(_ sender: Any) {
		self.errorView.isHidden = true
		self.weatherView.isHidden = false
		self.detailsView.isHidden = false
		
		locationManager.startUpdatingLocation()
	}
	
	@IBAction func share(_ sender: Any) {
		let items = ["\(locationLabel.text ?? ""): \(weatherLabel.text ?? "")"]
		let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
		present(ac, animated: true)
	}
}

extension TodayViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		displayErrorText(with: "Location error: \(error.localizedDescription)")
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		location = (manager.location?.coordinate)!

		getWeatherData()
		locationManager.stopUpdatingLocation()
	}
}
