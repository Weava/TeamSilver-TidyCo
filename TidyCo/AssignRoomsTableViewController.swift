//
//  AssignRoomsTableViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class AssignRoomsTableViewController: UITableViewController {
    
    var headerHeight : CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let customView = NSBundle.mainBundle().loadNibNamed("AssignRoomsEmployeeHeader", owner: self, options: nil).first as? AssignRoomsEmployeeHeaderView
        
        customView?.addWorkerButton.addTarget(self, action: "AddWorker:", forControlEvents: UIControlEvents.TouchUpInside)
        
        customView?.editInfoButton.addTarget(self, action: "EditEmployee:", forControlEvents: UIControlEvents.TouchUpInside)
        
        customView?.deleteWorkerButton.addTarget(self, action: "DeleteEmployee:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        if let fr : CGRect = customView?.frame{
            
            headerHeight = fr.height
            
        }
        
        return customView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return headerHeight
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = self.title
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("assignRoomsCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.backgroundColor = UIColor(red: 219.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)

        return cell
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
