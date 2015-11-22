//
//  EmployeeRoomTableViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

protocol CurrentServiceHandler {
    
    func onDoNotDisturbClicked(service: Service)
    
    func onAddNotesClicked(service: Service)
}

class EmployeeRoomTableViewController: UITableViewController, CurrentServiceHandler {
    
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
        
        if cellService.objectForKey("dateTimeStarted") as? NSDate != nil
            && cellService.objectForKey("dateTimeFinished") as? NSDate == nil
        {
            print("Current cell creating")
            
            var currentServiceCell = tableView.dequeueReusableCellWithIdentifier("employeeCurrentServiceCell") as? EmployeeCurrentServiceTableViewCell
            
            if currentServiceCell == nil
            {
                let nibs = NSBundle.mainBundle().loadNibNamed("EmployeeCurrentServiceCell", owner: self, options: nil)
                currentServiceCell = (nibs[0] as? EmployeeCurrentServiceTableViewCell)!
            }
            
            currentServiceCell?.currentServiceHandler = self
            currentServiceCell?.serviceForCell = cellService
            
            let time = Float(cellService.timeTaken) / 60
            
            currentServiceCell?.roomNumberLabel.text = cellService.roomServiced.roomNum
            
            currentServiceCell?.currentTimeLabel.text = cellService.timeAsMinutesSecondsString
            
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
            
            currentServiceCell?.statusLabel.text = statusString
            
            servicingRoom = true
            
            return currentServiceCell!
        }
        else if cellService.objectForKey("dateTimeStarted") as? NSDate == nil
        {
            var upcomingServiceCell = tableView.dequeueReusableCellWithIdentifier("employeeUpcomingServiceCell") as? EmployeeUpcomingServiceTableViewCell
            
            if upcomingServiceCell == nil
            {
                let nibs = NSBundle.mainBundle().loadNibNamed("EmployeeUpcomingServiceCell", owner: self, options: nil)
                upcomingServiceCell = (nibs[0] as? EmployeeUpcomingServiceTableViewCell)!
            }
            
            upcomingServiceCell?.roomNumberLabel.text = cellService.roomServiced.roomNum
            upcomingServiceCell?.expectedTimeLabel.text = String(format: "%.2f", Float(cellService.serviceTimer.timerLengthInMinutes)).stringByReplacingOccurrencesOfString(".", withString: ":")
            
            if servicingRoom
            {
                upcomingServiceCell?.userInteractionEnabled = false
                upcomingServiceCell?.selectionStyle = .None
            }
            
            return upcomingServiceCell!
        }
        else
        {
            //var cell = tableView.dequeueReusableCellWithIdentifier("employeeUpcomingServiceCell") as? EmployeeUpcomingServiceTableViewCell
            
            var cell: EmployeeUpcomingServiceTableViewCell?
            
            if cell == nil
            {
                let nibs = NSBundle.mainBundle().loadNibNamed("EmployeeUpcomingServiceCell", owner: self, options: nil)
                cell = (nibs[0] as? EmployeeUpcomingServiceTableViewCell)!
            }
            
            cell?.roomNumberLabel.text = cellService.roomServiced.roomNum
            cell?.expectedTimeLabel.text = "Finished"
            
            cell?.userInteractionEnabled = false
            cell?.selectionStyle = .None
            
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
                
                self.servicesForEmployee![indexPath.row].dateTimeStarted = NSDate()
                self.servicesForEmployee![indexPath.row].saveInBackground()
                self.servicingRoom = true
                self.tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) in
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Finish Room", message: "Finished servicing room?", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) in
                
                self.servicesForEmployee![indexPath.row].dateTimeFinished = NSDate()
                self.servicesForEmployee![indexPath.row].saveInBackground()
                self.servicingRoom = true
                self.tableView.reloadData()
                
                self.servicingRoom = false
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) in
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func finishService(service: Service)
    {
        service.dateTimeFinished = NSDate()
        do
        {
            try service.save()
        } catch
        {
            print("Could not save")
        }
        
        self.servicesForEmployee = serviceOps.getAllServicesForEmployee(self.employee!)
    }
    
    func onDoNotDisturbClicked(service: Service)
    {
        let alert = UIAlertController(title: "Do Not Disturb", message: "Room has do not disturb sign?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) in
            
            service.roomServiced.doNotDisturb = true
            self.finishService(service)
            self.servicingRoom = false
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {
            (alert: UIAlertAction!) in
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func onAddNotesClicked(service: Service)
    {
        print("ADD NOTES CLICKED")
        //Segue to add notes view
    }


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let cellService = self.servicesForEmployee![indexPath.row]
        
        if cellService.objectForKey("dateTimeStarted") as? NSDate != nil
            && cellService.objectForKey("dateTimeFinished") as? NSDate == nil
        {
            return 90
        }
        else
        {
            return 40
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
