//
//  ViewController.swift
//  SigninWithGoogle
//
//  Created by Tanut on 3/14/2560 BE.
//  Copyright © 2560 devth. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

@available(iOS 10.0, *)
class ViewController: UIViewController,GIDSignInUIDelegate {

    @IBOutlet weak var VideoBackgroundWebView: UIWebView!
    @IBOutlet weak var filterBackground: UIView!
    
    private var authListener: FIRAuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.setVideoBackground()
        
        self.setBackgroundFilter()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authListener = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let user = user {
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "profile") as! UINavigationController
                let profileVC = nav.viewControllers[0] as! ProfileViewController
                profileVC.title = "GoogleSignIn"
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = nav
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FIRAuth.auth()?.removeStateDidChangeListener(authListener!)
    }
    
    // MARK: - Interface
    
    private func setVideoBackground() {
        let htmlName = "WebViewContent"
        guard let htmlPath = Bundle.main.path(forResource: htmlName, ofType: "html") else { return }
        let htmlURL = URL(fileURLWithPath: htmlPath)
        guard let html = try? Data(contentsOf: htmlURL) else { return }
        
        self.VideoBackgroundWebView.load(html, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: htmlURL.deletingLastPathComponent())
    }
    
    private func setBackgroundFilter() {
        self.filterBackground.backgroundColor = UIColor.black
        self.filterBackground.alpha = 0.5
    }

}

