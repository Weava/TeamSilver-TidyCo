//
//  ParseRoomStorageAdapter.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/15/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class ParseFloorStorageAdapter : FloorStorageAdapter
{
    func getAllFloors() -> [Floor]?
    {
        let query: PFQuery = Floor.query()!
        query.includeKey(Floor.ROOM_ARRAY)
        
        do
        {
            return try query.findObjects() as? [Floor]
        } catch
        {
            return nil
        }
    }
    
    func getAllRooms() -> [Room]?
    {
        let query: PFQuery = Room.query()!
        
        do
        {
            return try query.findObjects() as? [Room]
        } catch
        {
            return nil
        }
    }
    
    func createFloor(floor: Floor)
    {
        floor.saveInBackground()
    }
    
    func addRoomsToFloor(floor: Floor, rooms: [Room])
    {
        var roomsForFloor = floor[Floor.ROOM_ARRAY] as! [Room]
        roomsForFloor.appendContentsOf(rooms)
        floor[Floor.ROOM_ARRAY] = roomsForFloor
        floor.saveInBackground()
    }
}