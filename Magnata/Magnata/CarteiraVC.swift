//
//  ViewController.swift
//  Magnata
//
//  Created by Alexandre Katao on 8/20/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

class CarteiraVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var acoes = [Carteira]()
    var pending = false
    var selectedIndexPath : NSIndexPath?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTeams()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func carteira(sender: AnyObject) {
        pending = false
        loadTeams()
    }
    @IBAction func Pending(sender: AnyObject) {
        pending = true
        loadPending()
    }
    
    func loadTeams() {
        
        //Accessing the JSON.
        let filePath = NSBundle.mainBundle().pathForResource("Carteira", ofType: "json")
        var readError : NSError?
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        let json = JSON(data:data!)
        
        
        //Getting all the data and inserting in an array.
        acoes = [Carteira]()
        for (key : String, quest: JSON ) in json{
            var index = key.toInt()
            println(json[index!]["time"])
            println(json[index!]["valor_inicial"])
            acoes.append(Carteira(id: index!, name: String(stringInterpolationSegment : json[index!]["time"]), valor: String(stringInterpolationSegment : json[index!]["valor_atual"]), quantidade: String(stringInterpolationSegment : json[index!]["quantidade"]), variacao: String(stringInterpolationSegment : json[index!]["valorizacao"])))
        }
        
        tableView.reloadData()
    }
    
    
    func loadPending() {
        
        //Accessing the JSON.
        let filePath = NSBundle.mainBundle().pathForResource("CarteiraVenda", ofType: "json")
        var readError : NSError?
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        let json = JSON(data:data!)
        
        
        
        //Getting all the data and inserting in an array.
        acoes = [Carteira]()
        for (key : String, quest: JSON ) in json{
            var index = key.toInt()
            println(json[index!]["time"])
            println(json[index!]["valor_venda"])
            acoes.append(Carteira(id: index!, name: String(stringInterpolationSegment : json[index!]["time"]), valor: String(stringInterpolationSegment : json[index!]["valor_venda"]), quantidade: String(stringInterpolationSegment : json[index!]["quantidade"]), variacao: String(stringInterpolationSegment : json[index!]["valorizacao"])))
        }
        tableView.reloadData()
    }
    
    
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acoes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        if !pending {
            let cell = tableView.dequeueReusableCellWithIdentifier("carteiraCell", forIndexPath: indexPath) as! CarteiraCell
            cell.teamImage.image = UIImage(named: StringToSigla(acoes[row].name) as String)!
            cell.teamName.text = acoes[row].name
            cell.quantidade.text = acoes[row].quantidade + " ações"
            cell.valor.text = "R$ " + String(format: "%.2f", (acoes[row].valor as NSString).doubleValue)
            if (acoes[row].variacao as NSString).floatValue >= 0{
                cell.variacao.text = "+" + String(format: "%.2f", (acoes[row].variacao as NSString).doubleValue)
            } else {
                cell.variacao.text = "-" + String(format: "%.2f", (acoes[row].variacao as NSString).doubleValue)
            }
            
            cell.buyButton.layer.cornerRadius = 6
            
            return cell
        } else{
            let cell = tableView.dequeueReusableCellWithIdentifier("carteiraVendaCell", forIndexPath: indexPath) as! CarteiraVendaCell
            cell.teamImage.image = UIImage(named: StringToSigla(acoes[row].name) as String)!
            cell.teamName.text = acoes[row].name
            cell.valor.text = "R$ " + String(format: "%.2f", (acoes[row].valor as NSString).doubleValue)
            cell.quantidade.text = acoes[row].quantidade + " ações"
            
            return cell
        }
        
        
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        // expansao da celula
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        }
        else{
            selectedIndexPath = indexPath
        }
        
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        // fim expansao
        
        
        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//
//        let row = indexPath.row
//        println(acoes[row].quantidade)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CarteiraCell).watchFrameChanges()
    }

    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! CarteiraCell).ignoreFrameChanges()
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath == selectedIndexPath {
            return CarteiraCell.expandedHeight
        }
        else{
            return CarteiraCell.defaultHeight
        }
    }

    
    
    
    func StringToSigla(nome: NSString) -> NSString{
        switch(nome){
        case "Corinthians":
            return "COR"
        case "São Paulo":
            return "SAO"
        case "Sport":
            return "SPO"
        case "Cruzeiro":
            return "CRU"
        case "Santos":
            return "SAN"
        case "Flamengo":
            return "FLA"
        case "Fluminense":
            return "FLU"
        case "Atlético-PR":
            return "CAP"
        case "Atlético-MG":
            return "CAM"
        case "Avaí":
            return "AVA"
        case "Goiás":
            return "GOI"
        case "Grêmio":
            return "GRE"
        case "Internacional":
            return "INT"
        case "Ponte Preta":
            return "PON"
        case "Coritiba":
            return "CFC"
        case "Chapecoense":
            return "CHA"
        case "Vasco":
            return "VAS"
        case "Joinville":
            return "JOI"
        case "Palmeiras":
            return "PAL"
        default:
            return "ERROR"
        }
    }
}

public class Carteira {
    public var id: Int
    public var name: String
    public var valor: String
    public var quantidade: String
    public var variacao: String
    
    public init(id: Int, name: String, valor: String, quantidade: String, variacao: String) {
        self.id = id
        self.name = name
        self.valor = valor
        self.quantidade = quantidade
        self.variacao = variacao
    }
    
}


public class CarteiraVenda {
    public var id: Int
    public var name: String
    public var valor: String
    public var quantidade: String
    
    public init(id: Int, name: String, valor: String, quantidade: String) {
        self.id = id
        self.name = name
        self.valor = valor
        self.quantidade = quantidade
    }
    
}

