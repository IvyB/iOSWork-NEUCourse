//
//  LoginViewController.swift
//  LoginRegisterSimple
//
//  Created by Tongao on 4/20/18.
//  Copyright © 2018 Tongao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTP: UITextField!
    @IBOutlet weak var passwordTP: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let storedEmail = UserDefaults.standard.string(forKey: "email")
        let storedPassword = UserDefaults.standard.string(forKey: "password")
        
        if (emailTP.text == storedEmail && passwordTP.text == storedPassword) {
            UserDefaults.standard.set(true, forKey:"isLoggedIn")
            UserDefaults.standard.synchronize()
            self.dismiss(animated: true, completion:nil);
        } else {
            displayAlertMessage(userMessage: "登录失败")
        }
        
    }
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
//
  
}
