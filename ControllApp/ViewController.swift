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
    
    let mqttClient = CocoaMQTT(clientID: "iOS JH Controll App", host: "192.168.1.137", port: 1883)

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
    
    func connectToPi() {
        mqttClient.connect()
    }
    
    func disconnectFromPi() {
        mqttClient.disconnect()
    }
    
    @IBAction func sendData(_ sender: UISwitch) {
        if sender.isOn {
            mqttClient.publish("rpi/gpio", withString: "on")
        }
        else {
            mqttClient.publish("rpi/gpio", withString: "off")
        }
    }
    
    
    @IBAction func connectButton(_ sender: Any) {
        connectToPi()
    }
    
    @IBAction func disconnectButton(_ sender: Any) {
        disconnectFromPi()
    }
    
}

