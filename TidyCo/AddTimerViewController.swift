//
//  AddTimerViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/19/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class AddTimerViewController: UIViewController {

    var addedTimer: Timer?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBAction func addButtonTap(sender: AnyObject) {
        print(nameTextField.text!)
        print(Int(timerPicker.countDownDuration/60))
        
        if !nameTextField.text!.isEmpty {
            let newTimer = Timer()
            newTimer.timerName = nameTextField.text!
            newTimer.timerLengthInMinutes = Int(timerPicker.countDownDuration/60)
            newTimer.dateCreated = NSDate()
            ParseTimerStorageAdapter().createTimer(newTimer)
            
            addedTimer = newTimer
            
            performSegueWithIdentifier("timerListSegue", sender: self)
        }
        else {
            let alertController = UIAlertController(title: "Name Required", message: "Please enter a name for your timer.", preferredStyle: .Alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alertController.addAction(okayAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
