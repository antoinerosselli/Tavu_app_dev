//
//  ViewController.swift
//  Tavu
//
//  Created by Antoine Rosselli on 05/11/2022.
//

import UIKit

class ViewController: UIViewController {
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ConnectGoogle(_ sender: Any) {
        print("GO")
        defaults.set("BRUTNOM", forKey: "username")
    }
    
}
