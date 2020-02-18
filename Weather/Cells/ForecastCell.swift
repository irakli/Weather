//
//  ForecastCell.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/18/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
	@IBOutlet weak var iconImage: UIImageView!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	func configure(from model: ForecastCellModel) {
		iconImage.image = model.icon
		timeLabel.text = model.time
		descriptionLabel.text = model.description
		temperatureLabel.text = "\(model.temperature)°C"
	}
}
