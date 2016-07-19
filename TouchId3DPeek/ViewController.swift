//
//  ViewController.swift
//  TouchId3DPeek
//
//  Created by yaosixu on 16/7/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passWordTextFiedl: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    let laCon = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        title = "TouchDemo"
        
        //3D Touch 一个应用最多支持4个标签
        let itemOne = UIApplicationShortcutItem(type: "111", localizedTitle: "1title")
        let itemTwo = UIApplicationShortcutItem(type: "222", localizedTitle: "2title")
        let itemThree = UIApplicationShortcutItem(type: "333", localizedTitle: "3title")
        let itemFour = UIApplicationShortcutItem(type: "444", localizedTitle: "4title")
        let itemFive = UIApplicationShortcutItem(type: "555", localizedTitle: "5title")
        UIApplication.sharedApplication().shortcutItems = [itemOne,itemTwo,itemThree,itemFour,itemFive]
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        touchId()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapLogInButton(sender: UIButton) {
        
        if idTextField.text?.characters.count > 0 && passWordTextFiedl.text?.characters.count > 0 {
                pushToInfoViewController()
        }
        
    }
    
    func pushToInfoViewController() {
        let infoViewController = InfoViewController()
        navigationController?.pushViewController(infoViewController, animated: true)
    }
    
    //指纹解锁
    func touchId() {
        let errorPointer = NSErrorPointer()
        
        //输入指纹错误后会有一个提示框，设置右下角按钮的title
        laCon.localizedFallbackTitle = "输入密码"
        
        //首先判断设备是不是支持touch id
        if laCon.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: errorPointer) {
            //根据输入的指纹进行下面的操作
            laCon.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "指纹登录", reply: { [unowned self] in
                if $0.0 {
                    print("touch id is right")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.pushToInfoViewController()
                        self.laCon.invalidate()
                    })
                } else {
                    print("unknowed Error")
                }
            })
        } else {
            print("don't login with touch id")
        }
    }
    
}

