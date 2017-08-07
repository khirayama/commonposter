//
//  ViewController.swift
//  Commonposter
//
//  Created by Kotaro Hirayama on 2017/08/05.
//  Copyright © 2017 Kotaro Hirayama. All rights reserved.
//

import UIKit
import Auth0

class LoginButton {
    var el: UIButton
    var viewController: ViewController
    
    init(viewController: ViewController) {
        self.el = UIButton()
        self.viewController = viewController
        
        self.setEventHandlers()
        self.render()
    }
    func applyStyle() {
        self.el.setTitle("Tap Me!", for: .normal)
        self.el.setTitleColor(UIColor.blue, for: .normal)
        self.el.setTitle("Tapped!", for: .highlighted)
        self.el.setTitleColor(UIColor.red, for: .highlighted)
        self.el.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        self.el.tag = 1
        self.el.layer.position = CGPoint(x: self.viewController.view.frame.width / 2, y: 100)
        self.el.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.2)
        self.el.layer.cornerRadius = 10
        self.el.layer.borderWidth = 1
    }
    
    func handleTap() {
        print("Tap!")
        Auth0.webAuth().start({
            switch $0 {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let credentials):
                print("idToken: \(String(describing: credentials.idToken))")
            }
        })
    }

    func setEventHandlers() {
        print("Set event handler")
    }
    
    func render() {
        self.applyStyle()
        self.viewController.view.addSubview(self.el)
    }
}


class ViewController: UIViewController {
    let loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(viewController: self)
        loginButton.el.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)
    }
    
    func handleTap() {
        print("Tap!")
        Auth0.webAuth().start({
            switch $0 {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let credentials):
                print("idToken: \(String(describing: credentials.idToken))")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

