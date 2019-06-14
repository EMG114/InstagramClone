//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by Erica on 5/5/19.
//  Copyright © 2019 Erica. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var signUpButton: UIButton!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.backgroundColor = .clear
        userNameTextField.tintColor = .white
        userNameTextField.textColor = .white
        userNameTextField.attributedPlaceholder = NSAttributedString(string: userNameTextField.placeholder ?? " ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        
        let bottomLineUser = CALayer()
        bottomLineUser.frame = CGRect(x: 0, y: 29, width:userNameTextField.frame.width, height: 0.6)
        bottomLineUser.backgroundColor = UIColor.white.cgColor
        userNameTextField.layer.addSublayer(bottomLineUser)

        
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
        
        
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.clipsToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleProfileView))
        profileImage.addGestureRecognizer(gesture)
        profileImage.isUserInteractionEnabled = true
        signUpButton.isEnabled = false
        handleTextField()
    }
    
    func handleTextField() {
        userNameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChanged), for: UIControl.Event.editingChanged)
         emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChanged), for: UIControl.Event.editingChanged)
         passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChanged), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChanged() {
        guard let userName = userNameTextField.text, !userName.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signUpButton.setTitleColor(.lightText, for: .normal)
            signUpButton.isEnabled = false
            return
        }
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.isEnabled = true
    }
    
    @objc func handleProfileView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func dismissSignUpScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpTouched(_ sender: Any) {
        view.endEditing(true)
            ProgressHUD.show("Waiting...", interaction: false)
           if let profileImage = self.selectedImage, let imageData = profileImage.jpegData(compressionQuality: 0.1) {
            AuthService.signUp(userName: userNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, imageData: imageData, onSuccess: {
                  ProgressHUD.showSuccess("Sucess!")
                self.performSegue(withIdentifier: "signUpToTabBarVC", sender: nil)
            }) { (error) in
                      ProgressHUD.showError(error!)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage {
            selectedImage = image
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
