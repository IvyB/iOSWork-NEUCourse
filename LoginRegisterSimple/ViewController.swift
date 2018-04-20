//
//  ViewController.swift
//  LoginRegisterSimple
//
//  Created by Imam Asari on 4/19/18.
//  Copyright © 2018 Imam Asari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if (!isLoggedIn) {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }


    @IBAction func buttonLogoutTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
}

