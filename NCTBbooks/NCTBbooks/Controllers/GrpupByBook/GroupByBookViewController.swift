//
//  GroupByBookViewController.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 4/3/20.
//  Copyright © 2020 Sharif Rafi. All rights reserved.
//

import UIKit

class GroupByBookViewController: UIViewController {

    @IBOutlet weak var booksNameTableView: UITableView!
    var listDataModel = [CategoryClassName]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        booksNameTableView.dataSource = self
        booksNameTableView.delegate = self
        // Do any additional setup after loading the view.
        
        getListDataFromServer()
    }
    
    func getListDataFromServer() {
        
        guard let url = URL(string: "https://api.myjson.com/bins/bh29k") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    let json = try JSONDecoder().decode([CategoryClassName].self, from: data)
                    for data in json {
                        //print(data)
                        self.listDataModel.append(data)
                    }
                    DispatchQueue.main.async {
                        self.booksNameTableView.reloadData()
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    


}

extension GroupByBookViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListOfBooksNameTableViewCell = booksNameTableView.dequeueReusableCell(withIdentifier: "ListOfBooksName", for: indexPath) as! ListOfBooksNameTableViewCell
        
         //cell.configureMethodForHomeTableViewCell( with: dataModelobject[indexPath.row])
         cell.bookName.text = listDataModel[indexPath.row].category
         
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (booksNameTableView.frame.height / 11)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ListOfBookByClassViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
