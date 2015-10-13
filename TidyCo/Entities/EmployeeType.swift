//
//  EmployeeType.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/13/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class EmployeeType: PFObject, PFSubclassing
{
    @NSManaged var typeNum: Int
    @NSManaged var typeName: String
    
    enum EmployeeTypeValue: Int
    {
        case admin = 0
        case manager = 1
        case housekeeper = 2
        case maintenance = 3
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken: dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String {
        return "EmployeeType"
    }
}