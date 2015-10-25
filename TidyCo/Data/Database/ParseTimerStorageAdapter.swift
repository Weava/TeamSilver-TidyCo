//
//  ParseTimerStorageAdapter.swift
//  TidyCo
//
//  Created by Aaron Weaver on 10/15/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//

import Foundation

class ParseTimerStorageAdapter : TimerStorageAdapter
{
    func getAllTimers() -> [Timer]?
    {
        let query: PFQuery = Timer.query()!
        
        do
        {
            return try query.findObjects() as? [Timer]
        } catch
        {
            return nil
        }
    }
    
    func createTimer(timer: Timer)
    {
        timer.saveInBackground()
    }
}