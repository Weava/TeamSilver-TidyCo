//
//  EditRoomsTableViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class EditRoomsTableViewController: UITableViewController {

    var floors = [Floor]()
    var headerHeight : CGFloat = 50
    var selectedRowIndexPath: NSIndexPath?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let adapter = ParseFloorStorageAdapter()
        
        floors = adapter.getAllFloors()!
        
        print(floors.count)

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
        return floors.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("floorCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "FLOOR " + floors[indexPath.row].floorNum

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRowIndexPath = indexPath
        performSegueWithIdentifier("roomListSegue", sender: self)
       
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header"
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let customView = NSBundle.mainBundle().loadNibNamed("EditFloorsHeaderView", owner: self, options: nil).first as? EditFloorsHeaderView
        customView?.addFloorButton.addTarget(self, action: "addFloor:", forControlEvents: UIControlEvents.TouchUpInside)
        customView?.editTimersButton.addTarget(self, action: "editTimers:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        if let fr : CGRect = customView?.frame{
            
            headerHeight = fr.height
            
        }
        
        return customView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return headerHeight
    }
    
    func addFloor(sender: UIButton!) {
        let alertController = UIAlertController(title: "Add Floor", message: "Enter floor number", preferredStyle: .Alert)
        
        
        let addAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            let floorNumberField = alertController.textFields![0] as UITextField
            
            if let _ = Int(floorNumberField.text!) {
                let newFloor = Floor()
                newFloor.floorRooms = [Room]()
                newFloor.floorNum = floorNumberField.text!
                
                let room = Room()
                room.roomNum = newFloor.floorNum + "01"
                room.doNotDisturb = false
                
                newFloor.floorRooms = [room]
                
                let adapter = ParseFloorStorageAdapter()
                    adapter.createFloor(newFloor)
                
                self.floors.append(newFloor)
                
                
                self.tableView.reloadData()
                
                
            }
            else {
                floorNumberField.text = ""
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Floor Number"
            
        }
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = self.title
    }
    
    func editTimers(sender: UIButton!) {
        print ("edit timers!")
        performSegueWithIdentifier("editTimersSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "roomListSegue" {
            if let destinationVC = segue.destinationViewController as? RoomsListTableViewController {
                destinationVC.floor = floors[selectedRowIndexPath!.row]
            }
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
