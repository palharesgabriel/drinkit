//
//  InterfaceController.swift
//  drinkit WatchKit Extension
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchConnectivity
import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var percentageLabel: WKInterfaceLabel!
    static var total = 0
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
       
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        WCSession.default.delegate = self
        WCSession.default.activate()
        
        self.percentageLabel.setText("\(InterfaceController.total)/2000")
        
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func drinkBtnClicked() {
        
    }
    
    
}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        WCSession.default.sendMessage(["total" : true], replyHandler: { (response) in
            InterfaceController.total = response["total"] as! Int
            DispatchQueue.main.async {
                self.percentageLabel.setText("\(InterfaceController.total)/2000")
            }
        }, errorHandler: { (error) in
            print(error)
        })
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        InterfaceController.total = message["total"] as! Int
        DispatchQueue.main.async {
            self.percentageLabel.setText("\(InterfaceController.total)/2000")
        }
        
    }
    
}
