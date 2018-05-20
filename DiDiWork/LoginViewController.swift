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
        let username = emailTP.text
        let password = passwordTP.text
        
        if((username?.isEmpty)! || (password?.isEmpty)!) {
            displayAlertMessage(userMessage: "请填写所有信息")
            return
        }
        
        if (loginPost(username: username!,password: password!)) {
            UserDefaults.standard.set(true, forKey:"isLoggedIn")
            UserDefaults.standard.set(username, forKey:"username")
            UserDefaults.standard.synchronize()
            self.dismiss(animated: true, completion:nil);
        } else {
            displayAlertMessage(userMessage: "登录失败")
        }
        
    }
    
    func loginPost(username:String, password:String) -> Bool{
        let url = URL(string: "http://127.0.0.1:8001/login")
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        let paras  = "username="+username+"&password="+password
        request.httpBody = paras.data(using: .utf8)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            if let data = data {
                
                if String(data:data,encoding:.utf8) != nil{
                    //            success(result)
                }
                
            }else {
                //            failure(error!)
                
            }
        }
        dataTask.resume()
        
        return true
    }
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "提示", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "成功", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
//
  
}
