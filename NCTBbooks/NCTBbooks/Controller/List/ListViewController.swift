//
//  ListViewController.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 25/2/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTbleView: UITableView!
    var dataModel = [CategoryClassName]()

    var listCounter:Int?
    var sectionIsExpanded = [false, false, false]
    var numberOfActualSection = 4
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataFromServer()
    }
    
    func getDataFromServer(){
        guard let url = URL(string: "https://api.myjson.com/bins/1a2xl2") else { return }
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
        
  
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionIsExpanded[section] ? (1 + (dataModel[section].books?.count ?? 0)) : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell: headerTableViewCell = self.listTbleView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! headerTableViewCell
            
            //configureMethodForListTableViewCell( with: dataModel[indexPath.row])
            cell.titleLbl.text = dataModel[indexPath.section].category
            //cell.configureMethodForListTableViewCell( with: dataModel[indexPath.section])
            
            if sectionIsExpanded[indexPath.section]{
                cell.setExpanded()
            } else{
                cell.setCollapsed()
            }
            
            
            //cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
        }
        else {
            let cell: contentTableViewCell = self.listTbleView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! contentTableViewCell
            
            
            cell.contentLbl.text = dataModel[indexPath.section].books![indexPath.row - 1].name ?? ""
            print(dataModel[indexPath.section].books![indexPath.row - 1].name ?? "")
            let imgString = dataModel[indexPath.section].books![indexPath.row - 1].image ?? ""
            cell.bookImage.setimage(urlString: imgString)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2.0
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row == 0 {
            return (view.frame.height / 15)
        }
         else{
            return (view.frame.height / 7)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(sectionIsExpanded.count)
        if indexPath.row == 0 {
            for i in 0...sectionIsExpanded.count-1{
                if i == indexPath.section{
                    sectionIsExpanded[indexPath.section] = !sectionIsExpanded[indexPath.section]
                    tableView.reloadSections([indexPath.section], with: .automatic)
                }
                else{
                    sectionIsExpanded[i] = false
                    //tableView.reloadSections([i], with: .automatic)
                }
                tableView.reloadSections([i], with: .automatic)
            }
        }
            
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc:ReadOrDownloadViewController = storyboard.instantiateViewController(identifier: "ReadOrDownloadViewController") as! ReadOrDownloadViewController
            //vc.groupOfBooksName.text = 
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
