//
//  ProfileViewController.swift
//  SigninWithGoogle
//
//  Created by Tanut on 3/14/2560 BE.
//  Copyright © 2560 devth. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

@available(iOS 10.0, *)
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var photourlValuelabel: UILabel!
    @IBOutlet weak var nameValuelabel: UILabel!
    @IBOutlet weak var emailValuelabel: UILabel!
    @IBOutlet weak var uidValuelabel: UILabel!
    @IBOutlet weak var showImgURL: UIImageView!
    
    var url: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogOutButton()
        setupManageButton()
        
        if let user = FIRAuth.auth()?.currentUser {
            setUserDataToView(withFIRUser: user)
        }
        
        var data = NSData(contentsOf:url! as URL)
        if data != nil {
            showImgURL.image = UIImage(data:data! as Data)
            showImgURL.layer.cornerRadius = 50.0
            showImgURL.clipsToBounds = true
        }
    }

    private func setupLogOutButton() {
        let logOutButton = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
        self.navigationItem.leftBarButtonItem = logOutButton
    }
    
    private func setupManageButton(){
        let ManageButton = UIBarButtonItem(title: "Manage", style: .plain, target: self, action: #selector(manage))
        self.navigationItem.rightBarButtonItem = ManageButton
    }
    
    private func setUserDataToView(withFIRUser user: FIRUser) {
        uidValuelabel.text = user.uid
        emailValuelabel.text = user.email
        nameValuelabel.text = user.displayName
        photourlValuelabel.text = user.photoURL?.absoluteString
        url = user.photoURL?.absoluteURL as NSURL!
    }
    
    func signOut(){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let signOutError as NSError {
            print ("Error Firebase signing out: \(signOutError)")
        }
        
        // TODO: Google Sign out
        GIDSignIn.sharedInstance().signOut()
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "login")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginVC
    }
    
    func manage(){
        
    }


}
