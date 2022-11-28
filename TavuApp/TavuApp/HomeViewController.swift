//
//  HomeViewController.swift
//  Tavu
//
//  Created by Antoine Rosselli on 26/11/2022.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var username: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = defaults.string(forKey: "username")
        let vname = ["video1","video2","video1","video2","video1","video2","video1","video2"]
        let vchannel = ["funguys","cooldude","funguys","cooldude","funguys","cooldude","funguys","cooldude"]
        let minia = [UIImage(named: "photo1"),UIImage(named: "photo1"),UIImage(named: "photo1"),UIImage(named: "photo1"),UIImage(named: "photo1"),UIImage(named: "photo1"),UIImage(named: "photo1"),UIImage(named: "photo1")]
        feedCreator(vname: vname, vchannel: vchannel,minia: minia )
    }
    
    func feedCreator(vname :[String],vchannel :[String], minia :[UIImage?]) {
        var y = 200
        for title in vname {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 31))
            label.center = CGPoint(x: 240, y: y)
            label.textAlignment = .left
            label.font = label.font.withSize(20)
            label.text = title
            self.view.addSubview(label)
            y = y + 70
        }
        y = 225
        for channelName in vchannel {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 31))
            label.center = CGPoint(x: 240, y: y)
            label.textAlignment = .left
            label.font = label.font.withSize(10)
            label.text = channelName
            self.view.addSubview(label)
            y = y + 70
        }
        y = 170
        for picture in minia {
            var imageView : UIImageView
            imageView  = UIImageView(frame:CGRectMake(10, CGFloat(y), 120, 70));
            imageView.image = picture
            self.view.addSubview(imageView)
            y = y + 72
        }
    }
}
