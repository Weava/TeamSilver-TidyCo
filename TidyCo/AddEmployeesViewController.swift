//
//  AddEmployeesViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class AddEmployeesViewController: UIViewController {
    
     var firstName = String()
     var middleInitial = String()
     var lastName = String()
     var employeeId = String()
     var storeNumber = String()
     var loginId = String()
     var hashedPassword = String()
    
    let employeeOps = ParseEmployeeStorageAdapter()
    let serviceOps = ParseServiceStorageAdapter()
    var selectedRowIndex : Int = -1;
    var headerHeight : CGFloat = 50
    var selectedEmployee = Employee()
    var selectedType = String()
    
    var allEmployees: [Employee]?
    
    @IBOutlet weak var AddFirstNameOutlet: UITextField!
    @IBOutlet weak var AddMiddleInitialOutlet: UITextField!
    @IBOutlet weak var AddLastNameOutlet: UITextField!
    @IBOutlet weak var AddEmployeeIDOutlet: UITextField!
    @IBOutlet weak var AddStoreNumberOutlet: UITextField!
    @IBOutlet weak var AddPasswordOutlet: UITextField!
    
    @IBAction func ChangeEmployeeTypeAction(sender: UISegmentedControl) {
        
        let x = sender.selectedSegmentIndex
        
        switch x{
            
        case 0 :
            selectedType = "admin"
            break
        case 1 :
            selectedType = "manager"
            break
        case 2 :
            selectedType = "housekeeper"
            break
        case 3 :
            selectedType = "maintenance"
            break
        default:
            selectedType = "admin"
            break
            
        }
        
        print(selectedType)
        
    }
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // EmployeeTypeOutlet.
        
        self.selectedType = "admin"
        
        allEmployees = employeeOps.getAllItems()!
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Temporary string passing default values.
        /// Replace with the values from the outlets.
        
        print(selectedType)
        
        firstName = AddFirstNameOutlet.text!
        middleInitial = AddMiddleInitialOutlet.text!
        lastName = AddLastNameOutlet.text!
        employeeId = AddEmployeeIDOutlet.text!
        storeNumber = AddStoreNumberOutlet.text!
        loginId = "LoginID"
        hashedPassword = AddPasswordOutlet.text!
        
    }
    
    
    

}
