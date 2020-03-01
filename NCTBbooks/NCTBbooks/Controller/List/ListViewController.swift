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
    var dataModel = [CategoryClassName]()

    var listCounter:Int?
    var listNameArray = [String]()
    var listImageArray = [String]()
    var sectionIsExpanded = [false, false, false]
    var numberOfActualSection = 4
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataFromServer()
    }
    
    func getDataFromServer(){
        guard let url = URL(string: "https://api.myjson.com/bins/bh29k") else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, error == nil {
                    //print("data=data")
                    do {
                        let json = try JSONDecoder().decode([CategoryClassName].self, from: data)
                        //print("Print",json[0].books?[0] as Any)
                        for data in json {
                            //print(data)
                            self.dataModel.append(data)
                        }
                      //  print(self.dataModelobject)
                        DispatchQueue.main.async {
                            self.listTbleView.reloadData()
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
        
  
    public func configureMethodForListTableViewCell(with json:CategoryClassName){
        listCounter = Int(json.books?.count ?? 0)
        for i in 0...listCounter!-1{
            listNameArray.append(json.books![i].name ?? "")
            listImageArray.append(json.books![i].image ?? "")
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionIsExpanded[section] ? (1+(listCounter ?? 0)) : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: headerTableViewCell = self.listTbleView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! headerTableViewCell
            
            configureMethodForListTableViewCell( with: dataModel[indexPath.row])
            cell.titleLbl.text = dataModel[indexPath.section].category
            
            if sectionIsExpanded[indexPath.section]{
                cell.setExpanded()
            } else{
                cell.setCollapsed()
            }
            return cell
        }
        else {
            let cell: contentTableViewCell = self.listTbleView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! contentTableViewCell
            
            let imgUrlString = listImageArray[indexPath.row]
            cell.bookImage.setimage(urlString: imgUrlString)
            cell.contentLbl.text = listNameArray[indexPath.row]
            
            //cell.contentLbl.text = "Section: \(indexPath.section); row \(indexPath.row)"
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
         if indexPath.row == 0 {
            return (view.frame.height / 12)
        }
        
         else{
            return (view.frame.height / 7)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            sectionIsExpanded[indexPath.section] = !sectionIsExpanded[indexPath.section]
            
            tableView.reloadSections([indexPath.section], with: .automatic)
        }
    }
}
