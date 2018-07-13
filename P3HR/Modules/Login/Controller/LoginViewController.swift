//
//  LoginViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 08/07/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class LoginViewController: ParentViewController {

    @IBOutlet weak var emailTextfield: P3HRTextField!
    
    @IBOutlet weak var passwordTextfield: P3HRTextField!
    
    @IBOutlet weak var loginButton: P3HRButton!
    @IBOutlet weak var forgotPaswordButton: P3HRButton!
    @IBOutlet weak var notYetRegisteredButton: P3HRButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.touchUpInside() {
            self.presetStroryboard(storyboard: UIStoryboard.patientStoryboard())
        }
        
        forgotPaswordButton.touchUpInside() {
            print("Here1")
        }
        
        notYetRegisteredButton.touchUpInside() {
            self.push(withIdentifier: .registeration, fromStoryboard: UIStoryboard.loginStoryboard())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
}
