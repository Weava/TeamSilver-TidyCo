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
    var textColor: UIColor
}

class ViewProgressTableViewController: UITableViewController {
    
    let employeeOps = ParseEmployeeStorageAdapter()
    let serviceOps = ParseServiceStorageAdapter()
    
    var allEmployees: [Employee]?
    var servicesForEmployee: [Service]?

    override func viewDidLoad() {
        super.viewDidLoad()
        allEmployees = employeeOps.getAllMaintenanceAndHousekeepingEmployees()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //navigationBar.tintColor = UIColor(red: 47.0/255.0, green: 157.0/255.0, blue: 215.0/255.0, alpha: 1.0)
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
        return (allEmployees?.count)!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = self.title
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
                    let timeToFinish = Float(item.timeToFinish) / 60
                    
                    let expectedTime = Float(item.serviceTimer.timerLengthInMinutes)
                    
                    totalExpectedTime += expectedTime
                    totalActualTime += timeToFinish
            
                    servicesCompleted++
                }
            }
            
            var status: String = ""
            var color: UIColor?
            let percentComplete: Float = Float(servicesCompleted) / Float(totalServices)
            
            switch (totalActualTime)
            {
                case let x where x < totalExpectedTime:
                    status = "Ahead"
                    color = UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 65.0/255.0, alpha: 1.0)
                    break
                
                case let x where x == totalExpectedTime:
                    status = "On Time"
                    color = UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 65.0/255.0, alpha: 1.0)
                    break
                
                case let x where x > totalExpectedTime:
                    status = "Over Time"
                    color = UIColor(red: 39.0/255.0, green: 184.0/255.0, blue: 158.0/255.0, alpha: 1.0)
                    break
                
                default:
                    break
            }
            
            return EmployeeStatus(employeeSimpleStatus: status, employeePercentComplete: percentComplete, textColor: color!)
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
            cell?.employeeSimpleStatusLabel.textColor = employeeStatus!.textColor
        }
        else
        {
            cell?.employeePercentCompleteLabel.text = "0% Complete"
            cell?.employeeSimpleStatusLabel.text = "Unknown"
        }
        
        cell?.backgroundColor = UIColor(red: 219.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100
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
