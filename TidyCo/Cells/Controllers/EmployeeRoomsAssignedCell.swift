//
//  EmployeeRoomsAssignedCell.swift
//  
//
//  Created by newmedio on 11/23/15.
//
//

import UIKit

class EmployeeRoomsAssignedCell: UITableViewCell {
    
    @IBOutlet weak var employeeNameLabel: UILabel!
    
    @IBOutlet weak var addRooomsButton: UIButton!
    
    @IBOutlet weak var removeRoomsButton: UIButton!
    
    @IBOutlet weak var employeeAssignedRooms: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
