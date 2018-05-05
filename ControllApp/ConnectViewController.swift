//
//  ConnectViewController.swift
//  ControllApp
//
//  Created by Johan Hjalmarsson on 2018-04-18.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

import UIKit
import CocoaMQTT

class ConnectViewController: UIViewController, CocoaMQTTDelegate {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RaspberryCom.setDelegate(delegate: self)
        indicator.isHidden = true
        connectButton.layer.cornerRadius = 20.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // To try app without connection to Raspberry, comment out waitForResponse() and RaspberryCom.connectToPi() and uncomment segueToMain()
    @IBAction func buttonClicked(_ sender: Any) {
        waitForResponse(status: true)
        RaspberryCom.connectToPi()
        //segueToMain()
    }
    
    // Function called when response from Raspberry. Then change UI accordingly
    func waitForResponse(status: Bool) {
        connectButton.isHidden = status
        indicator.isHidden = !status
        if status {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }
    
    // Segues to main
    func segueToMain() {
            waitForResponse(status: false)
            self.performSegue(withIdentifier: "toMain", sender: self)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        RaspberryCom.subscribe()
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        segueToMain()
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {}
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {}
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {}
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {}
    func mqttDidPing(_ mqtt: CocoaMQTT) {}
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {}
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {}

}
