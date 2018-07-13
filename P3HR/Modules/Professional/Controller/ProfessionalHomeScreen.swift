//
//  ProfessionalHomeScreen.swift
//  P3HR
//
//  Created by Ankit Angra on 13/07/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit
import SideMenu

class ProfessionalHomeScreen: ParentViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(PaitentHomeCellTableViewCell.self)
        }
    }
    @IBAction func didTapMenuButton(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIStoryboard.professionalStoryboard().instantiateViewController(withIdentifier:UIStoryboard.StoryboardIdentifiers.professionalMenu.rawValue )
        let menuRightNavigationController = UISideMenuNavigationController(rootViewController: vc)
        menuRightNavigationController.isNavigationBarHidden = true
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
}

extension ProfessionalHomeScreen : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PaitentHomeCellTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 8 ))
        return view
    }
    
}
