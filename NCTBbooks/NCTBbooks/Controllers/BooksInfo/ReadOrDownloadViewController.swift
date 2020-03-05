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

    var bookImageString: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImageView(image: UIImage(named: "imgpsh_fullsize_anim"))
        img.contentMode = .scaleAspectFill
        self.navigationController?.navigationBar.addSubview(img)
        self.navigationController?.navigationBar.sendSubviewToBack(img)
        
        gettingBookImage()
    }
    
    func gettingBookImage() {
        let imageURL = URL(string: bookImageString)
        UIImage.getImage(url: imageURL!) { (bookImage) in
        self.selectedBooksImage.image = bookImage
        }
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
