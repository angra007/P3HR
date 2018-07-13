//
//  RegistrationViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 08/07/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class RegistrationViewController: ParentViewController {
   
    
    private var name : String = ""
    private var email : String = ""
    private var password : String = ""
    private var confirmPassword : String = ""
    let NAME_TAG = 10001
    let EMAIL_TAG = 10002
    let PASSWORD_TAG = 10003
    let CONFIRM_PASSWORD_TAG = 10004
    
    
    @IBOutlet weak var registerButton: P3HRButton!
    
    @IBOutlet weak var nameTextField: P3HRTextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.tag = NAME_TAG
        }
    }
    
    @IBOutlet weak var emailTextField: P3HRTextField! {
        didSet {
            emailTextField.delegate = self
            emailTextField.tag = EMAIL_TAG
        }
    }
    
    @IBOutlet weak var passwordTextField: P3HRTextField! {
        didSet {
            passwordTextField.delegate = self
            passwordTextField.tag = PASSWORD_TAG
        }
    }
    
    @IBOutlet weak var confirmPasswordTextField: P3HRTextField! {
        didSet {
            confirmPasswordTextField.delegate = self
            confirmPasswordTextField.tag = CONFIRM_PASSWORD_TAG
        }
    }
    
    @IBOutlet weak var registerButtonBottomConstraint: NSLayoutConstraint!
   
    var isAPatient = true {
        didSet {
            if isAPatient == true {
                self.patientCheckImageView.image = UIImage.init(named: "check")
                self.isPatientButton.isSelected = true
                self.isProfessionalButton.isSelected = false
                self.professionalCheckImage.image = nil
            }
            else {
                self.professionalCheckImage.image = UIImage.init(named: "check")
                self.isProfessionalButton.isSelected = true
                self.isPatientButton.isSelected = false
                self.patientCheckImageView.image = nil
            }
        }
    }
    
    @IBOutlet weak var isPatientButton: P3HRButton!
    @IBOutlet weak var patientCheckImageView: UIImageView!
   
    @IBOutlet weak var professionalCheckImage: UIImageView!
    @IBOutlet weak var isProfessionalButton: P3HRButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isAPatient = true
        isPatientButton.touchUpInside() {
            self.isAPatient = true
        }
        
        isProfessionalButton.touchUpInside() {
            self.isAPatient = false
        }
        addKeyBoardListener()
        
        registerButton.touchUpInside() {
           
            if self.name.isBlank == true {
                AlertManager.showAlert(inViewController: self, withTitle: "", message: ErrorMessage.REGISTRATION_EMAIL_ERROR.message)
            }
            else if self.email.isBlank == true {
                AlertManager.showAlert(inViewController: self, withTitle: "", message: ErrorMessage.REGISTRATION_EMAIL_ERROR.message)
            }
            else if self.password.isBlank == true {
                AlertManager.showAlert(inViewController: self, withTitle: "", message: ErrorMessage.REGISTRATION_PASSWORD_ERROR.message)
            }
            else if self.confirmPassword != self.password {
                AlertManager.showAlert(inViewController: self, withTitle: "", message: ErrorMessage.REGISTRATION_CONFIRM_PASSWORD_ERROR.message)
            }
            else {
                self.view.endEditing(true)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nameTextField.becomeFirstResponder()
    }
    
    func addKeyBoardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let duration = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
            self.registerButtonBottomConstraint.constant = keyboardHeight
            UIView.animate(withDuration:duration!) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        print(notification)
        self.registerButtonBottomConstraint.constant = 0
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

extension RegistrationViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text  = textField.text {
            if textField.tag == NAME_TAG {
                self.name = text
            }
            else if textField.tag == EMAIL_TAG {
                self.email = text
            }
            else if textField.tag == PASSWORD_TAG {
                self.password = text
            }
            else if textField.tag == CONFIRM_PASSWORD_TAG {
                self.confirmPassword = text
            }
        }
    }
}

