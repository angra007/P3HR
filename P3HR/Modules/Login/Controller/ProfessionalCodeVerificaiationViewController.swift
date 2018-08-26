//
//  ProfessionalCodeVerificaiationViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 24/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class ProfessionalCodeVerificaiationViewController: ParentViewController, ProfessionalPresentorDelegate {
    
    @IBOutlet weak var continueButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var codeTextField: P3HRTextField!
    @IBOutlet weak var didnotGotACodeButton: P3HRButton!
    @IBOutlet weak var verifyButton: P3HRButton!
    
    var professionalPresentor : ProfessionalPresentor!
    
    private func registerForEvents () {
        didnotGotACodeButton.touchUpInside() { [unowned self] in
            self.professionalPresentor.resendCode(completion: { (done, error) in
                if let error = error {
                    AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
                }
                else {
                    AlertManager.showAlert(inViewController: self, withTitle: "", message: ErrorMessage.CODE_SENT_VERIFICATION.message)
                }
            })
        }
        
        verifyButton.touchUpInside() { [unowned self] in
            if self.codeTextField.text?.count != 6 {
                AlertManager.showAlert(inViewController: self, withTitle: "", message: "Incorrect Code")
            }
            else {
                self.professionalPresentor.verifyCode(self.codeTextField.text!, completion: { (verified, error) in
                    if let error = error {
                        AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
                    }
                    else {
                        if verified == true {
                            self.presetStroryboard(storyboard: UIStoryboard.professionalStoryboard())
                        }
                        else {
                            AlertManager.showAlert(inViewController: self, withTitle: "", message: "Incorrect Code")
                        }
                    }
                })
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        professionalPresentor = ProfessionalPresentor.init(withDelegate: self)
        registerForEvents ()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        codeTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
