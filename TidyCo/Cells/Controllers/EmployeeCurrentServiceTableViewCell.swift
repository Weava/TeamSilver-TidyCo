//
//  EmployeeCurrentServiceTableViewCell.swift
//  TidyCo
//
//  Created by Aaron Weaver on 11/20/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class EmployeeCurrentServiceTableViewCell: UITableViewCell
{
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var currentServiceHandler: CurrentServiceHandler?
    var serviceForCell: Service?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func disturbButtonClicked(sender: UIButton) {
        
        currentServiceHandler?.onDoNotDisturbClicked(serviceForCell!)
    }
    
    @IBAction func addNotesButtonClicked(sender: UIButton) {
        
        currentServiceHandler?.onAddNotesClicked(serviceForCell!)
    }
    
    func startUpdatingTimer()
    {
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            target: self,
            selector: Selector("updateTimer:"),
            userInfo: nil,
            repeats: true)
    }
    
    func updateTimer(timer: NSTimer)
    {
        self.currentTimeLabel.text = self.serviceForCell!.timeAsMinutesSecondsString
        print("\(serviceForCell?.timeAsMinutesSecondsString) TIME")
    }
}