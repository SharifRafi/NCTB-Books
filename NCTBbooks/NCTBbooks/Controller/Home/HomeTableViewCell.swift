//
//  HomeViewController.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 25/2/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
   var myViewController: HomeViewController!
    
    var closure: (() -> Void)?
    
    var counter:Int?
    var nameArray = [String]()
    var imageArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configureMethodForHomeTableViewCell(with json:ResponseForHome){
//        counter = Int(json.books?.count ?? 0)
//        //print("counter section", json.books?.count)
//        for i in 0...counter!-1{
//
//            nameArray.append(json.books![i].name ?? "")
//            imageArray.append(json.books![i].imageURL ?? "")
//        }
    }
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return counter ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        let imageUrlString = imageArray[indexPath.row]
        cell.homeCollectionImageView.setimage(urlString: imageUrlString)
        
        cell.homeCollectionLabel.text = nameArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.bounds.size.width / 2.8), height: (250))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        closure?()
    }
}

//Not Needed
extension HomeTableViewCell{
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}


extension UIImageView {
    
    public func setimage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let theTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: response)
                }
            }
        }
        theTask.resume()
    }
}
