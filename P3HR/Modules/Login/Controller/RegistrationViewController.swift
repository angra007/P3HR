//
//  RegistrationViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 08/07/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class RegistrationViewController: ParentViewController, AuthDelegate {
   
    
    var authPresentor : AuthPresentor!
    
    private var firstName : String = ""
    private var secondName : String = ""
    private var email : String = ""
    private var password : String = ""
    private var confirmPassword : String = ""
    
    let FIRST_NAME_TAG = 10001
    let EMAIL_TAG = 10002
    let PASSWORD_TAG = 10003
    let CONFIRM_PASSWORD_TAG = 10004
    let SECOND_NAME_TAG = 10005
    
    
    @IBOutlet weak var registerButton: P3HRButton!
    
    @IBOutlet weak var firstNameTextField: P3HRTextField! {
        didSet {
            firstNameTextField.delegate = self
            firstNameTextField.tag = FIRST_NAME_TAG
        }
    }
    
    @IBOutlet weak var secondNameTextField: P3HRTextField! {
        didSet {
            secondNameTextField.delegate = self
            secondNameTextField.tag = SECOND_NAME_TAG
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
        isPatientButton.touchUpInside() { [unowned self] in
            self.isAPatient = true
        }
        
        isProfessionalButton.touchUpInside() { [unowned self] in
            self.isAPatient = false
        }
        addKeyBoardListener()
        
        authPresentor = AuthPresentor.init(withDelegate: self)
        
        registerButton.touchUpInside() { [unowned self] in
            self.view.endEditing(true)
            if self.firstName.isBlank == true {
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
               
                var type : String = ""
                if self.isAPatient == true {
                    type = "Patient"
                }
                else {
                    type = "HealthProfessional"
                }
                
                self.authPresentor.register(withEmail: self.email , password: self.password, type: type, firstName: self.firstName, secondName: self.secondName,completion: { (user, error) in
                    if let error = error {
                        AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
                    }
                    else {
                        if self.isAPatient == true  {
                            self.presetStroryboard(storyboard: UIStoryboard.patientStoryboard())
                        }
                        else {
                            AlertManager.showAlert(inViewController: self, withTitle: "", message: ErrorMessage.USER_VERIFICATION_ERROR.message, cancelButtonTitle: "Ok", destructiveButtonTitle: nil, otherButtonTitles: nil, completion: nil, cancelCompletion: {
                                
                            })
                        }
                    }
                })
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.firstNameTextField.becomeFirstResponder()
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
            if textField.tag == FIRST_NAME_TAG {
                self.firstName = text
            }
            else if textField.tag == SECOND_NAME_TAG {
                self.secondName = text
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

