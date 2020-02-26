//
//  ListViewController.swift
//  TabBarWithHomeListProfile
//
//  Created by Sharif Rafi on 25/2/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var listTbleView: UITableView!
    
    var titleArray = ["Title 1", "Title 2", "Title 3"]
    var sectionIsExpanded = [false, false, false]
    var numberOfActualSection = 4
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionIsExpanded[section] ? (1+numberOfActualSection) : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: headerTableViewCell = self.listTbleView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! headerTableViewCell
            
            cell.titleLbl.text = titleArray[indexPath.section]
            
            if sectionIsExpanded[indexPath.section]{
                cell.setExpanded()
            } else{
                cell.setCollapsed()
            }
            return cell
        } else {
            let cell: contentTableViewCell = self.listTbleView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! contentTableViewCell
            
            cell.contentLbl.text = "Section: \(indexPath.section); row \(indexPath.row)"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            sectionIsExpanded[indexPath.section] = !sectionIsExpanded[indexPath.section]
            
            tableView.reloadSections([indexPath.section], with: .automatic)
        }
    }


}

