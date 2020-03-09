//
//  HomeViewController.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 25/2/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    var dataModelobject = [ResponseForHome]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "NCTB BOOKS"
        let img = UIImageView(image: UIImage(named: "imgpsh_fullsize_anim"))
        img.contentMode = .scaleAspectFill
        self.navigationController?.navigationBar.addSubview(img)
        self.navigationController?.navigationBar.sendSubviewToBack(img)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        gettingDataFromServer()
    }
    
    func gettingDataFromServer() {
        
        guard let url = URL(string: "http://103.192.157.61:84/api/Book/GetAllBookListGroupByCategory") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    let json = try JSONDecoder().decode([ResponseForHome].self, from: data)
                    print(json)
                    for data in json {
                        //print(data)
                        self.dataModelobject.append(data)
                    }
                    DispatchQueue.main.async {
                        self.homeTableView.reloadData()
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataModelobject.count)
        return dataModelobject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: HomeTableViewCell = homeTableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
       
//        cell.configureMethodForHomeTableViewCell( with: dataModelobject[indexPath.row])
//        cell.categoryLabel.text = dataModelobject[indexPath.row].category
        //cell.closure(Int){
            
        //}
        
        cell.closure = {
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadOrDownloadViewController") as! ReadOrDownloadViewController
            self.navigationController?.pushViewController(vc, animated: true)

            let imageString = cell.imageArray[indexPath.row]

            vc.bookImageString = imageString

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (homeTableView.frame.height / 2.6)
    }
}
