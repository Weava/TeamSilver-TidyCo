//
//  ViewProgressTableViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

struct EmployeeStatus {
    var employeeSimpleStatus: String
    var employeePercentComplete: Float
}

class ViewProgressTableViewController: UITableViewController {
    
    let employeeOps = ParseEmployeeStorageAdapter()
    let serviceOps = ParseServiceStorageAdapter()
    
    var allEmployees: [Employee]?

    override func viewDidLoad() {
        super.viewDidLoad()
        allEmployees = employeeOps.getAllItems()!
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
        return (allEmployees?.count)!
    }
    
    private func getEmployeeProgress(employee: Employee) -> EmployeeStatus?
    {
        var totalExpectedTime: Int = 0
        var totalActualTime: Int = 0
        
        let employeeServices = serviceOps.getAllServicesForEmployee(employee)
        
        
        if let services = employeeServices
        {
            let totalServices: Int = services.count
            var servicesCompleted: Int = 0
            
            for var item in services
            {
                if item.isFinished
                {
                    // Calculate employee's tardiness
                    let timeToFinish = item.timeToFinishInMinutes
                    
                    let expectedTime = item.serviceTimer.timerLengthInMinutes
                    
                    totalExpectedTime += expectedTime
                    totalActualTime += timeToFinish
            
                    servicesCompleted++
                }
            }
            
            var status: String = ""
            let percentComplete: Float = Float(servicesCompleted) / Float(totalServices)
            
            switch (totalActualTime)
            {
                case let x where x < totalExpectedTime:
                    status = "Ahead"
                    break
                
                case let x where x == totalExpectedTime:
                    status = "On Time"
                    break
                
                case let x where x > totalExpectedTime:
                    status = "Over Time"
                    break
                
                default:
                    break
            }
            
            return EmployeeStatus(employeeSimpleStatus: status, employeePercentComplete: percentComplete)
        }
        return nil
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("employeeProgressCell") as? EmployeeProgressTableViewCell
        
        if cell == nil
        {
            let nibs = NSBundle.mainBundle().loadNibNamed("EmployeeProgressCell", owner: self, options: nil)
            cell = (nibs[0] as? EmployeeProgressTableViewCell)!
        }
        
        // Configure the cell...
        let currentEmployee = allEmployees![indexPath.row]
        
        let employeeStatus = self.getEmployeeProgress(currentEmployee)
        
        cell?.employeeNameLabel.text = "\(currentEmployee.lastName.uppercaseString), \(currentEmployee.firstName)"
        
        cell?.employeePercentCompleteLabel.text = "\(Int(employeeStatus!.employeePercentComplete * 100))% Complete"
        
        cell?.employeeSimpleStatusLabel.text = "\(employeeStatus!.employeeSimpleStatus)"

        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
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
