//
//  PdfReaderViewController.swift
//  NCTBbooks
//
//  Created by Sharif Rafi on 3/3/20.
//  Copyright © 2020 Sharif Rafi. All rights reserved.
//

import UIKit
import PDFKit

class PdfReaderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.setNavigationBarHidden(<#T##hidden: Bool##Bool#>, animated: <#T##Bool#>)
       // self.navigationController?. = nil
        
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let pdfView = PDFView()
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        //pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pdfView.autoScales = true
        
        guard let path = Bundle.main.url(forResource: "Ubhochor Manush by Alexander Belyaev", withExtension: "pdf") else { return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
        
    }



}
