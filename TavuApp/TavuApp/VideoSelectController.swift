//
//  VideoSelectController.swift
//  Tavu
//
//  Created by Antoine Rosselli on 26/11/2022.
//

import UIKit

class VideoSelectController: UIViewController {
    let defaults = UserDefaults.standard
    var Allvideos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let youtubeService = Youtube()
        let tavuService = Service()
        youtubeService.GetLikedVideo { videoList in
            self.Allvideos = videoList
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        do {
            sleep(1)
        }
        self.vsCreator(vsModel: Allvideos)
    }

  
    @objc func buttonAction(sender: UIButton!) {
        let title = sender.titleLabel!.text! as String
        var vid: Video? = nil
        for tmp in self.Allvideos {
            if tmp.title == title {
                vid = tmp
            }
        }
        let googleId = self.defaults.string(forKey: "googleId")
        let isPosted = Service().postVideo(userId: googleId!, video: vid!)
        if (isPosted) {
            print("faut close la modal + reload Home")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.present(homeViewController, animated: true, completion: nil)
        }
    }
    
    func vsCreator(vsModel :[Video]) {
        var y = 100
        print(vsModel.count)
        for videoInfo in vsModel {
            let button = UIButton(frame: CGRect(x: 130, y: y, width: 250 , height: 70))
            button.backgroundColor = .lightGray
            button.setTitle(videoInfo.title, for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.view.addSubview(button)
            y = y + 80
        }
        y = 100
        for video in vsModel {
            var imageView : UIImageView
            imageView  = UIImageView(frame:CGRectMake(10, CGFloat(y), 120, 70));
            let url = URL(string: video.miniature)
            let data = try? Data(contentsOf: url!)
            imageView.image = UIImage(data: data!)
            self.view.addSubview(imageView)
            y = y + 80
        }
    }
}


