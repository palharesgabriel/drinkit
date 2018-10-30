//
//  DrinkViewController.swift
//  drinkit
//
//  Created by Ada 2018 on 01/10/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

protocol DrinkViewControllerDelegate: class {
    func updateTotal(drink: Int)
}

class DrinkViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: DrinkViewControllerDelegate?
    
    let options = [200, 300, 400, 500, 600, 700]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
    }

}

extension DrinkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuantityTableViewCell
        let quantity = options[indexPath.row]
        let text = "\(quantity) ml"
        cell.quantityLabel.text = text
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drink = options[indexPath.row]
        self.dismiss(animated: true) {
            self.delegate?.updateTotal(drink: drink)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height/CGFloat(options.count)
    }
    
    
    
    
    
    
}
