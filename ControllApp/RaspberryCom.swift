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
    static let mqttDelegate = RaspberryComDelegate()
    static let publishTopic : String = "ios_to_rasp"
    static let subscribeTopic : String = "rasp_to_ios"
    
    static let upMessage : String = "deskUp"
    static let downMessage : String = "deskDown"
    static let stopMessage : String = "deskStop"
    
    
    // TODO: checks for connection status before publish
    // Publish a message to MQTT Broker
    class func deskUp() {
        mqttClient.publish(publishTopic, withString: upMessage)
    }
    // Publish a message to MQTT Broker
    class func deskDown() {
        mqttClient.publish(publishTopic, withString: downMessage)
    }
    // Publish a message to MQTT Broker
    class func deskStop() {
        mqttClient.publish(publishTopic, withString: stopMessage)
    }
    // Publish a message to MQTT Broker
    class func deskToPosition(_ position: Int) {
        mqttClient.publish(publishTopic, withString: String(position))
    }
    
    // Connect to the MQTT Broker
    class func connectToPi() -> Bool {
        mqttClient.delegate = mqttDelegate
        let b =  mqttClient.connect()
        
        return b
    }
    // Disconnect from the MQTT Broker
    class func disconnectFromPi() {
        mqttClient.disconnect()
    }
    
    // Subscribe to MQTT topic
    class func sub() {
        mqttClient.subscribe(subscribeTopic)
    }
    
    
}