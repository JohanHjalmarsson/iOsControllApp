//
//  MainViewController.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit
import CocoaMQTT

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CocoaMQTTDelegate  {
  
    @IBOutlet weak var settingPicker: UIPickerView!
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var buttons : [UIButton] = []
    var pickerData : [[String]] = []
    var chosenSetting : String = ""
    var currentHeight : Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingPicker.delegate = self
        settingPicker.dataSource = self
        RaspberryCom.setDelegate(delegate: self)
        pickerData.append(CoreDataHandler.getSettingStringArray())
        buttons = [goButton, upButton, downButton, stopButton]
        buttonRadius(b: buttons)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        pickerData.removeAll()
        pickerData.append(CoreDataHandler.getSettingStringArray())
        settingPicker.reloadAllComponents()
    }
    
    // Change the corner radius of chosen buttons
    func buttonRadius(b: [UIButton]) {
        for button in b {
            button.layer.cornerRadius = 20.0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attString = NSAttributedString(string: pickerData[component][row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        return attString
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerData[component].count > 0 {
            chosenSetting = pickerData[component][row]
        }
        
    }
    
    // Uses variable chosenSetting to get the height of that setting and then make request to Raspberry Pi
    func goToSetting() {
        if chosenSetting != "" {
            RaspberryCom.deskToPosition(CoreDataHandler.getHeightFromSettingName(name:chosenSetting))
        } else {
            if pickerData[0].count > 0 {
                chosenSetting = pickerData[0][0]
                RaspberryCom.deskToPosition(CoreDataHandler.getHeightFromSettingName(name:chosenSetting))
            } else {
                print("No setting")
            }
        }
    }
    
    // Updates the position label with currenHeight
    func updatePositionLabel() {
        positionLabel.text = "Position: \(currentHeight) cm"
    }

    // Updates currentHeight from String
    func updateCurrentHeight(message: String?) {
        if let currentString = message {
            let doubleString:Double? = Double(currentString)
            if let height = doubleString {
                currentHeight = height
            } else {
                print("Message is not a number")
            }
        }
    }
    
    @IBAction func goToSettingButtonClicked(_ sender: Any) {
        goToSetting()
    }
    
    @IBAction func upButtonClicked(_ sender: Any) {
        RaspberryCom.deskUp()
    }
    
    @IBAction func downButtonClicked(_ sender: Any) {
        RaspberryCom.deskDown()
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        RaspberryCom.deskStop()
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {}
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {}
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {}
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        self.updateCurrentHeight(message: message.string)
        self.updatePositionLabel()
    }
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {}
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {}
    func mqttDidPing(_ mqtt: CocoaMQTT) {}
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {}
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
