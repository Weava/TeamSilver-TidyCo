//
//  EmployeeRoomsAssignedCell.swift
//  
//
//  Created by newmedio on 11/23/15.
//
//

import UIKit

class EmployeeRoomsAssignedCell: UITableViewCell {
    
    var isObserving = false;
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var addRooomsButton: UIButton!
    @IBOutlet weak var removeRoomsButton: UIButton!
    @IBOutlet weak var employeeAssignedRooms: UICollectionView!
    
    class var expandedHeight: CGFloat { get { return 200 } }
    class var defaultHeight: CGFloat  { get { return 44  } }
    
    func checkHeight() {
        employeeAssignedRooms.hidden = (frame.size.height < EmployeeRoomsAssignedCell.expandedHeight)
        addRooomsButton.hidden = (frame.size.height < EmployeeRoomsAssignedCell.expandedHeight)
        removeRoomsButton.hidden = (frame.size.height < EmployeeRoomsAssignedCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            isObserving = true;
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
