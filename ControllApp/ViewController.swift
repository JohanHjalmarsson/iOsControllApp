//
//  ViewController.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-16.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit
import CocoaMQTT


class ViewController: UIViewController {
    
   

    var personList : [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CoreDataHandler.savePerson(name: "Johan")
//        personList = CoreDataHandler.getPersonList()!
//
//        for person in personList {
//            print(person.name)
//        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func sendData(_ sender: UISwitch) {
        
    }
    
    
    @IBAction func connectButton(_ sender: Any) {
        
    }
    
    @IBAction func disconnectButton(_ sender: Any) {
        
    }
    
}

