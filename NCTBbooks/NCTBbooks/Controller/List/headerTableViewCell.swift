//
//  headerTableViewCell.swift
//  DesignedExpandableTableViewController
//
//  Created by Sharif Rafi on 25/2/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class headerTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setExpanded() {
        let down = UIImage(systemName: "chevron.down")
        statusBtn.setImage(down, for: .normal)
    }
    func setCollapsed(){
        let up = UIImage(systemName: "chevron.up")
        statusBtn.setImage(up, for: .normal)
    }

}
