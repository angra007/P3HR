//
//  PatientRecordViewController.swift
//  P3HR
//
//  Created by Ankit Angra on 12/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class PatientRecordViewController: ParentViewController, PatientPresentorDelegate {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = Styles.color(forKey: .appBackgroundColor)
            tableView.register(RecordTableViewCell.self)
        }
    }
    
    private var data : Records?
    
    fileprivate var patientPresentor : PatientPresentor = PatientPresentor ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        patientPresentor.delegate = self
        
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        tableView.tableFooterView = view
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        patientPresentor.getRecords {  [weak self](records, error) in
            self?.data = records
            self?.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        self.push(withIdentifier: .patientNewRecord, fromStoryboard: UIStoryboard.patientStoryboard())
    }
}

extension PatientRecordViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let data = self.data {
            return data.records.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RecordTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
        
        let item = data!.records [indexPath.section]
        cell.nameLabel.text = item.name
        cell.descriptionLabel.text = item.desc
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





