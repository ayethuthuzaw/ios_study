//
//  TimeLineCollectionViewCell.swift
//  PhotoShare
//
//  Created by Aye Thu Thu Zaw on 2020/06/19.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class TimeLineCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
