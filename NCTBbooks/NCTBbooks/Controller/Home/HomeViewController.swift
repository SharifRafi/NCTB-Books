import UIKit

struct InsideModel{
    var name:String?
    var image:UIImage?
}
struct HomeModel {
    var sectionName:String?
    var insideModel:[InsideModel]?
}

class HomeViewController: UIViewController {

    var homeObject:[HomeModel] = [
        HomeModel(sectionName:"section-1",
        insideModel:
            [InsideModel(name:"IronMan", image:#imageLiteral(resourceName: "ironman-2")),
             InsideModel(name:"IronMan", image:#imageLiteral(resourceName: "ironman-1")),
             InsideModel(name:"IronMan", image:#imageLiteral(resourceName: "ironman-4")),
             InsideModel(name:"IronMan", image:#imageLiteral(resourceName: "ironman-3")),
             InsideModel(name:"IronMan", image:#imageLiteral(resourceName: "ironman-5"))]),
        ////////////////////////////////////////
        HomeModel(sectionName:"section-2", insideModel: [InsideModel(name:"BadMan", image:#imageLiteral(resourceName: "batman-2")),
             InsideModel(name:"Bondo", image:#imageLiteral(resourceName: "batman-3")),
             InsideModel(name:"Bondo", image:#imageLiteral(resourceName: "batman-5")),
             InsideModel(name:"olos", image:#imageLiteral(resourceName: "batman-4"))]),
        
        HomeModel(sectionName:"section-3", insideModel: [InsideModel(name:"BadMan", image:#imageLiteral(resourceName: "supermen-4")),
             InsideModel(name:"Bondo", image:#imageLiteral(resourceName: "supermen-2")),
             InsideModel(name:"Bondo", image:#imageLiteral(resourceName: "supermen-1")),
             InsideModel(name:"olos", image:#imageLiteral(resourceName: "supermen-3"))]),
        
        HomeModel(sectionName:"section-4", insideModel: [InsideModel(name:"BadMan", image:#imageLiteral(resourceName: "alita04")),
             InsideModel(name:"Bondo", image:#imageLiteral(resourceName: "alita03")),
             InsideModel(name:"Bondo", image:#imageLiteral(resourceName: "alita01")),
             InsideModel(name:"olos", image:#imageLiteral(resourceName: "alita02"))])
                                  
   ]

    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: HomeTableViewCell = homeTableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        cell.configureMethodForHomeTableViewCell( with: homeObject[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height / 4.0)
    }
}
