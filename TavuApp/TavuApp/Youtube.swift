//
//  Youtube.swift
//  TavuApp
//
//  Created by Florian Cartozo on 29/11/2022.
//

import Foundation

class Youtube {
    let defaults = UserDefaults.standard
    let host: String = "http://localhost:3000/"
    let accessToken: String;
    var videos: [Video] = [
        Video(title: "LES PIRES CHUTES DE L’HISTOIRE - Quel sera le meilleur duo ? (ft Billy, Inoxtag, Gotaga, Kamel…)", channelName: "Aminematue", miniature: "https://i.ytimg.com/vi/hbj4Q647I1I/default.jpg"),
        Video(title: "LES PIRES CHUTES DE L’HISTOIRE - Quel sera le meilleur duo ? (ft Billy, Inoxtag, Gotaga, Kamel…)", channelName: "Aminematue", miniature: "https://i.ytimg.com/vi/hbj4Q647I1I/default.jpg"),
        Video(title: "LES PIRES CHUTES DE L’HISTOIRE - Quel sera le meilleur duo ? (ft Billy, Inoxtag, Gotaga, Kamel…)", channelName: "Aminematue", miniature: "https://i.ytimg.com/vi/hbj4Q647I1I/default.jpg"),
        Video(title: "On fait un prix pour les Belgosses … 🤯😂 #shorts #prank #humour", channelName: "KAMERA KASTROS", miniature: "https://i.ytimg.com/vi/0LLjLfTrank/default.jpg")
    ];
    init() {
        self.accessToken = defaults.string(forKey: "accessToken") ?? "no"
    }
//
    func GetLikedVideo(onCompletion: @escaping ([Video]) -> Void){
        let parameters: [String: Any] = ["accessToken": accessToken]
        let url = URL(string: host + "youtube/likedVideo")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
          print(error.localizedDescription)
          onCompletion([])
        }
        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            print(data)
            if let jsonString = String(data: data!, encoding: .utf8) {
                let respJson = jsonString.toJSON()  as? [[String:Any]]
                var videoList: [Video] = []
            
                for tmp in 0...4 {
                    let curr = respJson![tmp]
                    videoList += [Video(title: curr["title"] as! String, channelName: curr["channel"] as! String, miniature:  curr["miniature"] as! String)]
                }
                self.videos = videoList
                onCompletion(videoList)
            }
        }
        task.resume()
    }
}
