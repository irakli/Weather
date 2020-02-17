//
//  WeatherDetailView.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/17/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {
	
	@IBInspectable var icon: UIImage? {
		get {
			return iconImage.image
		}
		set (icon) {
			iconImage.image = icon
		}
	}
	@IBInspectable var info: String? {
		get {
			return infoLabel.text
		}
		set (info) {
			infoLabel.text = info
		}
	}
	
	@IBOutlet weak var iconImage: UIImageView!
	@IBOutlet weak var infoLabel: UILabel!
	
    let nibName = "WeatherDetailView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
	
	override func awakeFromNib() {
		infoLabel.text = info
		iconImage.image = icon
	}
}
