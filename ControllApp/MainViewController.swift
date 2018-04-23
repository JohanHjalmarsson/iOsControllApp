//
//  MainViewController.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    

    @IBOutlet weak var settingPicker: UIPickerView!
    @IBOutlet weak var positionLabel: UILabel!
    
    var pickerData : [[String]] = []
    var chosenSetting : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingPicker.delegate = self
        settingPicker.dataSource = self
        pickerData.append(CoreDataHandler.getSettingStringArray())
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
