//
//  PhotoViewCell.swift
//  Instagram
//
//  Created by XXY on 16/3/6.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit

class PhotoViewCell: UITableViewCell {
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var caption: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
