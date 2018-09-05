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
    fileprivate var attachmentURL : URL?
    @IBOutlet weak var profileImageContainerButton: P3HRButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageViewHolder: UIView! {
        didSet {
            profileImageViewHolder.layer.cornerRadius = profileImageViewHolder.frame.size.width / 2
            profileImageViewHolder.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var profileImageHolderView: UIView!
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
    fileprivate var picker:UIImagePickerController? = UIImagePickerController()
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
        
        profileImageContainerButton.touchUpInside() { [unowned self] in
            self.imagePicker ()
        }
        
        addKeyBoardListener()
        
        authPresentor = AuthPresentor.init(withDelegate: self)
        
        registerButton.touchUpInside() { [unowned self] in
            self.view.endEditing(true)
            if self.attachmentURL != nil {
                self.uploadProfileImage(completion: { (path, error) in
                    if let error = error {
                        AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
                    }
                    else {
                        self.uploadProfile(withImagePath: path!)
                    }
                })
            }
            else {
                self.uploadProfile(withImagePath: "")
            }
        }
    }
    
    private func uploadProfileImage (completion : @escaping (String?, Error?) -> ()) {
        let url = self.attachmentURL!
        self.authPresentor.uploadProfileImage(withURL: url) { (attachment, error) in
            completion (attachment?.path, error)
        }
    }
    
    private func uploadProfile (withImagePath path : String) {
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
            
            self.authPresentor.register(withEmail: self.email , password: self.password, type: type, firstName: self.firstName, secondName: self.secondName, imagePath: path, completion: { (user, error) in
                if let error = error {
                    AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
                }
                else {
                    if self.isAPatient == true  {
                        self.presetStroryboard(storyboard: UIStoryboard.patientStoryboard())
                    }
                    else {
                        AlertManager.showAlert(inViewController: self, withTitle: "", message: ErrorMessage.USER_VERIFICATION_ERROR.message, cancelButtonTitle: "Ok", destructiveButtonTitle: nil, otherButtonTitles: nil, completion: nil, cancelCompletion: { [unowned self] in
                                self.navigationController?.popViewController(animated: true)
                        })
                    }
                }
            })
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
    
    
    private func imagePicker () {
        let alert:UIAlertController=UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let gallaryAction = UIAlertAction(title: "Choose Photo", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        alert.addAction(gallaryAction)
        let cameraAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        alert.addAction(cameraAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
            
        }
        alert.addAction(cancelAction)
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        picker?.delegate = self
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            picker!.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker!, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    
    private func openGallary() {
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker!, animated: true, completion: nil)
    }
}

extension RegistrationViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImageView.image = image
        }
        
        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentsDirectory.appendingPathComponent(imageURL.lastPathComponent!)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = UIImageJPEGRepresentation(image, 1.0) {
            if FileManager.default.fileExists(atPath: fileURL.path) == false {
                do {
                    // writes the image data to disk
                    try data.write(to: fileURL)
                    self.attachmentURL = fileURL
                    print("file saved")
                } catch {
                    print("error saving file:", error)
                }
            }
            else {
                self.attachmentURL = fileURL
            }
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker cancel.")
        picker.dismiss(animated: true, completion: nil)
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

