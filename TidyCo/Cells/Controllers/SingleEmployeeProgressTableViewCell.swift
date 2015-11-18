//
//  SingleEmployeeProgressTableViewCell.swift
//  TidyCo
//
//  Created by Aaron Weaver on 11/18/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class SingleEmployeeProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var employeeStatusLabel: UILabel!
    @IBOutlet weak var employeeNotesImageView: UIImageView!
    @IBOutlet weak var timeDifferenceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
