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


    override func viewDidLoad() {
        super.viewDidLoad()

        let img = UIImageView(image: UIImage(named: "imgpsh_fullsize_anim"))
        img.contentMode = .scaleAspectFill
        self.navigationController?.navigationBar.addSubview(img)
        self.navigationController?.navigationBar.sendSubviewToBack(img)
    }
    
    @IBAction func readButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("check this")
        let vc = storyboard.instantiateViewController(identifier: "PdfReaderViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func downloadButton(_ sender: Any) {
    }
    

}
