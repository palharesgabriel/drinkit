//
//  ViewController.swift
//  drinkit
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drinkButton: UIButton! {
        didSet {
            drinkButton.layer.cornerRadius = 10
            drinkButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationHandler.shared.requestAuthorization { (wasAuthorized, err) in
            print("Was authorized?: \(wasAuthorized)")
            if wasAuthorized {
                self.scheduleDrinkitNotifications()
            }
        }
        
        // scheduleDrinkitNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func scheduleDrinkitNotifications() {
        if !UserDefaults.standard.bool(forKey: "isNotFirst") {
            NotificationHandler.shared.sendNotificationWith(
                title: "Tomar água",
                subtitle: "Hora da Hidratação",
                body: "Hidrate-se meu filho, é importante",
                timeDelay: 7200,
                repeats: true)

            UserDefaults.standard.set(true, forKey: "isNotFirst")
        }
    }


}

