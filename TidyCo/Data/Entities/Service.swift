//
//  Service.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/13/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class Service: PFObject, PFSubclassing
{
    static let ROOM_SERVICED_RELATION: String = "roomServiced"
    static let EMPLOYEE_ASSIGNED_RELATION: String = "employeeAssigned"
    static let SERVICE_TYPE_RELATION: String = "serviceType"
    static let TIMER_RELATION: String = "serviceTimer"
    
    @NSManaged var timeToFinishInMinutes: Int
    @NSManaged var dateTimeAssigned: NSDate
    @NSManaged var dateTimeStarted: NSDate
    @NSManaged var dateTimeFinished: NSDate
    @NSManaged var employeeNotes: String
    @NSManaged var employeeImages: [PFFile]
    
    override class func initialize() {
        struct Static {
            static var onceToken: dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String {
        return "Service"
    }
}