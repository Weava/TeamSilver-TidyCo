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
    
    @NSManaged var dateTimeAssigned: NSDate
    @NSManaged var dateTimeStarted: NSDate
    @NSManaged var dateTimeFinished: NSDate
    @NSManaged var employeeNotes: String
    @NSManaged var employeeImages: [PFFile]
    @NSManaged var isFinished: Bool
    
    var roomServiced: Room {
        get
        {
            return self[Service.ROOM_SERVICED_RELATION] as! Room
        }
        set(room)
        {
            self[Service.ROOM_SERVICED_RELATION] = room
        }
    }
    
    var employeeAssigned: Employee {
        get
        {
            return self[Service.EMPLOYEE_ASSIGNED_RELATION] as! Employee
        }
        set(employee)
        {
            self[Service.EMPLOYEE_ASSIGNED_RELATION] = employee
        }
    }
    
    var serviceType: ServiceType {
        get
        {
            return self[Service.SERVICE_TYPE_RELATION] as! ServiceType
        }
        set(serviceType)
        {
            self[Service.SERVICE_TYPE_RELATION] = serviceType
        }
    }
    
    var serviceTimer: Timer {
        get
        {
            return self[Service.TIMER_RELATION] as! Timer
        }
        set(timer)
        {
            self[Service.TIMER_RELATION] = timer
        }
    }
    
    var timeToFinish: Float {
        get
        {
            let timeDifference = self.dateTimeFinished.timeIntervalSinceDate(self.dateTimeStarted)
            let timeDiffFloat = Float(timeDifference) / 60.0
            return timeDiffFloat
        }
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
        return "Service"
    }
}