//
//  FeedCell.swift
//  instagram
//
//  Created by Josh Olumese on 6/28/17.
//  Copyright © 2017 Josh Olumese. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var feedLabel: UILabel!
    
    @IBOutlet weak var feedPhoto: PFImageView!
    var instagramPost: PFObject! {
        didSet {
            self.feedPhoto.file = instagramPost["media"] as? PFFile
            self.feedPhoto.loadInBackground()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
