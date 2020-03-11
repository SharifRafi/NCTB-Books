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
    
    var dataModel = [ResponseForList]()
    var subjectModel = [BookSubject]()

    var listCounter:Int?
    var sectionIsExpanded = [false, false, false]
    //var sectionIsExpanded = [Bool]()
    //var numberOfActualSection = 4
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataFromServer()
    }
    
    func getDataFromServer(){
        guard let url = URL(string: "http://103.192.157.61:84/api/Book/GetAllBookListGroupBySubject") else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, error == nil {
                    //print("data=data")
                    do {
                        let json = try JSONDecoder().decode(ResponseForList.self, from: data)
                        //print(json)
                        
                       // print(json.payload?.count)
                        
                        for i in 0...(json.payload!.count) - 1{
                        self.subjectModel.append(json.payload![i])
                        }
                        
                        //print(self.bookCategoryObj)
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
        return subjectModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionIsExpanded[section] ? (1 + (subjectModel[section].books?.count ?? 0)) : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell: HeaderTableViewCell = self.listTbleView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderTableViewCell
            
            cell.titleLbl.text = subjectModel[indexPath.section].subject
            //sectionIsExpanded[indexPath.section] = subjectModel[indexPath.section].isCollups
            //cell.configureMethodForListTableViewCell( with: dataModel[indexPath.section])
            
            if sectionIsExpanded[indexPath.section]{
                cell.setExpanded()
            } else{
                cell.setCollapsed()
            }
            
            
            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            return cell
        }
        else {
            let cell: ContentTableViewCell = self.listTbleView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ContentTableViewCell
            
            
            cell.contentLbl.text = subjectModel[indexPath.section].books![indexPath.row - 1].name ?? ""
           
            let imgString = subjectModel[indexPath.section].books![indexPath.row - 1].imageURL ?? ""
            let imgUrlString = URL(string: imgString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
            
            UIImage.getImage(url: imgUrlString, completion: { (image) in
                
                cell.bookImage.image = image
            })
            //cell.bookImage.setimage(urlString: imgString)
            
            
            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInRow section: Int) -> CGFloat {
    return 8.0
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row == 0 {
            return (view.frame.height / 11)
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
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadOrDownloadViewController") as! ReadOrDownloadViewController
            self.navigationController?.pushViewController(vc, animated: true)
            let listImageString = subjectModel[indexPath.section].books![indexPath.row - 1].imageURL ?? ""
            vc.bookImageString = listImageString
            
            
//            let vc:ReadOrDownloadViewController = storyboard.instantiateViewController(identifier: "ReadOrDownloadViewController") as! ReadOrDownloadViewController
//            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
