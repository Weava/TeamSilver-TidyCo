//
//  RoomStorageAdapter.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/15/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

protocol FloorStorageAdapter
{
    func getAllFloors() -> [Floor]?
    
    func createFloor(floor: Floor)
    
    func addRoomsToFloor(floor: Floor, rooms: [Room])
}