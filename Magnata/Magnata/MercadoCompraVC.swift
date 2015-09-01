//
//  ViewControllerMercado.swift
//  Magnata
//
//  Created by Alexandre Katao on 8/21/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//


import UIKit

class MercadoCompraVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var acoes = [MercadoCompra]()
    var selectedIndexPath : NSIndexPath?
    var selectedRow = -1
    var valorCash = 740.65
    var valorPatrimonio = 1174.10

    
    
    @IBOutlet weak var cash: UILabel!
    @IBOutlet weak var patrimonio: UILabel!
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTeams()
        
        cash.text = "R$ " + String(format: "%.2f", valorCash)
        patrimonio.text = "R$ " + String(format: "%.2f", valorPatrimonio)

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTeams() {
        
        //Accessing the JSON.
        let filePath = NSBundle.mainBundle().pathForResource("MercadoCompraAcoes", ofType: "json")
        var readError : NSError?
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        let json = JSON(data:data!)
        
        
        //Getting all the data and inserting in an array.
        for (key : String, quest: JSON ) in json{
            var index = key.toInt()
            println(json[index!]["time"])
            println(json[index!]["usuario"])
            acoes.append(MercadoCompra(id: index!, username: String(stringInterpolationSegment : json[index!]["usuario"]), valor: String(stringInterpolationSegment : json[index!]["valor"]), quantidade: String(stringInterpolationSegment : json[index!]["quantidade"])))
        }
    }
    
    
    // MARK:  UITableView Data Source Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acoes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mercadoCompraCell", forIndexPath: indexPath) as! MercadoCompraCell
        
        let row = indexPath.row
        
        cell.username.text = acoes[row].username
        cell.quantidade.text = acoes[row].quantidade + " ações"
        cell.valor.text = "R$ " + String(format: "%.2f", (acoes[row].valor as NSString).doubleValue)
        cell.buyButton.layer.cornerRadius = 6
        
        cell.qtdCompraTextField.text = acoes[row].quantidade

        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        
        cell.buyButton.tag = row
        cell.buyButton.addTarget(self, action: "Comprar:", forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedIndexPath = indexPath
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        if row == selectedRow{
            selectedRow = -1
        } else{
            selectedRow = row
        }
        println(acoes[row].quantidade)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath == selectedIndexPath {
            if selectedRow == indexPath.row {
                return MercadoCompraCell.defaultHeight
            } else{
                return MercadoCompraCell.expandedHeight
            }
        }
        else{
            return MercadoCompraCell.defaultHeight
        }
        
    }
    
    @IBAction func Comprar(sender: UIButton){
        
        var uiAlert = UIAlertController(title: "Alerta", message: "Deseja comprar as ações?", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { action in
            println("Click of default button")
//            self.pendentes.append(self.minha[sender.tag])
            println(sender.tag)
            self.acoes.removeAtIndex(sender.tag)
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancelar", style: .Cancel, handler: { action in
            println("Click of cancel button")
        }))
        
        
        
        //println(String(sender.tag))
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
            return "JEC"
        case "Figueirense":
            return "FIG"
        case "Palmeiras":
            return "PAL"
        default:
            return "ERROR"
        }
    }
    
    
    @IBAction func onCancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

public class MercadoCompra {
    public var id: Int
    public var username: String
    public var valor: String
    public var quantidade: String
    
    public init(id: Int, username: String, valor: String, quantidade: String) {
        self.id = id
        self.username = username
        self.valor = valor
        self.quantidade = quantidade
    }
}
