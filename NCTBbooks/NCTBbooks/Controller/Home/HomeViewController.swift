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
   var bookCategoryObj = [BookCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "NCTB BOOKS"
        
//        let img = UIImageView(image: UIImage(named: "imgpsh_fullsize_anim"))
//        img.contentMode = .scaleAspectFill
//        self.navigationController?.navigationBar.addSubview(img)
//        self.navigationController?.navigationBar.sendSubviewToBack(img)
//        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        gettingDataFromServer()
    }
    
    func gettingDataFromServer() {
        
        guard let url = URL(string: "http://103.192.157.61:84/api/Book/GetAllBookListGroupByCategory") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    let json = try JSONDecoder().decode(ResponseForHome.self, from: data)
                    //print(json)
                    
                   // print(json.payload?.count)
                    
                    for i in 0...(json.payload!.count) - 1{
                    self.bookCategoryObj.append(json.payload![i])
                    }
                    
                    //print(self.bookCategoryObj)
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
        //print(bookCategoryObj.count)
        return bookCategoryObj.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: HomeTableViewCell = homeTableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell

        cell.configureMethodForHomeTableViewCell( with: bookCategoryObj[indexPath.row])
        cell.categoryLabel.text = bookCategoryObj[indexPath.row].category

        cell.closure = { indexPathRow in
            
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReadOrDownloadViewController") as! ReadOrDownloadViewController
            self.navigationController?.pushViewController(vc, animated: true)
            let imageString = cell.imageArray[indexPathRow]
            vc.bookImageString = imageString
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (homeTableView.frame.height / 2.2)
    }
}
