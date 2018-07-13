//
//  P3HRTextField.swift
//  P3HR
//
//  Created by Ankit Angra on 04/07/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class P3HRTextField: JVFloatLabeledTextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI ()

    }
    
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func updateUI () {
        
//        let border = CALayer()
//        let width = CGFloat(0.5)
//        border.borderColor = UIColor.darkGray.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.bounds.size.width, height: self.frame.size.height)
//        print(border.frame)
//        border.borderWidth = width
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
        
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: self.frame.height))
        view.backgroundColor = UIColor.clear
        self.leftView = view
        self.leftViewMode = .always
        
        self.floatingLabelTextColor = Styles.color(forKey: .formFieldPlaceholderActiveColor)
        self.floatingLabelActiveTextColor = Styles.color(forKey: .formFieldPlaceholderActiveColor)
    }

}
