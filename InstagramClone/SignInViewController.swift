//
//  SignInViewController.swift
//  InstagramClone
//
//  Created by Erica on 5/5/19.
//  Copyright © 2019 Erica. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       emailTextField.backgroundColor = .clear
        emailTextField.tintColor = .white
        emailTextField.textColor = .white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder ?? " ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        
        let bottomLineEmail = CALayer()
        bottomLineEmail.frame = CGRect(x: 0, y: 29, width:emailTextField.frame.width, height: 0.6)
        bottomLineEmail.backgroundColor = UIColor.white.cgColor
        emailTextField.layer.addSublayer(bottomLineEmail)
        
        passwordTextField.backgroundColor = .clear
        passwordTextField.tintColor = .white
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder ?? " ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        
        let bottomLinePassword = CALayer()
        bottomLinePassword.frame = CGRect(x: 0, y: 29, width: passwordTextField.frame.width, height: 0.6)
        bottomLinePassword.backgroundColor = UIColor.white.cgColor
        passwordTextField.layer.addSublayer(bottomLinePassword)
        signInButton.isEnabled = false
        handleTextField()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "signInToTabBarVC", sender: nil)
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
           ProgressHUD.showSuccess("Sucess!")
            self.performSegue(withIdentifier: "signInToTabBarVC", sender: nil)
        }, onError: { error in
            ProgressHUD.showError(error!)

        })
        
    }
    @objc func textFieldDidChanged() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signInButton.setTitleColor(.lightText, for: .normal)
            signInButton.isEnabled = false
            return
        }
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.isEnabled = true
    }
    
    func handleTextField() {
  
        emailTextField.addTarget(self, action: #selector(SignInViewController.textFieldDidChanged), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignInViewController.textFieldDidChanged), for: UIControl.Event.editingChanged)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
