//
//  ViewController.swift
//  Commonposter
//
//  Created by Kotaro Hirayama on 2017/08/05.
//  Copyright © 2017 Kotaro Hirayama. All rights reserved.
//

import UIKit
import Auth0
import Alamofire

class LoginButton {
    var el: UIButton
    var viewController: ViewController

    init(viewController: ViewController) {
        self.el = UIButton()
        self.viewController = viewController

        self.render()
    }
    func applyStyle() {
        self.el.setTitle("Login", for: .normal)
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

    func render() {
        self.applyStyle()
        self.viewController.view.addSubview(self.el)
    }
}

class PublicAPIButton {
    var el: UIButton
    var viewController: ViewController

    init(viewController: ViewController) {
        self.el = UIButton()
        self.viewController = viewController

        self.render()
    }
    func applyStyle() {
        self.el.setTitle("Public API", for: .normal)
        self.el.setTitleColor(UIColor.blue, for: .normal)
        self.el.setTitle("Tapped!", for: .highlighted)
        self.el.setTitleColor(UIColor.red, for: .highlighted)
        self.el.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        self.el.tag = 1
        self.el.layer.position = CGPoint(x: self.viewController.view.frame.width / 2, y: 200)
        self.el.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.2)
        self.el.layer.cornerRadius = 10
        self.el.layer.borderWidth = 1
    }

    func render() {
        self.applyStyle()
        self.viewController.view.addSubview(self.el)
    }
}

class PrivateAPIButton {
    var el: UIButton
    var viewController: ViewController

    init(viewController: ViewController) {
        self.el = UIButton()
        self.viewController = viewController

        self.render()
    }
    func applyStyle() {
        self.el.setTitle("Private API", for: .normal)
        self.el.setTitleColor(UIColor.blue, for: .normal)
        self.el.setTitle("Tapped!", for: .highlighted)
        self.el.setTitleColor(UIColor.red, for: .highlighted)
        self.el.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        self.el.tag = 1
        self.el.layer.position = CGPoint(x: self.viewController.view.frame.width / 2, y: 300)
        self.el.backgroundColor = UIColor(red: 0.7, green: 0.2, blue: 0.2, alpha: 0.2)
        self.el.layer.cornerRadius = 10
        self.el.layer.borderWidth = 1
    }

    func render() {
        self.applyStyle()
        self.viewController.view.addSubview(self.el)
    }
}

class ViewController: UIViewController {
    var idToken: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = LoginButton(viewController: self)
        loginButton.el.addTarget(self, action: #selector(self.handleTapLoginButton), for: .touchUpInside)

        let publicAPIButton = PublicAPIButton(viewController: self)
        publicAPIButton.el.addTarget(self, action: #selector(self.handleTapPublicAPIButton), for: .touchUpInside)

        let privateAPIButton = PrivateAPIButton(viewController: self)
        privateAPIButton.el.addTarget(self, action: #selector(self.handleTapPrivateAPIButton), for: .touchUpInside)
    }

    // Event Handlers
    func handleTapLoginButton() {
        self.authorize()
    }

    func handleTapPublicAPIButton() {
        Alamofire.request("http://10.33.87.124:3001/public").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }

    func handleTapPrivateAPIButton() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + self.idToken!
        ]

        Alamofire.request("http://10.33.87.124:3001/private", headers: headers).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }

    // Other
    func authorize() {
        Auth0.webAuth().start({
            switch $0 {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let credentials):
                print("idToken: \(String(describing: credentials.idToken))")
                self.idToken = credentials.idToken!
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

