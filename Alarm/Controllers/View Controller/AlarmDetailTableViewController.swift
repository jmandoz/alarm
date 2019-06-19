//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Jason Mandozzi on 6/17/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var alarmButton: UIButton!
    
    var alarmLandingPad: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func updateViews() {
        guard let alarm = alarmLandingPad else {return}
        datePicker.date = alarm.fireDate
        alarmNameTextField.text = alarm.name
        alarmIsOn = alarm.enabled
    }
    
    var alarmIsOn: Bool = true
    
    func setUpAlarmButton() {
        switch alarmIsOn {
        case true:
            alarmButton.backgroundColor = UIColor.green
            alarmButton.setTitle("Enabled", for: .normal)
        case false:
            alarmButton.backgroundColor = UIColor.red
            alarmButton.setTitle("Disabled", for: .normal)
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let alarmName = alarmNameTextField.text else {return}
        if let alarm = alarmLandingPad {
            AlarmController.shared.updateAlarm(alarm: alarm, fireDate: datePicker.date, name: alarmName, enabled: alarmIsOn)
        } else {
            AlarmController.shared.addAlarm(fireDate: datePicker.date, name: alarmName, enabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn = !alarmIsOn
        setUpAlarmButton()
    }
}
