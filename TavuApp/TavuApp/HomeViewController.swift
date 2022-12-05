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
    let youtubeService = Youtube()
    let tavuService = Service()
    var videoFeed: [Video] = []
    var userHasPost: Bool = false
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var addVideo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userId = defaults.string(forKey: "googleId")
        tavuService.userHasPostedToday(userId: userId!) { isPosted in
            self.userHasPost = isPosted
        }
        print(userHasPost)
        tavuService.getGroupVideo { videoList in
            self.videoFeed = videoList
        }
        username.text = defaults.string(forKey: "username")
            }
    
    override func viewDidAppear(_ animated: Bool) {
        if (userHasPost) {
            addVideo.isUserInteractionEnabled = false
            addVideo.setTitle("Posted", for: .normal)
        }
        feedCreator(videos: videoFeed)
    }
    
    @IBAction func SignOut(_ sender: Any) {
        self.defaults.set(nil, forKey: "accessToken")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                self.present(homeViewController, animated: true, completion: nil)
    }
    
    func feedCreator(videos: [Video]) {
        var y = 200
        
        for video in videos {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 31))
            label.center = CGPoint(x: 240, y: y)
            label.textAlignment = .left
            label.font = label.font.withSize(20)
            label.text = video.title
            self.view.addSubview(label)
            y = y + 70
        }
        y = 225
        for video in videos {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 31))
            label.center = CGPoint(x: 240, y: y)
            label.textAlignment = .left
            label.font = label.font.withSize(10)
            label.text = video.channelName
            self.view.addSubview(label)
            y = y + 70
        }
        y = 170
        for video in videos {
            var imageView : UIImageView
            imageView  = UIImageView(frame:CGRectMake(10, CGFloat(y), 120, 70));
            let url = URL(string: video.miniature)
            let data = try? Data(contentsOf: url!)
            imageView.image = UIImage(data: data!)
            self.view.addSubview(imageView)
            y = y + 72
        }
    }
}
