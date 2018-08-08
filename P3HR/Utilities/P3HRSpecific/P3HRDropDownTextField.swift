//
//  P3HRDropDownTextField.swift
//  P3HR
//
//  Created by Ankit Angra on 07/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class P3HRDropDownTextField : P3HRTextField {
    
    open var pickerView: UIPickerView!
    
    public fileprivate(set) var options: [String] = []
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.prepare()
    }
    
    open func prepare() {
        
        rightViewMode = .always
        rightView?.isUserInteractionEnabled = false
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        self.inputView = picker
        pickerView = picker
        
        let frame = CGRect.init(x: self.frame.width - 50, y: 0, width: 50, height: self.frame.size.height)
        let shim = UIView.init(frame: frame)
        shim.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selfTapped)))
        addSubview(shim)
        
    }
    
    // We don't really need a cursor here.
    override open func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    open func updateOptions(options: [String]) {
        self.options = options
        self.text = self.options.first
        pickerView.reloadAllComponents()
    }
    
    open func setSelectedOption(option: String?) {
        guard let o = option else { return }
        if let index = options.index(of: o) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
            text = o
        }
    }
    
    @objc func selfTapped() {
        debugPrint("tapped")
        _ = self.becomeFirstResponder()
    }
}

extension P3HRDropDownTextField: UIPickerViewDataSource {
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
}

extension P3HRDropDownTextField: UIPickerViewDelegate {
    
    open func pickerView(_ pickerView: UIPickerView,
                         titleForRow row: Int,
                         forComponent component: Int) -> String? {
        return options[row]
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = options[row]
    }
}








