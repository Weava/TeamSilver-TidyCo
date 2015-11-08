//
//  ServiceType.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/13/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

enum ServiceTypeValue: String
{
    case maintenance = "maintenance"
    case housekeeping = "housekeeping"
}

class ServiceType: PFObject, PFSubclassing
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
        return "ServiceType"
    }
    
    static func getServiceTypeValue(serviceType: ServiceType) -> ServiceTypeValue?
    {
        switch serviceType.typeName
        {
        case ServiceTypeValue.maintenance.rawValue:
            return ServiceTypeValue.maintenance
        case ServiceTypeValue.housekeeping.rawValue:
            return ServiceTypeValue.housekeeping
        default:
            return nil
        }
    }
}