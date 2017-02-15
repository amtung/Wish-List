//
//  LoginViewController.swift
//  Wish List
//
//  Created by Annie Tung on 2/12/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        let _ = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            self.updateInterface()
        })
        addGestureToDismissKeyboard()
    }
    
    // MARK: - Methods
    
    func updateInterface() {
        if let _ = FIRAuth.auth()?.currentUser {
            self.performSegue(withIdentifier: "WishList", sender: self)
        } else {
            self.loginButton.setTitle("Sign in", for: .normal)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
            } catch {
                print("Error loggin in: \(error.localizedDescription)")
            }
        } else if let email = emailField.text,
            let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if user != nil {
                    print("User signing in")
                    self.performSegue(withIdentifier: "WishList", sender: sender)
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        if let email = emailField.text,
            let password = passwordField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if user != nil {
                    print("User registering")
                    self.performSegue(withIdentifier: "WishList", sender: sender)
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    // MARK: - Keyboard Actions
    
    func addGestureToDismissKeyboard() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.passwordField {
            view.endEditing(true)
            return false
        }
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
