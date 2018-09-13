//
//  PatientEditPermissionViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 26/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class PatientEditPermissionViewController: ParentViewController {

    @IBOutlet weak var backButton: P3HRButton!
    
    @IBOutlet weak var searchButton: P3HRButton!
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpSearchBar()
        patientPermissionPresentor = PatientPremissionPresentor (withDelegate: self)
        
        
        backButton.touchUpInside() { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        searchButton.touchUpInside() { [unowned self] in
            if let text = self.searchTextField.text {
                self.patientPermissionPresentor.filter(withQuery: text)
            }
        }
        
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        tableView.tableFooterView = view
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(HealthProfessionalTableViewCell.self)
            tableView.backgroundColor = Styles.color(forKey: .appBackgroundColor)
        }
    }
    
    var patientPermissionPresentor : PatientPremissionPresentor!
    
    var searchController : UISearchController!
    var searchResultController : PatientSearchResultViewController!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}




extension PatientEditPermissionViewController : PatientPremissionDelegate {
    func didReceiveData () {
        self.tableView.reloadData()
    }
    
    func didReceiveError ( _ error : Error) {
        AlertManager.showAlert(inViewController: self, withTitle: "", message: error.localizedDescription)
    }
}

extension PatientEditPermissionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return patientPermissionPresentor.numberOfItems ()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HealthProfessionalTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
        cell.bind(withHealthProfessional: patientPermissionPresentor.item(atIndex: indexPath.section))
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


extension PatientEditPermissionViewController : PatientSearchResultDelegate {
    func tableViewDidSet() {
        
    }
}

extension PatientEditPermissionViewController : UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text!
        patientPermissionPresentor.filter(withQuery: text)
    }
}


