//
//  ListOfBooksNameTableViewCell.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 4/3/20.
//  Copyright © 2020 Sharif Rafi. All rights reserved.
//

import UIKit

class ListOfBooksNameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookLogo: UIImageView!
    @IBOutlet weak var sideImageLogo: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
