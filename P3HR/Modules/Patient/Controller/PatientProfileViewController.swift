//
//  PatientProfileViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 12/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit
import SDWebImage

class PatientProfileViewController: ParentViewController, PatientPresentorDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var provienceLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    var patientProfile : PatientProfile?
    let patientPresentor = PatientPresentor()
    
    fileprivate var picker:UIImagePickerController? = UIImagePickerController()
    fileprivate var attachmentURL : URL!
    @IBOutlet weak var profileImageButton: P3HRButton!
    @IBAction func didTapEditButton(_ sender: UIBarButtonItem) {
       
        let profileEditVC = UIStoryboard.patientStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.patientEditProfile.rawValue) as! PatientEditProfileViewController
        profileEditVC.patientProfile = patientProfile
        self.navigationController?.pushViewController(profileEditVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        patientPresentor.delegate = self
        
        profileImageButton.touchUpInside() { [unowned self] in
            self.imagePicker()
        }
        
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        patientPresentor.getProfile { [weak self](patitent, error) in
            if let patitent = patitent {
                self?.patientProfile = patitent.user!
                self?.nameLabel.text = patitent.user!.firstName! + " " + patitent.user!.lastName!
                self?.emailLabel.text = patitent.user!.email
                self?.cityLabel.text = patitent.user!.city
                self?.provienceLabel.text = patitent.user!.province
                self?.phoneNumberLabel.text = "\(patitent.user!.phoneNumber)"
                
                if patitent.user!.imagePath?.isBlank == false {
                    let imageURL = RequestType.profileImage.url + "/" + patitent.user!.imagePath!
                    
                    self?.profileImageView.sd_setImage(with: URL.init(string: imageURL), placeholderImage: nil, completed: { (image, error, type, url) in
                    })
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension PatientProfileViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
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
                } catch {
                    print("error saving file:", error)
                }
            }
            else {
            }
            
            patientPresentor.uploadProfileImage(withURL: fileURL) { (attachment, error) in
                if let error = error {
                    AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
                }
                else {
                    ActivityIndicatorManager.showActivityIndicator()
                    
                    
                    let profileID = UserDefaults.standard.string(forKey: "profileID")!
                    var dict = [String : String] ()
                    dict ["profileID"] = profileID
                    dict ["imagePath"] = attachment!.path!
                    
                    self.patientPresentor.updateProfile(withDict: dict, completed: { (patitent, error) in
                        if let error = error {
                            AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
                        }
                        else {
                            try! FileManager.default.removeItem(at: fileURL)
                            self.profileImageView.image = image
                        }
                    })
                }
            }

            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("picker cancel.")
        picker.dismiss(animated: true, completion: nil)
    }
}
