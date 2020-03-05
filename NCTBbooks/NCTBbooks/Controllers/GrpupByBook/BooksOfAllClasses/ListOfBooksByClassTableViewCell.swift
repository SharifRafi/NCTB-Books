//
//  ListOfBooksByClassTableViewCell.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 4/3/20.
//  Copyright © 2020 Sharif Rafi. All rights reserved.
//

import UIKit

class ListOfBooksByClassTableViewCell: UITableViewCell {

    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var booksImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
