//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Jason Mandozzi on 6/17/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    weak var cellDelegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm? {
        didSet {
            guard let alarm = alarm else {return}
            updateViews(alarm: alarm)
        }
    }
    
    func updateViews(alarm: Alarm) {
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBAction func switchValueChanged(_ sender: Any) {
    }
}
