//
//  EditWorkforceTableViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class EditWorkforceTableViewController: UITableViewController {
    
    let employeeOps = ParseEmployeeStorageAdapter()
    let serviceOps = ParseServiceStorageAdapter()
    var selectedRowIndex : Int = -1;
    var headerHeight : CGFloat = 50
    
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

    // Return each Section name.
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("editWorkforceCell") as? EditWorkforceTableViewCell
        
        if cell == nil
        {
            let nibs = NSBundle.mainBundle().loadNibNamed("EditWorkforceView", owner: self, options: nil)
            cell = (nibs[0] as? EditWorkforceTableViewCell)!
        }
        
        // Configure the cell...
        let currentEmployee = allEmployees![indexPath.row]
        
        //let employeeStatus = self.getEmployeeProgress(currentEmployee)
        
        cell?.EmployeeName.text = "\(currentEmployee.lastName.uppercaseString), \(currentEmployee.firstName)"
        
       // cell?.employeePercentCompleteLabel.text = "\(Int(employeeStatus!.employeePercentComplete * 100))% Complete"
        
       // cell?.employeeSimpleStatusLabel.text = "\(employeeStatus!.employeeSimpleStatus)"
        
        return cell!
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == selectedRowIndex && selectedRowIndex != -1{
            return 100
        }
        return 44
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let customView = NSBundle.mainBundle().loadNibNamed("EditWorkforceHeaderView", owner: self, options: nil).first as? UIView
        
        
        if let fr : CGRect = customView?.frame{
            
            headerHeight = fr.height
          
        }
   
        return customView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return headerHeight
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if selectedRowIndex != indexPath.row {
            
            // paint the last cell tapped to white again
            self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: self.selectedRowIndex, inSection: 0))?.backgroundColor = UIColor.whiteColor()
            
            // save the selected index
            self.selectedRowIndex = indexPath.row
            
            // paint the selected cell to gray
            self.tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.grayColor()
            
            // update the height for all the cells
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            //self.tableView.reloadData()
        }else
        {
            selectedRowIndex = -1
            // update the height for all the cells
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            
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
