//
//  VideoSelectController.swift
//  Tavu
//
//  Created by Antoine Rosselli on 26/11/2022.
//

import UIKit

class VideoSelectController: UIViewController {
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        let vsModel = ["ceciestuntitredevideotrestreslong","WAAAA MON PERE EST UN AGENT DE LA CIA JE HURRRRRLLLE"]
        vsCreator(vsModel: vsModel)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print(sender.titleLabel!.text as Any)
    }
    
    func vsCreator(vsModel :[String]) {
        var y = 100
        for videoInfo in vsModel {
            let button = UIButton(frame: CGRect(x: 0, y: y, width: 390 , height: 100))
            button.backgroundColor = .lightGray
            button.setTitle(videoInfo, for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.view.addSubview(button)
            y = y + 120
        }
    }
}


