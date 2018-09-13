//
//  HealthProfessionalTableViewCell.swift
//  P3HR
//
//  Created by Ankit Angra on 11/09/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class HealthProfessionalTableViewCell: UITableViewCell, NibLoadableView {

    
    private var professional : HealthProfessional!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: P3HRLabel!
    @IBOutlet weak var emailLabel: P3HRLabel!
    @IBOutlet weak var healthProfessionalLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    func bind (withHealthProfessional healthProfessional : HealthProfessional) {
        self.professional = healthProfessional
        self.nameLabel.text = self.professional.firstName! + " " + self.professional.lastName!
        self.emailLabel.text = self.professional.email
        self.healthProfessionalLabel.text = self.professional.department
        self.locationLabel.text = self.professional.city
    }
    
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
