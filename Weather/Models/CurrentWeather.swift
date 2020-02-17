//
//  CurrentWeather.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/16/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//

import UIKit

struct CurrentWeatherResult: Codable {
	let cod: Int
	let name: String
	let weather: [CurrentWeather]
	let main: CurrentWeatherMain
	let wind: CurrentWeatherWind
	let clouds: CurrentWeatherClouds
}

struct CurrentWeather: Codable {
	let main: String
	let icon: String
	let description: String
}

struct CurrentWeatherMain: Codable {
	let temp: Float
	let pressure: Float
	let humidity: Float
}

struct CurrentWeatherWind: Codable {
	let speed: Float
	let deg: Float
}

struct CurrentWeatherClouds: Codable {
	let all: Float
}
