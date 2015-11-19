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
    var servicesForEmployee: [Service]?

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
        var totalExpectedTime: Float = 0.0
        var totalActualTime: Float = 0.0
        
        servicesForEmployee = serviceOps.getAllServicesForEmployee(employee)
        
        
        if let services = servicesForEmployee
        {
            let totalServices: Int = services.count
            var servicesCompleted: Int = 0
            
            for item in services
            {
                if item.isFinished
                {
                    // Calculate employee's tardiness
                    let timeToFinish = item.timeToFinish
                    
                    let expectedTime = Float(item.serviceTimer.timerLengthInMinutes)
                    
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
        
        if employeeStatus != nil
        {
            cell?.employeePercentCompleteLabel.text = "\(Int(employeeStatus!.employeePercentComplete * 100))% Complete"
        
            cell?.employeeSimpleStatusLabel.text = "\(employeeStatus!.employeeSimpleStatus)"
        }
        else
        {
            cell?.employeePercentCompleteLabel.text = "0% Complete"
            cell?.employeeSimpleStatusLabel.text = "Unknown"
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("viewEmployeeProgressSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewEmployeeProgressSegue"
        {
            if let destination = segue.destinationViewController as? EmployeeProgressViewTableViewController
            {
                destination.employee = allEmployees![tableView.indexPathForSelectedRow!.row]
                destination.servicesForEmployee = servicesForEmployee
            }
        }
    }
    

}
