//
//  EmployeeRoomTableViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class EmployeeRoomTableViewController: UITableViewController {
    
    let serviceOps = ParseServiceStorageAdapter()
    
    var employee: Employee?
    var servicesForEmployee: [Service]?
    var servicingRoom: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        servicesForEmployee = serviceOps.getAllServicesForEmployee(employee!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        let cellService = servicesForEmployee![indexPath.row]
        
        if let timeStarted = cellService.objectForKey("dateTimeStarted") as? NSDate
        {
            var cell = tableView.dequeueReusableCellWithIdentifier("employeeCurrentServiceCell") as? EmployeeCurrentServiceTableViewCell
            
            if cell == nil
            {
                let nibs = NSBundle.mainBundle().loadNibNamed("EmployeeCurrentServiceCell", owner: self, options: nil)
                cell = (nibs[0] as? EmployeeCurrentServiceTableViewCell)!
            }
            
            let time = cellService.timeTaken
            let timeTaken = String(format: "%.2f", time)
            
            cell?.roomNumberLabel.text = cellService.roomServiced.roomNum
            
            cell?.currentTimeLabel.text = timeTaken.stringByReplacingOccurrencesOfString(".", withString: ":")
            
            let expectedTime = Float(cellService.serviceTimer.timerLengthInMinutes)
            var statusString: String?
            
            switch (time)
            {
            case let x where x < expectedTime:
                statusString = "Ahead"
                
            case let x where x == expectedTime:
                statusString = "On Time"
                
            case let x where x > expectedTime:
                statusString = "Over Time"
                
            default:
                statusString = ""
            }
            
            cell?.statusLabel.text = statusString
            
            servicingRoom = true
            
            return cell!
        }
        else
        {
           var cell = tableView.dequeueReusableCellWithIdentifier("employeeUpcomingServiceCell") as? EmployeeUpcomingServiceTableViewCell
            
            if cell == nil
            {
                let nibs = NSBundle.mainBundle().loadNibNamed("EmployeeUpcomingServiceCell", owner: self, options: nil)
                cell = (nibs[0] as? EmployeeUpcomingServiceTableViewCell)!
            }
            
            cell?.roomNumberLabel.text = cellService.roomServiced.roomNum
            cell?.expectedTimeLabel.text = String(format: "$.2f", Float(cellService.serviceTimer.timerLengthInMinutes)).stringByReplacingOccurrencesOfString(".", withString: ":")
            
            if servicingRoom
            {
                cell?.userInteractionEnabled = false
                cell?.selectionStyle = .None
            }
            
            return cell!
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Ask to start room
        if !servicingRoom
        {
            // Ask to start room
            let alert = UIAlertController(title: "Start Room", message: "Start servicing room?", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) in
                
                self.servicingRoom = true
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) in
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Finish Room", message: "Finished servicing room??", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) in
                
                self.servicingRoom = false
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) in
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
