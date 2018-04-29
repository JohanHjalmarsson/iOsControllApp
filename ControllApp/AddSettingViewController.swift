//
//  AddSettingViewController.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit

class AddSettingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var heightInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightInput.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func addSettingToCoreData() {
        if let name = nameInput.text, let height = heightInput.text {
            if !name.isEmpty && !height.isEmpty {
                if let doubleHeight = Double(height) {
                    CoreDataHandler.saveSetting(name: name, height: doubleHeight)
                } else {
                    print("Failed to convert String to Int16")
                }
            } else {
                print("Name or Height is empty")
            }
        } else {
            print("Failed to unwrap nameInput and/or heightInput")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        let allowedCharacters = CharacterSet.init(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        result = allowedCharacters.isSuperset(of: characterSet)
        
        //TODO: Set maximum input height. Or go back to %
        if let text = heightInput.text {
            if text.count > 3 {
                if string != "" {
                   result = false
                }
            }
        }
        return result
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        addSettingToCoreData()
        self.navigationController?.popViewController(animated: true)
    }
  

}
