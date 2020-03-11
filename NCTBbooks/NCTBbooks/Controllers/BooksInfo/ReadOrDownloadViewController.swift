//
//  ReadOrDownloadViewController.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 3/3/20.
//  Copyright © 2020 Sharif Rafi. All rights reserved.
//

import UIKit

class ReadOrDownloadViewController: UIViewController {
    
    @IBOutlet weak var groupOfBooksName: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var selectedBooksImage: UIImageView!
    @IBOutlet weak var readButtonOutlet: UIButton!
    @IBOutlet weak var downloadButtonOutlet: UIButton!
    
    
    var bookImageString: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let img = UIImageView(image: UIImage(named: "imgpsh_fullsize_anim"))
//        img.contentMode = .scaleAspectFill
//        self.navigationController?.navigationBar.addSubview(img)
//        self.navigationController?.navigationBar.sendSubviewToBack(img)
        
        
        readButtonOutlet.layer.cornerRadius = 10
        readButtonOutlet.layer.borderWidth = 1
        readButtonOutlet.layer.borderColor = UIColor.green.cgColor
        
        downloadButtonOutlet.layer.cornerRadius = 10
        
        gettingBookImage()
    }
    
    func gettingBookImage() {
        let imageURL = URL(string: bookImageString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        UIImage.getImage(url: imageURL, completion: { (image) in
            self.selectedBooksImage.image  = image
        })
    }

    @IBAction func readButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("check this")
        let vc = storyboard.instantiateViewController(identifier: "PdfReaderViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func downloadButton(_ sender: Any) {
        
        guard let url = URL(string: "https://dl.bdebooks.com/Bangladeshi%20Writer/1.%20Humayun%20Ahmed/01%20Himu%20Series/04%20Parapar%20By%20Humayun%20Ahmed%20%5B1993%5D%20%5BBDeBooks.Com%5D.pdf") else { return }
                
        let urlSession = URLSession(configuration: .default, delegate: self as URLSessionDelegate, delegateQueue: OperationQueue())
                
            let downloadTask = urlSession.downloadTask(with: url)
                downloadTask.resume()
    }
    

}


    
extension ReadOrDownloadViewController:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
    }
}
