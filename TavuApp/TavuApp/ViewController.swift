//
//  ViewController.swift
//  TavuApp
//
//  Created by Antoine Rosselli on 28/11/2022.
//

import UIKit

class ViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func ConnectGoogle(_ sender: Any) {
        let username = "MARCHEFDP"
        defaults.set(username, forKey: "username")
    }
    

}

