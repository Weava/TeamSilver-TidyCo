//
//  EmployeeType.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/13/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

enum EmployeeTypeValue: String
{
    case admin = "admin"
    case manager = "manager"
    case housekeeper = "housekeeper"
    case maintenance = "maintenance"
}

class EmployeeType: PFObject, PFSubclassing
{
    @NSManaged var typeNum: Int
    @NSManaged var typeName: String
    
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
    
    static func getEmployeeTypeValue(employeeType: EmployeeType) -> EmployeeTypeValue?
    {
        switch employeeType.typeName
        {
            case EmployeeTypeValue.admin.rawValue:
                return EmployeeTypeValue.admin
            case EmployeeTypeValue.manager.rawValue:
                return EmployeeTypeValue.manager
            case EmployeeTypeValue.housekeeper.rawValue:
                return EmployeeTypeValue.housekeeper
            case EmployeeTypeValue.maintenance.rawValue:
                return EmployeeTypeValue.maintenance
            default:
                return nil
        }
    }
}