//
//  RaspberryCom.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import Foundation
import CocoaMQTT

class RaspberryCom {
    
     static let mqttClient = CocoaMQTT(clientID: "iOS JH Controll App", host: "192.168.1.137", port: 1883)
    
    class func connectToPi() {
        mqttClient.connect()
    }
    
    class func disconnectFromPi() {
        mqttClient.disconnect()
    }
    
    class func sendGPIO(_ status: Bool) {
        if status {
            mqttClient.publish("rpi/gpio", withString: "on")
        }
        else {
            mqttClient.publish("rpi/gpio", withString: "off")
        }
    }
    
}
