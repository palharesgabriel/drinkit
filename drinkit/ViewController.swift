//
//  ViewController.swift
//  drinkit
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var total: Int = 0

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
                // self.scheduleDrinkitNotifications()
            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "drinkSegue" {
            let vc = segue.destination as! DrinkViewController
            vc.delegate = self
        }
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

extension ViewController: DrinkViewControllerDelegate {
    
    func updateTotal(drink: Int) {
        total = total + drink
        setLabelText()
    }
    
    func setLabelText() {
        let text = "\(self.total)/2000 ml"
        progressLabel.text = text
    }
    
}

