//
//  LoginViewController.swift
//  Project#
//
//  Created by Юлия on 08.12.2018.
//  Copyright © 2018 Iuliia Grebeshok. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var hud: UIActivityIndicatorView!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tap(_ sender: Any) {
        dismissKeyboard()
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let alert = UIAlertController(title: "Gifter",
                                      message: "Type your email address you used to register.",
                                      preferredStyle: .alert)
        
        // RESET PASSWORD
        let reset = UIAlertAction(title: "Reset Password", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields!.first!
            let txtStr = textField.text!
            PFUser.requestPasswordResetForEmail(inBackground: txtStr, block: { (succ, error) in
                if error == nil {
                    self.simpleAlert("You will receive an email shortly with a link to reset your password")
                }})
        })
        alert.addAction(reset)
        
        
        // CANCEL BUTTON
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alert.addAction(cancel)
        
        // TextField
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .emailAddress
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func `continue`(_ sender: Any) {
        dismissKeyboard()
        hud.startAnimating()
        
        PFUser.logInWithUsername(inBackground: username.text!, password:password.text!) { (user, error) -> Void in
            if error == nil {
                self.hud.stopAnimating()
                
                // Enter to Home screen
                self.performSegue(withIdentifier: "feed2", sender: nil)
                
                // error
            } else {
                self.hud.stopAnimating()
                self.simpleAlert("\(error!.localizedDescription)")
            }}
    }
    
    func dismissKeyboard() {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func simpleAlert(_ mess:String) {
        let alert = UIAlertController(title: "Gifter",
                                      message: mess, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
