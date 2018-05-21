//
//  NeederViewController.swift
//  DiDiWork
//
//  Created by tongao on 2018/5/21.
//  Copyright © 2018年 Imam Asari. All rights reserved.
//

import UIKit

class NeederViewController: UIViewController {

    override func viewDidLoad() {
        show()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtClick(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func flashButton(_ sender: Any) {
        show()
    }
    @IBOutlet weak var neederVebView: UIWebView!
    //    @IBAction func backButtonClick(_ sender: Any) {
//        self.dismiss(animated: true, completion:nil)
//    }
//    @IBAction func flashButton(_ sender: Any) {
//        show()
//    }
//
//    @IBOutlet weak var needWebView: UIWebView!
    
    func show(){
        var url = URL(string: "https://didi.blliblli.cn/neederList.html")
        var request = NSURLRequest(url: url!)
        neederVebView.loadRequest(request as URLRequest)
        
        
    }
    
}
