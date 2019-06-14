//
//  CameraViewController.swift
//  InstagramClone
//
//  Created by Erica on 5/6/19.
//  Copyright © 2019 Erica. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class CameraViewController: UIViewController {
    @IBOutlet var photo: UIImageView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var shareButton: UIButton!
    
    @IBOutlet var removeBarButton: UIBarButtonItem!
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(CameraViewController.handlePhoto))
        photo.addGestureRecognizer(gesture)
        photo.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handlePosts()
    }
    
    @objc func handlePhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    func handlePosts() {
        if selectedImage != nil {
            self.shareButton.isEnabled = true
            self.shareButton.backgroundColor = UIColor(displayP3Red: 173/255, green: 59/255, blue: 166/255, alpha: 1.0)
            self.removeBarButton.isEnabled = true
        } else {
            self.shareButton.isEnabled = false
            self.shareButton.backgroundColor = UIColor(displayP3Red: 173/255, green: 59/255, blue: 166/255, alpha: 0.5)
            self.removeBarButton.isEnabled = false
      }
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        if let profileImage = self.selectedImage, let imageData = profileImage.jpegData(compressionQuality: 0.1) {
            let photoIdString = NSUUID().uuidString
            let storage = Storage.storage().reference().child("posts").child(photoIdString)
            storage.putData(imageData, metadata: nil) { (metadata, error) in
                metadata?.storageReference?.downloadURL(completion: { (url, error) in
                    if error != nil {
                        ProgressHUD.showError(error?.localizedDescription)
                        return
                    }
                let photoURL =  url?.absoluteString
                    self.sendDataToDatabase(photoUrl: photoURL!)
                })
            ProgressHUD.showSuccess("Success!")
                self.refactorClearPost()
                self.tabBarController?.selectedIndex = 0
        }
    }
    
}
    
    
    @IBAction func remove(_ sender: Any) {
      self.refactorClearPost()
        self.handlePosts()
        
    }
    
    func sendDataToDatabase(photoUrl: String) {

        let ref = Database.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        let newPostRef = postsReference.child(newPostId!)
        newPostRef.setValue(["photoUrl": photoUrl, "caption": textView.text!])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func refactorClearPost() {
        self.textView.text = ""
        self.photo.image = UIImage(named: "placeholder-photo")
        self.selectedImage = nil
    }
    
}


extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage {
            selectedImage = image
           photo.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
