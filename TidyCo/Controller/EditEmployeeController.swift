//
//  EditEmployeeController.swift
//  TidyCo
//
//  Created by NUTALAPATI ROHIT  on 11/20/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//


import UIKit

class EditEmployeeController: UIViewController {
    
    
    
    let employeeOps = ParseEmployeeStorageAdapter()
    let serviceOps = ParseServiceStorageAdapter()
    var selectedRowIndex : Int = -1;
    var headerHeight : CGFloat = 50
    var selectedEmployee = Employee()
    
    @IBOutlet weak var firstNameOutlet: UITextField!
    
    @IBOutlet weak var middleInitialOutlet: UITextField!
    
    @IBOutlet weak var LastNameOutlet: UITextField!
    
    @IBOutlet weak var employeeIDOutlet: UITextField!
    
    @IBOutlet weak var storeNumberOutlet: UITextField!
   
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBOutlet weak var loginIDOutlet: UITextField!
    

    
    @IBAction func EditAction(sender: UIButton) {
        
        // Check if any edited first name middle name last name
        if firstNameOutlet.text != selectedEmployee.firstName || middleInitialOutlet!.text != selectedEmployee.middleInitial || LastNameOutlet!.text != selectedEmployee.lastName || employeeIDOutlet.text != selectedEmployee.employeeId || storeNumberOutlet.text != selectedEmployee.storeNumber || loginIDOutlet.text != selectedEmployee.loginId || selectedEmployee.hashedPassword != passwordOutlet.text
        {
            
            let s1 = firstNameOutlet.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let s2 = middleInitialOutlet.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let s3 = LastNameOutlet.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let s4 = employeeIDOutlet.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let s5 = storeNumberOutlet.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let s6 = loginIDOutlet.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let s7 = passwordOutlet.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            if s1 == "" || s2 == "" || s3 == "" || s4 == "" || s5 == "" || s6 == "" || s7 == ""  {
               // print("Null")
                
                let alert = UIAlertController(title: "Please fill all the fields!", message: "Empty fields present. Kindly fill all thge fields.", preferredStyle: .Alert)
                
                
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: {
                    (alert:UIAlertAction!) in
                    
                    
                    
                }))
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    super.presentViewController(alert, animated: true, completion: nil)
                }
                
                
                
            }else{
            
            let newEmp = Employee()
            
            newEmp.firstName = s1
            newEmp.middleInitial = s2
            newEmp.lastName = s3
            newEmp.employeeId = s4
            newEmp.storeNumber = s5
            newEmp.loginId = s6
            newEmp.hashedPassword = s7
            
            
            
            let et : EmployeeTypeValue = EmployeeTypeValue.admin
            
            let adapter = ParseEmployeeStorageAdapter()
            
            //     let str : String = newEmp.employeeType.typeName
            
            self.selectedEmployee.deleteInBackground()
            adapter.createEmployee(newEmp, employeeType: et)
            
            self.selectedEmployee.deleteInBackground()
           
           // print("Changed")
            
            ///Insert code to modify database accordingly
            
            // Go back
            navigationController?.popViewControllerAnimated(true)
            
        }
        
        }else
        {
         //   print("No change")
            navigationController?.popViewControllerAnimated(true)
            
        }
        
    }
    
    
    var allEmployees: [Employee]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         allEmployees = employeeOps.getAllItems()!
        self.view.backgroundColor = UIColor(red: 219.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        let currentEmployee = allEmployees![0]
        selectedEmployee = allEmployees![0]
        
        firstNameOutlet.text = currentEmployee.firstName
        middleInitialOutlet.text = currentEmployee.middleInitial
        LastNameOutlet.text = currentEmployee.lastName
        employeeIDOutlet.text = currentEmployee.employeeId
        storeNumberOutlet.text = currentEmployee.storeNumber
        passwordOutlet.text = currentEmployee.hashedPassword
        loginIDOutlet.text = currentEmployee.loginId
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allEmployees!.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        let currentEmployee = allEmployees![row]
        
        //let employeeStatus = self.getEmployeeProgress(currentEmployee)
        
        let name : String = "\(currentEmployee.lastName.uppercaseString), \(currentEmployee.firstName)"
        
        return name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        let currentEmployee = allEmployees![row]
        selectedEmployee = currentEmployee
        
        //let employeeStatus = self.getEmployeeProgress(currentEmployee)
        
        let name : String = "\(currentEmployee.lastName.uppercaseString), \(currentEmployee.firstName)"

        firstNameOutlet.text = currentEmployee.firstName
        middleInitialOutlet.text = currentEmployee.middleInitial
        LastNameOutlet.text = currentEmployee.lastName
        employeeIDOutlet.text = currentEmployee.employeeId
        storeNumberOutlet.text = currentEmployee.storeNumber
        passwordOutlet.text = currentEmployee.hashedPassword
        loginIDOutlet.text = currentEmployee.loginId

        
        
      
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    
    
}