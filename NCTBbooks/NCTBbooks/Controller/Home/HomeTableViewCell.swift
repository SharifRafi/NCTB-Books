import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    
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
    
    public func configureMethodForHomeTableViewCell(with json:CategoryClassName){
        counter = Int(json.books?.count ?? 0)
        //print("counter section", json.books?.count)
        for i in 0...counter!-1{

            nameArray.append(json.books![i].name ?? "")
            //imageArray.append(json.books![i].image ?? "")
        }
    }
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return counter ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var v:Int = indexPath.row
        //print(indexPath.row)
        let cell: HomeCollectionViewCell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.homeCollectionLabel.text = nameArray[indexPath.row]
        
        //cell.homeCollectionImageView.image = UIImage(contentsOfFile: imageArray[indexPath.row])
        
       // cell.homeCollectionImageView.layer.cornerRadius = 50
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: homeCollectionView.frame.width/2, height: homeCollectionView.frame.height)
    }
}
