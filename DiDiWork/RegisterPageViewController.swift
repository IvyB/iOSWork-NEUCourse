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
    @IBOutlet weak var _phoneTP: UITextField!
    @IBOutlet weak var _sexTP: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let username = _emailTP.text
        let password = _passwordTP.text
        let phone = _phoneTP.text
        //        let sex = _sexTP.selectedSegmentIndex
        let sex = _sexTP.titleForSegment(at: _sexTP.selectedSegmentIndex)!
        
        
        //        let confirmPassword = _confirmPasswordTP.text
        
        // check form emtpy field
        if((username?.isEmpty)! || (password?.isEmpty)! || (phone?.isEmpty)!) {
            displayAlertMessage(userMessage: "请填写所有信息")
            return
        }
        
        //        if (password != confirmPassword) {
        //            displayAlertMessage(userMessage: "密码不规范")
        //            return
        //        }
        //
        //        // store data
        //        let defaults = UserDefaults.standard
        //        defaults.set(email, forKey: "email")
        //        defaults.set(password, forKey: "password")
        //        defaults.synchronize();
        
        // display alert message with confirmation
        if regPost(username: username!, password: password!, phone: phone!, sex: "\(sex)") {
            let myAlert = UIAlertController(title: "提示", message: "注册成功", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "成功", style: UIAlertActionStyle.default, handler: {action in self.dismiss(animated: true, completion:nil)})
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
        
    }
    
    func regPost(username:String, password:String, phone:String, sex:String) -> Bool {
        let url = URL(string: "http://127.0.0.1:8001/reg")
        //        func Post(path: String,paras: String,success: @escaping ((_ result: String) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        
        //        let url = URL(string: path)
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        let paras  = "username="+username+"&password="+password+"&phone="+phone+"&sex"+sex
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
        
        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func closeRegister(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
