//
//  WeatherViewController.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/15/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
	let apiKey = "3ca7f3e781e516b3d94d0199865b0cf3"
	
	var locationManager: CLLocationManager = CLLocationManager()
	var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
	var isLoading: Bool = true
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	// Abstract methods would be reaaaaaally nice rn.
	func toggleLoadingAnimation() {fatalError("Must override")}
	func displayErrorText(with error: String) {fatalError("Must override")}
}
