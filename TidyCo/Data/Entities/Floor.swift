//
//  Floor.swift
//  TidyCo
//
//  Created by Aaron Weaver on 11/12/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class Floor: PFObject, PFSubclassing
{
    static let ROOM_ARRAY: String = "floorRooms"
    
    @NSManaged var floorNum: String
    
    var floorRooms: [Room] {
        get
        {
            return self[Floor.ROOM_ARRAY] as! [Room]
        }
        set(rooms)
        {
            self[Floor.ROOM_ARRAY] = rooms
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
        return "Floor"
    }
}