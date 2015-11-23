//
//  RoomNotesTableViewController.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/17/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit

class RoomNotesViewController: UIViewController {
    
    var employee: Employee?
    var service: Service?

    @IBOutlet weak var employeeNotesLabel: UILabel!
    @IBOutlet weak var employeeImagesImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeNotesLabel.lineBreakMode = .ByWordWrapping
        employeeNotesLabel.numberOfLines = 0
        
        if let employee = employee
        {
            self.title = "\(employee.lastName), \(employee.firstName)"
        }
        
        if let service = service
        {
            if service.employeeNotes != ""
            {
                employeeNotesLabel.text = service.employeeNotes
                employeeNotesLabel.sizeToFit()
            }
            if service.employeeImages.count > 0
            {
                service.employeeImages.first!.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    if let data = data where error == nil{
                        let image = UIImage(data: data)
                        self.employeeImagesImageView.image = image
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
