//
//  EmployeeProgressViewTableViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

protocol SegueActivation
{
    func startSegue()
}

class EmployeeProgressViewTableViewController: UITableViewController {

    var employee: Employee?
    var servicesForEmployee: [Service]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loading single employee")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView!.backgroundColor = UIColor(red: 219.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (servicesForEmployee?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("singleEmployeeProgressCell") as? SingleEmployeeProgressTableViewCell
        
        if cell == nil
        {
            let nibs = NSBundle.mainBundle().loadNibNamed("SingleEmployeeRoomProgressCell", owner: self, options: nil)
            cell = (nibs[0] as? SingleEmployeeProgressTableViewCell)!
        }
        
        let serviceForCell = servicesForEmployee![indexPath.row]
        let serviceExpectedTime = NSString(format: "%.2f", Float(serviceForCell.serviceTimer.timerLengthInMinutes)).stringByReplacingOccurrencesOfString(".", withString: ":")
        let serviceActualTime = serviceForCell.timeAsMinutesSecondsString
        let roomStatus: String = calculateRoomProgress(serviceForCell)
        
        cell?.roomNumberLabel.text = serviceForCell.roomServiced.roomNum
        cell?.employeeStatusLabel.text = roomStatus
        
        if serviceForCell.employeeNotes != "" || serviceForCell.employeeImages.count > 0
        {
            // Set imageView here
            cell?.employeeNotesImageView.hidden = false
        }
        else
        {
            cell?.employeeNotesImageView.hidden = true
            cell?.selectionStyle = .None
            cell?.userInteractionEnabled = false
        }
        
        cell?.timeDifferenceLabel.text = "\(serviceActualTime)/\(serviceExpectedTime)"

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("managerViewRoomNotesSegue", sender: self)
    }

    private func calculateRoomProgress(service: Service) -> String
    {
        let timeDifference = Float(service.timeToFinish) / 60
        let expectedTime = Float(service.serviceTimer.timerLengthInMinutes)
        
        switch (timeDifference)
        {
            case let x where x < expectedTime:
                return "Ahead"
                
            case let x where x == expectedTime:
                return "On Time"
                
            case let x where x > expectedTime:
                return "Over Time"
                
            default:
                return ""
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "managerViewRoomNotesSegue"
        {
            if let destination = segue.destinationViewController as? RoomNotesViewController
            {
                destination.employee = employee
                destination.service = servicesForEmployee![(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }


}
