//
//  PatientAttachmentViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 26/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class PatientAttachmentViewController: ParentViewController, PatientPresentorDelegate {

    var url : URL?
    var patientPresentor : PatientPresentor!
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        patientPresentor = PatientPresentor.init ()
        patientPresentor.delegate = self
        if let url = url {
            patientPresentor.download(withURL: url) { [unowned self] (resourceURL, error) in
                let request = URLRequest.init(url: resourceURL!)
                self.webView.loadRequest(request)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
