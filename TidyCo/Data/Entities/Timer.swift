//
//  Timer.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/13/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class Timer: PFObject, PFSubclassing
{
    @NSManaged var timerName: String
    @NSManaged var timerLengthInMinutes: Int
    @NSManaged var dateCreated: NSDate
    
    override class func initialize() {
        struct Static {
            static var onceToken: dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String {
        return "Timer"
    }
}