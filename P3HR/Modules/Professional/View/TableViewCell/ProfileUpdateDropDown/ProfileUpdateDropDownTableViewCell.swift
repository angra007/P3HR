//
//  ProfileUpdateDropDownTableViewCell.swift
//  P3HR
//
//  Created by Ankit Angra on 07/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class ProfileUpdateDropDownTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var dropDownTextField: P3HRDropDownTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
