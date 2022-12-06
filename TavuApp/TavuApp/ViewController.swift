//
//  ViewController.swift
//  TavuApp
//
//  Created by Antoine Rosselli on 28/11/2022.
//

import UIKit
import GoogleSignIn
import OAuthSwift

class ViewController: UIViewController {

    let defaults = UserDefaults.standard
    let signInConfig = GIDConfiguration(clientID: "687072614508-mbvflh3p6947286op333i8d7cfnttm40.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let accessToken = defaults.string(forKey: "accessToken")
        if (accessToken != nil) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.present(homeViewController, animated: true, completion: nil)
        }
    }
    @IBAction func YoutubeScope(_ sender: Any) {
        let additionalScopes = ["https://www.googleapis.com/auth/youtube.readonly"]
        GIDSignIn.sharedInstance.addScopes(additionalScopes, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            // Check if the user granted access to the scopes you requested.
        }
    }
    
    @IBAction func ConnectGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            let emailAddress = user.profile?.email

            let fullName = user.profile?.name
            let username = fullName
            let googleId = user.userID
            user.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }

                let idToken = authentication.idToken
                let accessToken = authentication.accessToken
                self.defaults.set(idToken, forKey: "idToken")
                self.defaults.set(accessToken, forKey: "accessToken")
                self.defaults.set(googleId, forKey: "googleId")
                print(accessToken)
                print(user.grantedScopes)
                }
            self.defaults.set(username, forKey: "username")
            let isLoged = Service().login(googleId: googleId!, username: username!)
            print(isLoged)
            var groupId = self.defaults.string(forKey: "groupId")
            if (groupId == nil) {
                print("c'est nul")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController = storyBoard.instantiateViewController(withIdentifier: "GroupChange") as! GroupchangeController
                        self.present(homeViewController, animated: true, completion: nil)
                return
                //self.defaults.set("638c81b39e2d4600ad8a33c3", forKey: "groupId")
            }
            groupId = self.defaults.string(forKey: "groupId")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.present(homeViewController, animated: true, completion: nil)
        }
    }
}

