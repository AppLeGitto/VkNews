//
//  ViewController.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 19.05.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authService = SceneDelegate.shared().authService  
    }
    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

