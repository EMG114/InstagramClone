//
//  Post.swift
//  InstagramClone
//
//  Created by Erica on 5/7/19.
//  Copyright © 2019 Erica. All rights reserved.
//

import Foundation

class Post {
    var caption: String?
    var photoUrl: String?

}

extension Post {
    static func transformPost(dict: [String: Any]) -> Post {
        let post = Post()
        post.caption = dict["caption"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        return post
    }
}
