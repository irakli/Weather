//
//  ReusableView.swift
//  Delegation
//
//  Created by Saba Khutsishvili on 11/9/19.
//  Copyright © 2019 Saba Khutsishvili. All rights reserved.
//

import UIKit

class ReusableView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
        let bundle = Bundle(for: ReusableView.self)

			bundle.loadNibNamed(className, owner: self, options: nil)
        
        guard let content = contentView else {
            fatalError("contentView Not Set")
        }
        
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(content)
    }
}

extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
