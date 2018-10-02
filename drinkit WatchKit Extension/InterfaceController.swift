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
        
        WCSession.default.delegate = self
        WCSession.default.activate()
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        percentageLabel.setText("\(InterfaceController.total)/2000")
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
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        InterfaceController.total = message["total"] as! Int
        percentageLabel.setText("\(InterfaceController.total)/2000")
    }
    
}
