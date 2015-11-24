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
        self.tableView!.backgroundColor = UIColor(red: 219.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    }

    override func viewDidAppear(animated: Bool) {
        
        print("ViewWillAppear")
        allEmployees = employeeOps.getAllItems()!
        self.tableView.reloadData()
        
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
        cell?.backgroundColor = UIColor(red: 219.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        
        var servicesForEmployee: [Service]?
        
        var overtimeCount = 0
        var aheadCount = 0
        var OnTimeCount = 0
        var behindCount = 0
        
        
        servicesForEmployee = serviceOps.getAllServicesForEmployee(currentEmployee)
        
        for data in servicesForEmployee!
        {
        
            let roomStatus: String = calculateRoomProgress(data)
            
            if roomStatus == "Over Time"
            {
                overtimeCount++
            }else if roomStatus == "Ahead"
            {
                aheadCount++
            }else if roomStatus == "On Time"
            {
                OnTimeCount++
            }else if roomStatus == ""
            {
                behindCount++
            }
            
            
            
            print(roomStatus)
            
        }
        
        var f : Float = 0.0
        
        if(servicesForEmployee?.count > 0)
        {
        
            f = (Float)((Float)(aheadCount)/(Float)((servicesForEmployee?.count)!))
            cell?.AheadOutlet.text = "\(f * 100)%"
            f = (Float)((Float)(OnTimeCount)/(Float)((servicesForEmployee?.count)!))
            cell?.OnTimeOutlet.text = "\(f * 100)%"
            f = (Float)((Float)(behindCount)/(Float)((servicesForEmployee?.count)!))
            cell?.BehindOutlet.text = "\(f * 100)%"
            f = (Float)((Float)(overtimeCount)/(Float)((servicesForEmployee?.count)!))
            cell?.OverTimeOutlet.text = "\(f * 100)%"
        }else
        {
            cell?.AheadOutlet.text = "N/A"
            cell?.OnTimeOutlet.text = "N/A"
            cell?.BehindOutlet.text = "N/A"
            cell?.OverTimeOutlet.text = "N/A"
        }
        
        return cell!
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == selectedRowIndex && selectedRowIndex != -1{
            return 100
        }
        return 44
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let customView = NSBundle.mainBundle().loadNibNamed("EditWorkforceHeaderView", owner: self, options: nil).first as? EditWorkforceHeaderViewClass
        
        customView?.AddWorkerOutlet.addTarget(self, action: "AddWorker:", forControlEvents: UIControlEvents.TouchUpInside)
        
        customView?.EditEmployeeOutlet.addTarget(self, action: "EditEmployee:", forControlEvents: UIControlEvents.TouchUpInside)
        
        customView?.DeleteWorkerOutlet.addTarget(self, action: "DeleteEmployee:", forControlEvents: UIControlEvents.TouchUpInside)

        
        if let fr : CGRect = customView?.frame{
            
            headerHeight = fr.height
          
        }
        
           
        return customView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return headerHeight
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = self.title
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if selectedRowIndex != indexPath.row {
            
            // paint the last cell tapped to white again
            self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: self.selectedRowIndex, inSection: 0))?.backgroundColor = UIColor.whiteColor()
            
            // save the selected index
            self.selectedRowIndex = indexPath.row
            
            // paint the selected cell to gray
            //self.tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.grayColor()
            
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
    
    func AddWorker(sender : UIButton!){
    
        performSegueWithIdentifier("addEmployeeSegue", sender: self)
        
    }
    
    func EditEmployee(sender : UIButton!){
        
        performSegueWithIdentifier("editEmployeeSegue", sender: self)
        
    }
    
    func DeleteEmployee(sender : UIButton!){
        
        performSegueWithIdentifier("deleteEmployeeSegue", sender: self)
        
    }
    

    @IBAction func addEmployee(segue:UIStoryboardSegue) {
    
        
        if let destViewController = segue.sourceViewController as? AddEmployeesViewController {
            
            let s1 = destViewController.firstName
            let s2 = destViewController.middleInitial
            let s3 = destViewController.lastName
            let s4 = destViewController.employeeId
            let s5 = destViewController.storeNumber
            let s6 = destViewController.loginId
            let s7 = destViewController.hashedPassword
            
            print(s1)
            print(s2)
            print(s3)
            print(s4)
            print(s5)
            print(s6)
            print(s7)
            
            let newEmp = Employee()
            let empType = EmployeeType()
            
            
            empType.typeName = "housekeeper"
            
            newEmp.firstName = s1
            newEmp.middleInitial = s2
            newEmp.lastName = s3
            newEmp.employeeId = s4
            newEmp.storeNumber = s5
            newEmp.loginId = s6
            newEmp.hashedPassword = s7
            
            newEmp.employeeType = empType
            
            
            let adapter = ParseEmployeeStorageAdapter()
            adapter.createEmployee(newEmp, employeeType: EmployeeTypeValue.housekeeper)
            
            self.viewDidLoad()
            
            self.tableView.reloadData()
            
            
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
