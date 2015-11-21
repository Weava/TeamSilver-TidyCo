//
//  DeleteEmployeeViewController.swift
//  TidyCo
//
//  Created by NUTALAPATI ROHIT  on 11/20/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//



import UIKit

class DeleteEmployeeViewController: UIViewController {
    
    
    
    let employeeOps = ParseEmployeeStorageAdapter()
    let serviceOps = ParseServiceStorageAdapter()
    var selectedRowIndex : Int = -1;
    var headerHeight : CGFloat = 50
    var selectedEmployee = Employee()
    
    @IBAction func deleteAction(sender: UIButton) {
        
        print(selectedEmployee.firstName);
        
        let alert = UIAlertController(title: "Deleting Employee : \(selectedEmployee.lastName.uppercaseString), \(selectedEmployee.firstName)", message: "Are you sure?", preferredStyle: .Alert)
        
        
        alert.addAction(UIAlertAction(title: "Yes", style: .Destructive, handler: {
            (alert:UIAlertAction!) in
            
            
            // Delete Employee
            let adapter = ParseEmployeeStorageAdapter()
            
            self.selectedEmployee.deleteInBackground()
            
            print("Deleted \(self.selectedEmployee.lastName.uppercaseString), \(self.selectedEmployee.firstName)")
            // Go back
            self.navigationController?.popViewControllerAnimated(true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .Destructive, handler: {
            (alert:UIAlertAction!) in
            
            
            // Dont Delete Employee
            print("Didnt delete")
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    var allEmployees: [Employee]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allEmployees = employeeOps.getAllItems()!
        
        selectedEmployee = allEmployees![0]
        

        
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
        
        print("Selected : \(name)")
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    
    
}