//
//  HomePostTableViewCell.swift
//  InstagramClone
//
//  Created by Erica on 5/8/19.
//  Copyright © 2019 Erica. All rights reserved.
//

import UIKit

class HomePostTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var postImageView: UIImageView!
    
    @IBOutlet var likeImageView: UIImageView!
    
    @IBOutlet var commentImageView: UIImageView!
    
    @IBOutlet var shareImageView: UIImageView!
    
    @IBOutlet var likeCountButton: UIButton!
    
    @IBOutlet var captionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
