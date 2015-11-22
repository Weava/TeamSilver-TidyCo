//
//  EditTimersTableViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class EditTimersTableViewController: UITableViewController {

    let adapter = ParseTimerStorageAdapter()
    
    var timers = [Timer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timers = adapter.getAllTimers()!

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
        return timers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("timerCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = timers[indexPath.row].timerName.uppercaseString
        
        let timerLength = timers[indexPath.row].timerLengthInMinutes
        let hours = timerLength / 60
        let minutes = timerLength - (hours * 60)
        
        var detailString = ""
        if hours != 0 {
            if hours < 10 {
                detailString += "0"
            }
            detailString += String(hours) + ":"
        }
        
        if minutes < 10 {
            detailString += "0"
        }
        detailString += String(minutes) + ":00"
        
        cell.detailTextLabel?.text = detailString
        
        cell.backgroundColor = UIColor(red: 219.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)

        return cell
    }
    
    
    @IBAction func unwindToTimerList(segue: UIStoryboardSegue) {
        let sourceVC = segue.sourceViewController as? AddTimerViewController
        timers.append((sourceVC?.addedTimer)!)
        self.tableView.reloadData()
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            timers[indexPath.row].deleteInBackground()
            timers.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
