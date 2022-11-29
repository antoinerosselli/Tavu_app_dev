//
//  ViewController.swift
//  TavuApp
//
//  Created by Antoine Rosselli on 28/11/2022.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    let defaults = UserDefaults.standard
    let signInConfig = GIDConfiguration(clientID: "687072614508-mbvflh3p6947286op333i8d7cfnttm40.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    @IBAction func ConnectGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            let emailAddress = user.profile?.email

            let fullName = user.profile?.name
            let username = fullName
            print(username)
            user.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }

                let idToken = authentication.idToken
                let accessToken = authentication.accessToken
                self.defaults.set(idToken, forKey: "idToken")
                self.defaults.set(accessToken, forKey: "accessToken")
                // Send ID token to backend (example below).
                }
            self.defaults.set(username, forKey: "username")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    self.present(homeViewController, animated: true, completion: nil)
        }
    }
}

