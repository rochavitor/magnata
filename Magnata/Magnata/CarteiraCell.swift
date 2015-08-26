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
    
    
 }
