//
//  ListOfBookByClassViewController.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 4/3/20.
//  Copyright © 2020 Sharif Rafi. All rights reserved.
//

import UIKit

class ListOfBookByClassViewController: UIViewController {

    
    @IBOutlet weak var listOfBooksNameByClassTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfBooksNameByClassTableView.delegate = self
        listOfBooksNameByClassTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
}

extension ListOfBookByClassViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListOfBooksByClassTableViewCell = listOfBooksNameByClassTableView.dequeueReusableCell(withIdentifier: "ListOfBooksByClass", for: indexPath) as! ListOfBooksByClassTableViewCell
        
         //cell.configureMethodForHomeTableViewCell( with: dataModelobject[indexPath.row])
         //cell.bookName.text = listDataModel[indexPath.row].category
         
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (144)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ReadOrDownloadViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}
