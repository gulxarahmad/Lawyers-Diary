//
//  Laws.swift
//  lawyers
//
//  Created by hst on 02/05/2020.
//  Copyright © 2020 hst. All rights reserved.
//

import UIKit
import PDFKit
class Laws: UIViewController {

    @IBOutlet weak var imgThumbnail3: UIImageView!
    @IBOutlet weak var imgThumbnail2: UIImageView!
    @IBOutlet weak var imgThumbnail1: UIImageView!
    @IBOutlet weak var pdfView: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = Bundle.main.path(forResource: "pdf", ofType: "pdf"){//read resource name:pdf.pdf
            let url = URL(fileURLWithPath: path)
            if let pdfDocument = PDFDocument(url:url){
                pdfView.autoScales = true
                pdfView.displayMode = .singlePageContinuous
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
                
                captureThumbnail1(pdfDocument: pdfDocument)
            }
            
        }
    }
    
    func captureThumbnail1(pdfDocument:PDFDocument){
        if let page1 = pdfDocument.page(at: 1){
            imgThumbnail1.image = page1.thumbnail(of: CGSize(width:imgThumbnail1.frame.size.width,height: imgThumbnail1.frame.size.height), for: .artBox)
        }
        if let page2 = pdfDocument.page(at: 1){
            imgThumbnail2.image = page2.thumbnail(of: CGSize(width:imgThumbnail2.frame.size.width,height: imgThumbnail2.frame.size.height), for: .artBox)
        }
        if let page3 = pdfDocument.page(at: 1){
            imgThumbnail3.image = page3.thumbnail(of: CGSize(width:imgThumbnail3.frame.size.width,height: imgThumbnail3.frame.size.height), for: .artBox)
        }
    }

}

