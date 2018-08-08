//
//  ProfessionalProfileUpdateViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 07/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

protocol ProfessionalProfileUpdateDelegate : class {
    func dismiss (viewController : ProfessionalProfileUpdateViewController)
}


class ProfessionalProfileUpdateViewController: ParentViewController {

    public var configurationDetails : ConfigurationDetails?
    
    
    struct Config {
        var title : String?
        var options = [String] ()
    }
    
    var datasource = [Config] ()
    
    
    fileprivate func buildConfigration () {
        
        let orgTitle = "Organization"
        var orgOpt = [String] ()
        for item in configurationDetails!.details!.organization {
            orgOpt.append(item.name!)
        }
        let orgConfig = Config.init(title: orgTitle, options: orgOpt)
        datasource.append(orgConfig)
        
        let healthTitle = "Health Professional"
        var healthOpt = [String] ()
        for item in configurationDetails!.details!.helthProfessionals {
            healthOpt.append(item.name!)
        }
        let healthConfig = Config.init(title: healthTitle, options: healthOpt)
        datasource.append(healthConfig)
        
        let departTitle = "Department"
        var departOpt = [String] ()
        for item in configurationDetails!.details!.departments {
            departOpt.append(item.name!)
        }
        let departConfig = Config.init(title: departTitle, options: departOpt)
        datasource.append(departConfig)
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ProfileUpdateDropDownTableViewCell.self)
        }
    }
    
    @IBAction func didTapDoneButton(_ sender: UIBarButtonItem) {
        self.delegate.dismiss(viewController: self)
    }
   
    weak var delegate : ProfessionalProfileUpdateDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildConfigration ()
        
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = view
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProfessionalProfileUpdateViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProfileUpdateDropDownTableViewCell  = tableView.dequeuResuableCell(forIndexPath: indexPath)
        let item = datasource [indexPath.row]
        cell.headingLabel.text = item.title
        cell.dropDownTextField.updateOptions(options: item.options)
        return cell
    }
    
    
}




