//
//  SignInViewController.swift
//  CommuteTracker
//
//  Created by Robert Ryder on 6/21/17.
//  Copyright © 2017 Robert Ryder. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "signInSegue", sender: nil)
        }
        
    }

    
    
    @IBAction func signInPressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            
            if error != nil {
                
                Auth.auth().createUser(withEmail: self.usernameTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    
                    if error == nil {
                        
                        Database.database().reference().child("Users").child(user!.uid).child("Email").setValue(user!.email!)
                    }
                })
            }
            
            
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
            
        }
        
        
        
    }
    
    
    
}
