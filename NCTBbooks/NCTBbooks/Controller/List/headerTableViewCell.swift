//
//  headerTableViewCell.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 25/2/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

var listCounter:Int = 0
var listNameArray = [String]()
var listImageArray = [String]()

class headerTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        print()
        super.awakeFromNib()
        //listCounter = 0
        //listNameArray.removeAll()
        //listImageArray.removeAll()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

     public func configureMethodForListTableViewCell(with json:CategoryClassName){
         listCounter = Int(json.books?.count ?? 0)
         print(listCounter)
         for i in 0...listCounter-1{
             listNameArray.append(json.books![i].name ?? "")
             listImageArray.append(json.books![i].image ?? "")
         }
     }
    
    func setExpanded() {
        let down = UIImage(systemName: "chevron.down")
        statusBtn.setImage(down, for: .normal)
    }
    func setCollapsed(){
        let up = UIImage(systemName: "chevron.right")
        statusBtn.setImage(up, for: .normal)
    }

}
