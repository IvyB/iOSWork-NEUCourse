//
//  RegisterPageViewController.swift
//  LoginRegisterSimple
//
//  Created by Imam Asari on 4/20/18.
//  Copyright © 2018 Imam Asari. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var _emailTP: UITextField!
    @IBOutlet weak var _passwordTP: UITextField!
    @IBOutlet weak var _confirmPasswordTP: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButtonTapped(_ sender: Any) {
        let email = _emailTP.text
        let password = _passwordTP.text
        let confirmPassword = _confirmPasswordTP.text
        
        // check form emtpy field
        if((email?.isEmpty)! || (password?.isEmpty)! || (confirmPassword?.isEmpty)!) {
            displayAlertMessage(userMessage: "All fields are required")
           return
        }
        
        if (password != confirmPassword) {
            displayAlertMessage(userMessage: "password do not match")
            return
        }
        
        // store data
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "password")
        defaults.synchronize();
        
        // display alert message with confirmation
        
        let myAlert = UIAlertController(title: "Alert", message: "Registration Succesfull", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in self.dismiss(animated: true, completion:nil)})
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)

    }
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func closeRegister(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
