import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    //    let imageAlita: [UIImage] = [
    //        UIImage(named: "alita01")!,
    //        UIImage(named: "alita02")!,
    //        UIImage(named: "alita03")!,
    //        UIImage(named: "alita04")!
    //    ]
    //    let imageIronman: [UIImage] = [
    //        UIImage(named: "ironman-1")!,
    //        UIImage(named: "ironman-2")!,
    //        UIImage(named: "ironman-3")!,
    //        UIImage(named: "ironman-4")!,
    //        UIImage(named: "ironman-5")!
    //    ]
    //    let imageSuperman: [UIImage] = [
    //        UIImage(named: "supermen-1")!,
    //        UIImage(named: "supermen-2")!,
    //        UIImage(named: "supermen-3")!,
    //        UIImage(named: "supermen-4")!
    //    ]
    //    let imageBatman: [UIImage] = [
    //        UIImage(named: "batman-2")!,
    //        UIImage(named: "batman-3")!,
    //        UIImage(named: "batman-4")!,
    //        UIImage(named: "batman-5")!
    //
    //    ]
    
    //    let imageArr : [[UIImage]] = [
    //            [
    //                UIImage(named: "alita01")!,
    //                UIImage(named: "alita02")!,
    //                UIImage(named: "alita03")!,
    //                UIImage(named: "alita04")!],
    //            [
    //                UIImage(named: "ironman-1")!,
    //                UIImage(named: "ironman-2")!,
    //                UIImage(named: "ironman-3")!,
    //                UIImage(named: "ironman-4")!,
    //                UIImage(named: "ironman-5")!],
    //            [
    //                UIImage(named: "supermen-1")!,
    //                UIImage(named: "supermen-2")!,
    //                UIImage(named: "supermen-3")!,
    //                UIImage(named: "supermen-4")!]
    //    ]
    
    var counter:Int?
    var nameArray = [String]()
    var imageArray = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configureMethodForHomeTableViewCell(with json:HomeModel){
        counter = Int(json.insideModel?.count ?? 0)
        //print(counter)
        for i in 0...counter!-1{
            nameArray.append(json.insideModel![i].name ?? "")
            imageArray.append(json.insideModel![i].image!)
        }
    }
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return counter ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var v:Int = indexPath.row
        print(indexPath.row)
        let cell: HomeCollectionViewCell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.homeCollectionLabel.text = nameArray[indexPath.row]
        
        cell.homeCollectionImageView.image = imageArray[indexPath.row]
        
        cell.homeCollectionImageView.layer.cornerRadius = 50
        
        
        return cell
    }
}
