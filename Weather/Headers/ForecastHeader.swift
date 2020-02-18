//
//  ForecastHeader.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/18/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//

import UIKit

class ForecastHeader: UITableViewHeaderFooterView {
	@IBOutlet weak var weekdayLabel: UILabel!

	func configure(from model: ForecastHeaderModel) {
		weekdayLabel.text = model.weekday
	}
}
