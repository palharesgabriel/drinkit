//
//  QuantityInterfaceController.swift
//  drinkit WatchKit Extension
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import WatchKit
import Foundation


class QuantityInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    let data = ["200 ml", "300 ml" , "400 ml" , "500 ml", "600 ml", "700 ml"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        tableView.setNumberOfRows(data.count, withRowType: "TableRow")
        
        for i in 0..<tableView.numberOfRows{
            let rowController = tableView.rowController(at: i) as? RowController
            rowController?.lbl.setText(data[i])
            
        }
        // Configure interface objects here.
    }
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        //some code
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
