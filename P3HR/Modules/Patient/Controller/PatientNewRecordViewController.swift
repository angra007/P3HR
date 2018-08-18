//
//  PatientNewRecordViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 12/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit
import MobileCoreServices


class PatientNewRecordViewController: ParentViewController {
    @IBOutlet weak var attachmentLogo: UIImageView!
    @IBOutlet weak var attachmentLabel: UILabel!
    
    @IBOutlet weak var nameTextField: P3HRTextField!
    @IBOutlet weak var descriptionTextView: P3HRTextView!
    
    fileprivate var picker:UIImagePickerController? = UIImagePickerController()
    fileprivate var patientPresentor : PatientPresentor = PatientPresentor ()

    fileprivate var attachmentURL : URL! {
        didSet {
            
            if attachmentURL.absoluteString.isBlank == false {
                self.attachmentLogo.isHidden = false
                self.attachmentLabel.isHidden = false
            }
            else {
                self.attachmentLogo.isHidden = true
                self.attachmentLabel.isHidden = true
            }
           
        }
        
    }
    private func customizeNavigationBar () {
        let attachmentButton = UIBarButtonItem.init(image: UIImage.init(named: Key.attachment.rawValue), style: .plain, target: self, action: #selector (didTapAttachmentButton))
        let checkButton = UIBarButtonItem.init(image: UIImage.init(named: Key.done.rawValue), style: .plain, target: self, action: #selector (didTapDoneButton))
        self.navigationItem.rightBarButtonItems = [checkButton, attachmentButton]
    }
    
    @objc func didTapAttachmentButton () {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Image", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.imagePicker ()
        })
        
        let documentAction = UIAlertAction(title: "Document", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            
            let documentPicker = UIDocumentPickerViewController (documentTypes: [kUTTypePDF as String], in: .import)
            documentPicker.delegate = self
            if #available(iOS 11.0, *) {
                documentPicker.allowsMultipleSelection = false
            } else {
                // Fallback on earlier versions
            }
            self.present(documentPicker, animated: true, completion: nil)
            
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(saveAction)
        optionMenu.addAction(documentAction)
        optionMenu.addAction(cancelAction)
        
        
        if let popoverController = optionMenu.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    @objc func didTapDoneButton () {
        if nameTextField.text?.isBlank == true {
            self.showError(withMessage: ErrorMessage.RECORD_NAME_ERROR.message)
        }
        else if descriptionTextView.text.isBlank == true {
            self.showError(withMessage: ErrorMessage.RECORD_DESCRIPTION_ERROR.message)
        }
        else if self.attachmentURL.absoluteString.isBlank == true {
            self.showError(withMessage: ErrorMessage.RECORD_ATTACHMENT_ERROR.message)
        }
        else {
            
            patientPresentor.uploadDocument(withURL: self.attachmentURL) { [weak self](attachment, error) in
                
                if let attachment = attachment {
                    let profileID = UserDefaults.standard.string(forKey: "profileID")!
                    
                    var dict = [String : AnyObject] ()
                    dict ["name"] = self?.nameTextField.text! as AnyObject
                    dict ["description"] = self?.descriptionTextView.text! as AnyObject
                    dict ["path"] = attachment.path as AnyObject
                    dict ["patientID"] = profileID as AnyObject
                    
                    self?.patientPresentor.createRecord(withData: dict) { [weak self] (success, error) in
                        if success == true {
                            self?.navigationController?.popViewController(animated: true)
                        }
                        else if let error = error {
                            self?.showError(withMessage: error.localizedDescription)
                        }
                    }
                }
            }
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        customizeNavigationBar ()
        patientPresentor.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PatientNewRecordViewController : UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        self.attachmentURL = url
       
    }
}

extension PatientNewRecordViewController : PatientPresentorDelegate {
    
}

extension PatientNewRecordViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker .dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerReferenceURL] as? NSURL {
            self.attachmentURL = image as URL!
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker cancel.")
        picker.dismiss(animated: true, completion: nil)
    }
}





