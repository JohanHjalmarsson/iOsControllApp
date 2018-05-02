//
//  PreferencesViewController.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var settingPicker: UIPickerView!
    var settingList : [[String]] = []
    var chosenSetting : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingList.append(CoreDataHandler.getSettingStringArray())
        settingPicker.delegate = self
        settingPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return settingList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingList[component].count
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attString = NSAttributedString(string: settingList[component][row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        return attString
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if settingList[component].count > 0 {
            chosenSetting = settingList[component][row]
        }
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if chosenSetting != "" {
            CoreDataHandler.deleteSetting(name: chosenSetting)
            settingList.removeAll()
            settingList.append(CoreDataHandler.getSettingStringArray())
            chosenSetting = ""
            settingPicker.reloadAllComponents()
            
        }
    }
  

}
