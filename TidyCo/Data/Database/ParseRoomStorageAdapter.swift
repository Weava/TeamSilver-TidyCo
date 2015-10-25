//
//  ParseRoomStorageAdapter.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/15/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class ParseRoomStorageAdapter : RoomStorageAdapter
{
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
    
    func createRoom(room: Room)
    {
        room.saveInBackground()
    }
}