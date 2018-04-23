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
    
    var pickerData : [[String]] = []
    var chosenSetting : String = ""
    var currentHeight : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingPicker.delegate = self
        settingPicker.dataSource = self
        RaspberryCom.setDelegate(delegate: self)
        pickerData.append(CoreDataHandler.getSettingStringArray())
        currentHeight = CoreDataHandler.getGlobalStatusHeight()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenSetting = pickerData[component][row]
    }
    
    func goToSetting() {
        if chosenSetting != "" {
            RaspberryCom.deskToPosition(CoreDataHandler.getHeightFromSettingName(name:chosenSetting))
        } else {
            print("No setting chosen")
        }
    }
    
    func updatePositionLabel(position: Int) {
        positionLabel.text = "Position: \(position) %"
    }
    func updateCurrentHeight(message: String?) {
        if let currentString = message {
            let intString:Int? = Int(currentString)
            if let height = intString {
                currentHeight = height
            } else {
                print("Message is not an int")
            }
        }
    }
    
    func receivedMessageFromRpi(message: String?) {
        if let theMessage = message {
            if !theMessage.isEmpty {
                if let intMessage = Int(theMessage) {
                    updatePositionLabel(position: intMessage)
                }
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
        CoreDataHandler.saveGlobalStatus(height: Int16(currentHeight))
        
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {}
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {}
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {}
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        self.receivedMessageFromRpi(message: message.string)
        self.updateCurrentHeight(message: message.string)
    }
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {}
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {}
    func mqttDidPing(_ mqtt: CocoaMQTT) {}
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {}
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
