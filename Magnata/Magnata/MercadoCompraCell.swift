//
//  MercadoCompraCell.swift
//  Magnata
//
//  Created by Alexandre Katao on 8/21/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

class MercadoCompraCell: UITableViewCell {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var valor: UILabel!
    @IBOutlet weak var quantidade: UILabel!
    @IBOutlet weak var qtdCompraTextField: UITextField!
    
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var quantityMinusButton: UIButton!
    @IBOutlet weak var quantityPlusButton: UIButton!
    class var expandedHeight: CGFloat { get { return 80 } }
    class var defaultHeight:  CGFloat { get { return 40 } }
    
    func checkHeight() {
        qtdCompraTextField.hidden = (frame.size.height < MercadoCompraCell.expandedHeight)
        quantityMinusButton.hidden = (frame.size.height < MercadoCompraCell.expandedHeight)
        quantityPlusButton.hidden = (frame.size.height < MercadoCompraCell.expandedHeight)
        buyButton.hidden = (frame.size.height < MercadoCompraCell.expandedHeight)
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
