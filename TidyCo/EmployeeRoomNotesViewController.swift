//
//  EmployeeRoomNotesViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class EmployeeRoomNotesViewController: UIViewController {
    
    var employee: Employee?
    var service: Service?

    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var serviceNotesTextArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        employeeNameLabel.text = "\(employee!.lastName.uppercaseString), \(employee!.firstName)"
        roomNumberLabel.text = "\(service!.roomServiced.roomNum)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneEditingClicked(sender: UIBarButtonItem) {
        
        service?.employeeNotes = serviceNotesTextArea.text
        service?.saveInBackground()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
