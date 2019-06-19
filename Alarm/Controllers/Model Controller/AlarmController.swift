//
//  AlarmController.swift
//  Alarm
//
//  Created by Jason Mandozzi on 6/17/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation

import UserNotifications

protocol AlarmScheduler: class {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}
class AlarmController: AlarmScheduler {
    
    //Shared Instance
    static let shared = AlarmController()
    
    //Singleton
    var alarms: [Alarm] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    //Crud
    
    //Create
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        newAlarm.enabled = enabled
        alarms.append(newAlarm)
        if newAlarm.enabled {
            scheduleUserNotifications(for: newAlarm)
        } else {
            cancelUserNotifications(for: newAlarm)
        }
        saveToPersistentStore()
    }
    
    //Read
    
    //Update
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        saveToPersistentStore()
    }
    
    //Delete
    func deleteAlarm(alarm: Alarm) {
        guard let indexToDelete = alarms.firstIndex(of: alarm) else {return}
        self.alarms.remove(at: indexToDelete)
        cancelUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistentStore()
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedAlarm = try jsonDecoder.decode([Alarm].self, from: data)
            alarms = decodedAlarm
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "Alarm.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
}


extension AlarmScheduler {
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    func scheduleUserNotifications(for alarm: Alarm) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "test"
        notificationContent.body = "Test Body"
        notificationContent.sound = .default
        
        let date = alarm.fireDate
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
}
