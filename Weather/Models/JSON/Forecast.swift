//
//  Forecast.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/18/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//

import UIKit

struct ForecastResult: Codable {
	let cod: String
	let message: Int
	let list: [Forecast]
}

struct Forecast: Codable {
	let main: ForecastMain
	let weather: [ForecastWeather]
	let dt_txt: String
}

struct ForecastMain: Codable {
	let temp: Float
}

struct ForecastWeather: Codable {
	let id: Int
	let description: String
	let icon: String
}
