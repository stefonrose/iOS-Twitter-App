//
//  LoginViewController.swift
//  Twitter
//
//  Created by Stephon Fonrose on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyling()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "currentUser") == true {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        let requestToken = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: requestToken, success: {
            
            UserDefaults.standard.set(true, forKey: "currentUser")
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }, failure: { (Error) in
            print(Error.localizedDescription)
        })
    }
    
    func buttonStyling() {
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
    }

}
