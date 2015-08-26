//
//  CarteiraCell.swift
//  Magnata
//
//  Created by Thiago Coradi on 8/20/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

class CarteiraCell: UITableViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var quantidade: UILabel!
    @IBOutlet weak var valor: UILabel!
    @IBOutlet weak var variacao: UILabel!
    
    @IBOutlet weak var valueTexto: UILabel!
    @IBOutlet weak var qntd: UILabel!
    @IBOutlet weak var grafico: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var quantityPlusButton: UIButton!
    @IBOutlet weak var quantityMinusButton: UIButton!
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBOutlet weak var valuePlusButton: UIButton!
    @IBOutlet weak var valueMinusButton: UIButton!
    @IBOutlet weak var valueTextField: UITextField!
    

    
    class var expandedHeight: CGFloat { get { return 280 } }
    class var defaultHeight:  CGFloat { get { return 60 } }
    
    func checkHeight() {
        quantityTextField.hidden = (frame.size.height < CarteiraCell.expandedHeight)
        //quantityMinusButton.hidden = (frame.size.height < CarteiraCell.expandedHeight)
        //quantityPlusButton.hidden = (frame.size.height < CarteiraCell.expandedHeight)
        
        valueTextField.hidden = (frame.size.height < CarteiraCell.expandedHeight)
        //valueMinusButton.hidden = (frame.size.height < CarteiraCell.expandedHeight)
        //valuePlusButton.hidden = (frame.size.height < CarteiraCell.expandedHeight)
        grafico.hidden = (frame.size.height < CarteiraCell.expandedHeight)
        
        valueTexto.hidden = (frame.size.height < CarteiraCell.expandedHeight)
        qntd.hidden = (frame.size.height < CarteiraCell.expandedHeight)
        
        buyButton.hidden = (frame.size.height < CarteiraCell.expandedHeight)
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
