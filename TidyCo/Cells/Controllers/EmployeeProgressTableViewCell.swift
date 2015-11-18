//
//  EmployeeProgressTableViewCell.swift
//  TidyCo
//
//  Created by Aaron Weaver on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class EmployeeProgressTableViewCell: UITableViewCell
{
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeSimpleStatusLabel: UILabel!
    @IBOutlet weak var employeePercentCompleteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
