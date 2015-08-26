//
//  MercadoCompraCell.swift
//  Magnata
//
//  Created by Alexandre Katao on 8/21/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

class MercadoCompraTimeCell: UITableViewCell {
    

    @IBOutlet weak var grafico: UIImageView!
    class var expandedHeight: CGFloat { get { return 300 } }
    class var defaultHeight:  CGFloat { get { return 60 } }
    
    func checkHeight() {
        
        grafico.hidden = (frame.size.height < MercadoCompraCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        checkHeight()
    }
    
    func ignoreFrameChanges() {
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
}
