//
//  ParentViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 04/07/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Styles.color(forKey: .appBackgroundColor)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func present (withIdentifier identifier : UIStoryboard.StoryboardIdentifiers, fromStoryboard storyboard : UIStoryboard) {
        //let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
        //self.present(vc!, animated: true, completion: nil)
    }
    
    func push (withIdentifier identifier : UIStoryboard.StoryboardIdentifiers, fromStoryboard storyboard : UIStoryboard) {
        let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presetStroryboard (storyboard : UIStoryboard) {
        let vc = storyboard.instantiateInitialViewController()
        self.present(vc!, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
