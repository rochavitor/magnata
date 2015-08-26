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
    
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var quantityMinusButton: UIButton!
    @IBOutlet weak var quantityPlusButton: UIButton!
    @IBOutlet weak var totalQuantityLabel: UILabel!
    
    
    class var expandedHeight: CGFloat { get { return 100 } }
    class var defaultHeight:  CGFloat { get { return 60 } }


    
}
