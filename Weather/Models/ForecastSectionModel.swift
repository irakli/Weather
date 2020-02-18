//
//  ForecastSectionModel.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/18/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//


struct ForecastSectionModel {
	var header: ForecastHeaderModel?
	var cells = [ForecastCellModel]()
	
	var numberOfRows: Int {
		return cells.count
	}
}
