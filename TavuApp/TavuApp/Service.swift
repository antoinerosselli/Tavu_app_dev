//
//  Service.swift
//  TavuApp
//
//  Created by Florian Cartozo on 03/12/2022.
//

import Foundation

class Service {
    let host: String = "https://tavu-api-production.up.railway.app/"
    let defaults = UserDefaults.standard
    
    let videos: [Video] = [
        Video(title: "LES PIRES CHUTES DE L’HISTOIRE - Quel sera le meilleur duo ? (ft Billy, Inoxtag, Gotaga, Kamel…)", channelName: "Aminematue", miniature: "https://i.ytimg.com/vi/hbj4Q647I1I/default.jpg"),
        Video(title: "LES PIRES CHUTES DE L’HISTOIRE - Quel sera le meilleur duo ? (ft Billy, Inoxtag, Gotaga, Kamel…)", channelName: "Aminematue", miniature: "https://i.ytimg.com/vi/hbj4Q647I1I/default.jpg"),
        Video(title: "LES PIRES CHUTES DE L’HISTOIRE - Quel sera le meilleur duo ? (ft Billy, Inoxtag, Gotaga, Kamel…)", channelName: "Aminematue", miniature: "https://i.ytimg.com/vi/hbj4Q647I1I/default.jpg"),
        Video(title: "On fait un prix pour les Belgosses … 🤯😂 #shorts #prank #humour", channelName: "KAMERA KASTROS", miniature: "https://i.ytimg.com/vi/0LLjLfTrank/default.jpg")
    ];
    
    func getUserInfos(username: String, accessToken: String) -> User {
        // Call API with params
        return User(googleId: "1234", username: "Florian Cartozo")
    }
    
    func createGroup(name: String) -> Group {
        // Call API with params -> Create a new group in the db
        
        return Group(id: "1", nbMember: 0, name: "CSC Lab", Members: [])
    }
    
    func joinGroup(groupId: String) -> Bool {
        // Call API with params -> Create a new group in the db
//        let groupId = defaults.string(forKey: "groupId")
        let googleId = defaults.string(forKey: "googleId")
        print("google id: \(googleId)")
        print("group id: \(groupId)")
        let parameters: [String: Any] = ["googleId": googleId, "groupId": groupId]
        let url = URL(string: host + "group/join-group")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
          print(error.localizedDescription)
          return true
        }
        let task = session.dataTask(with: request) { data, response, error in
          
          if let error = error {
            print("Post Request Error: \(error.localizedDescription)")
            return
          }

          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
          else {
            print("Invalid Response received from the server")
            return
          }
          guard let responseData = data else {
            print("nil Data received from the server")
            return
          }
          
          do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
              print(jsonResponse)
            } else {
              print("data maybe corrupted or in wrong format")
              throw URLError(.badServerResponse)
            }
          } catch let error {
            print(error.localizedDescription)
          }
        }
        task.resume()
        return true;
    }
    
    func getGroup(groupId: String, onCompletion: @escaping (Group?) -> Void) {
        let url = URL(string: host + "group/" + groupId)!
        let session = URLSession.shared
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            print(data)
            if let jsonString = String(data: data!, encoding: .utf8) {
                let respJson = jsonString.toJSON() as! [String: Any]
                let groupName = respJson["name"];
                let membersList = respJson["member"] as! [[String: Any]]
                var members:[User] = []
                for list in membersList {
                    members.append(User(googleId: list["googleId"] as! String, username: list["username"] as! String))
                }
                let group: Group = Group(id: respJson["_id"] as! String, nbMember: members.count, name: groupName as! String, Members: members)
                print(group)
                onCompletion(group)
               
            }
        }
        task.resume()
        
        onCompletion(nil)
    }

    func getGroupVideo(onCompletion: @escaping ([Video]) -> Void) {
        let url = URL(string: host + "posted-video/" + "638c81b39e2d4600ad8a33c3")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            print(data)
            if let jsonString = String(data: data!, encoding: .utf8) {
                let respJson = jsonString.toJSON()  as? [[String:Any]]
                var videoList: [Video] = []
                if respJson?.count == 0 {
                    onCompletion([])
                } else {
                    for tmp in 0...respJson!.count - 1 {
                        let curr = respJson![tmp]
                        print(curr)
                        videoList += [Video(title: curr["title"] as! String, channelName: curr["channelName"] as! String, miniature:  curr["miniature"] as! String)]
                    }
                    
                    onCompletion(videoList)
                }
               
            }
        }
        task.resume()
        
        onCompletion([])
    }
    
    func postVideo(userId: String, video: Video) -> Bool {

        let groupId = defaults.string(forKey: "groupId")
        let author = defaults.string(forKey: "username")
        print(video)
        let parameters: [String: Any] = ["googleId": userId, "title": video.title, "author": author, "channelName": video.channelName, "miniature": video.miniature, "groupId": groupId]
        let url = URL(string: host + "posted-video")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
          print(error.localizedDescription)
          return true
        }
        let task = session.dataTask(with: request) { data, response, error in
          
          if let error = error {
            print("Post Request Error: \(error.localizedDescription)")
            return
          }

          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
          else {
            print("Invalid Response received from the server")
            return
          }
          guard let responseData = data else {
            print("nil Data received from the server")
            return
          }
          
          do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
              print(jsonResponse)
            } else {
              print("data maybe corrupted or in wrong format")
              throw URLError(.badServerResponse)
            }
          } catch let error {
            print(error.localizedDescription)
          }
        }
        task.resume()
        return true;
    }
    
    func userHasPostedToday(userId: String, onCompletion: @escaping (Bool) -> Void) {
        let groupId = defaults.string(forKey: "groupId")
        let parameters: [String: Any] = ["googleId": userId, "groupId": groupId]
        let url = URL(string: host + "posted-video/has-post")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
          print(error.localizedDescription)
          onCompletion(false)
        }
        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            print(data)
            if let jsonString = String(data: data!, encoding: .utf8) {
                print(jsonString)
                onCompletion(jsonString == "true" ? true : false)
            }
        }
        task.resume()
        
        onCompletion(false)
    }
    
    func login(googleId: String, username: String) {
          
          let parameters: [String: Any] = ["username": username, "googleId": googleId]
          let url = URL(string: host + "user/login")!
          let session = URLSession.shared
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          request.addValue("application/json", forHTTPHeaderField: "Accept")
          
          do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
          } catch let error {
            print(error.localizedDescription)
            return
          }
          let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
              print("Post Request Error: \(error.localizedDescription)")
              return
            }
            
            // ensure there is valid response code returned from this HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
              print("Invalid Response received from the server")
              return
            }
            guard let responseData = data else {
              print("nil Data received from the server")
              return
            }
            
            do {
              if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                print(jsonResponse)
                // handle json response
              } else {
                print("data maybe corrupted or in wrong format")
                throw URLError(.badServerResponse)
              }
            } catch let error {
              print(error.localizedDescription)
            }
          }
          task.resume()
    }
}
