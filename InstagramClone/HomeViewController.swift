//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Erica on 5/6/19.
//  Copyright © 2019 Erica. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {


    
    @IBOutlet var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.estimatedRowHeight = 521
        tableView.rowHeight = UITableView.automaticDimension
       // loadPosts()
     
    }
    
//    func loadPosts() {
//        Database.database().reference().child("posts").observe(.childAdded) { (snapshot) in
//            if let dict = snapshot.value as? [String: Any] {
//                let newPost = Post.transformPost(dict: dict)
//                self.posts.append(newPost)
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        do {
        try Auth.auth().signOut()
        } catch let logOutError {
            print(logOutError)
        }
        
        let storyboard = UIStoryboard(name: "Intro", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "HomePostTableViewCell", for: indexPath) as! HomePostTableViewCell
        let post = posts[indexPath.row]
//        cell.captionLabel.text = post.caption
        cell1.postImageView.image = UIImage(named: post.photoUrl!)
//       // cell.nameLabel
//       // cell.

        return cell1
    }
}
