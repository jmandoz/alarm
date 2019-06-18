//
//  AlarmController.swift
//  Alarm
//
//  Created by Jason Mandozzi on 6/17/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation

class AlarmController {
    
    //Shared Instance
    static let shared = AlarmController()
    
    //Singleton
    var alarms: [Alarm] = []
    
    //Mock Data
    var mockAlarms: [Alarm] = 
    
    //Crud
    
    //Create
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
    }
    
    //Read
    
    //Update
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
    }
    
    //Delete
    func deleteAlarm(alarm: Alarm) {
        guard let indexToDelete = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: indexToDelete)
    }
}
