//
//  EditWorkforceHeaderViewClass.swift
//  TidyCo
//
//  Created by NUTALAPATI ROHIT  on 11/18/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import UIKit
import Foundation

class EditWorkforceHeaderViewClass: UIView
{
    
    var buttonString = String()
    
    @IBAction func AE(sender: UIButton) {
        
             
        EditWorkforceTableViewController().bla(buttonString)
                
    }
    
    @IBAction func EE(sender: UIButton) {
    }
    
    @IBAction func DE(sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    
}