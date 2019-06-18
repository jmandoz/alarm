//
//  Alarm.swift
//  Alarm
//
//  Created by Jason Mandozzi on 6/17/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

//git add .
//git commit -m "notes about the changes made"
//git push origin master
//git status 

import Foundation

class Alarm {
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    
    var fireTimeAsString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "en_US")
            let date = fireDate
            return (dateFormatter.string(from: date))
        }
    }
        
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
        
    }
}

extension Alarm: Equatable {
    static func == (lhs:Alarm, rhs:Alarm) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.fireDate == rhs.fireDate &&
            lhs.enabled == rhs.enabled &&
            lhs.uuid == rhs.uuid
    }
}
