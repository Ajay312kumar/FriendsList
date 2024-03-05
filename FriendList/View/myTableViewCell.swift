//
//  myTableViewCell.swift
//  FriendList
//
//  Created by Ajay Kumar on 04/03/24.
//

import UIKit

class myTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var backImgView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
