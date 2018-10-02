//
//  QuantityInterfaceController.swift
//  drinkit WatchKit Extension
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class QuantityInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    let values = [200,300,400,500,600,700]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        WCSession.default.delegate = self
        WCSession.default.activate()
        tableView.setNumberOfRows(values.count, withRowType: "TableRow")
        
        for i in 0..<tableView.numberOfRows{
            let rowController = tableView.rowController(at: i) as? RowController
            rowController?.lbl.setText("\(values[i]) ml")
            
        }
        // Configure interface objects here.
    }
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        if (WCSession.default.isReachable) {
            // this is a meaningless message, but it's enough for our purposes
            let message = ["value": values[rowIndex]]
            WCSession.default.sendMessage(message, replyHandler: { (response) in
                let total = response["total"] as! Int
                InterfaceController.total = total
                self.dismiss()
            }, errorHandler: nil)
        }
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
extension QuantityInterfaceController: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
}
