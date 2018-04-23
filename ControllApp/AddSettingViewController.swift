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
                if let intHeight = Int16(height) {
                    CoreDataHandler.saveSetting(name: name, height: intHeight)
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
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        result = allowedCharacters.isSuperset(of: characterSet)
        
        if let text = heightInput.text {
            if text.count > 2 {
                if string != "" {
                   result = false
                }
            }
        }
        return result
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        addSettingToCoreData()
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
