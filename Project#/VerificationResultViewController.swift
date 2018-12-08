//
//  VerificationResultViewController.swift
//  Project#
//
//  Created by Юлия on 08.12.2018.
//  Copyright © 2018 Iuliia Grebeshok. All rights reserved.
//

import UIKit
import Parse

class VerificationResultViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var usernameTxt: UITextField!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var emailTxt: UITextField!
    @IBOutlet var tosButton: UIButton!
    @IBOutlet var checkboxButton: UIButton!
    @IBOutlet var successIndication: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var hud: UIActivityIndicatorView!
    
    var tosAccepted = false
    var message: String?
    
    
    @IBAction func imagePicker(_ sender: Any) {
        let alert = UIAlertController(title: "Gifter",
                                      message: "Select source",
                                      preferredStyle: .alert)
        
        let camera = UIAlertAction(title: "Take a picture", style: .default, handler: { (action) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        let library = UIAlertAction(title: "Pick from library", style: .default, handler: { (action) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        if let resultToDisplay = message {
            successIndication.text = "Phone Number is Verified"
        } else {
            successIndication.text = "Something went wrong!"
        }
        super.viewDidLoad()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image = info[.originalImage] as! UIImage
        
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    func dismissKeyboard() {
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTxt {  passwordTxt.becomeFirstResponder()  }
        if textField == passwordTxt {  emailTxt.becomeFirstResponder()     }
        if textField == emailTxt {  dismissKeyboard()  }
        return true
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func `continue`(_ sender: Any) {
        
        dismissKeyboard()
        
        // YOU ACCEPTED THE TERMS OF SERVICE
        if tosAccepted {
            if usernameTxt.text == "" || passwordTxt.text == "" || emailTxt.text == "" {
                simpleAlert("You must fill all fields to sign up on Gifter")
                
            } else {
                hud.startAnimating()
                let user = PFUser()
                user.username = usernameTxt.text!
                user.password = passwordTxt.text!
                user.email = emailTxt.text!
                
                if imageView.image != nil {
                    let imageData = imageView.image?.jpegData(compressionQuality: 0.8)
                    let imageFile = PFFileObject(name: "image.jpg", data: imageData!)
                    // profilePic needs to be the name of the col
                    user["profilePic"] = imageFile
                }
                
                
                user.signUpInBackground { (result, error) in
                    if error == nil && result == true {
                        //User was successfullly registerd
                        self.hud.stopAnimating()
                        self.performSegue(withIdentifier: "feed", sender: nil)
                    } else {
                        self.hud.stopAnimating()
                        self.simpleAlert("An error in registration happened, please, try later")
                    }
                }
            }
            
            
            // YOU HAVEN'T ACCEPTED THE TERMS OF SERVICE
        } else { simpleAlert("You must agree with Terms of Service in order to Sign Up.") }
        
    }
    
    func simpleAlert(_ mess:String) {
        let alert = UIAlertController(title: "Gifter",
                                      message: mess, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func checkboxButton(_ sender: Any) {
        tosAccepted = true
        checkboxButton.setBackgroundImage(UIImage(named: "chosen"), for: .normal)
    }
    
    @IBAction func tosButton(_ sender: Any) {
        performSegue(withIdentifier: "tou", sender: nil)
    }
    
    @IBAction func tap(_ sender: Any) {
        dismissKeyboard()
    }
    

}
