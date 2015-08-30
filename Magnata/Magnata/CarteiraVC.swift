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
    var minha = [Carteira]()
    var pendentes = [Carteira]()
    var pending = false
    var selectedIndexPath : NSIndexPath?
    var selectedRow = -1
    var valorCash = 740.65
    
    @IBOutlet weak var cash: UILabel!
    @IBOutlet weak var patrimonio: UILabel!
    @IBOutlet weak var minhas: UIButton!
    @IBOutlet weak var pendente: UIButton!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTeams()
        loadPending()
        acoes = minha
        
        minhas.layer.cornerRadius = 4
        pendente.layer.cornerRadius = 4
        
        minhas.layer.borderWidth = 1
        minhas.layer.borderColor = UIColor.whiteColor().CGColor
        pendente.layer.borderWidth = 1
        pendente.layer.borderColor = UIColor.whiteColor().CGColor
        
        var valorPatrimonio = 0.0
        var i = 0
        
        for i ; i < minha.count; i++ {
            valorPatrimonio += (minha[i].valor as NSString).doubleValue
        }
        
        i = 0
        for i ; i < pendentes.count; i++ {
            valorPatrimonio += (pendentes[i].valor as NSString).doubleValue
        }
        
        
        patrimonio.text = "R$ " + String(format: "%.2f", valorPatrimonio)
        
        cash.text = "R$ " + String(format: "%.2f", valorCash)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func carteira(sender: AnyObject) {
        minhas.backgroundColor = UIColor.darkGrayColor()
        pendente.backgroundColor = UIColor.clearColor()
        selectedRow = -1
        selectedIndexPath = NSIndexPath()
        pending = false
        acoes = minha
        tableView.reloadData()
    }
    @IBAction func Pending(sender: AnyObject) {
        minhas.backgroundColor = UIColor.clearColor()
        pendente.backgroundColor = UIColor.darkGrayColor()
        pending = true
        selectedRow = -1
        selectedIndexPath = NSIndexPath()
        acoes = pendentes
        tableView.reloadData()
    }
    
    func loadTeams() {
        
        if minha.count == 0{
            //Accessing the JSON.
            let filePath = NSBundle.mainBundle().pathForResource("Carteira", ofType: "json")
            var readError : NSError?
            let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
            let json = JSON(data:data!)
        
        
            //Getting all the data and inserting in an array.
            for (key : String, quest: JSON ) in json{
                var index = key.toInt()
                println(json[index!]["time"])
                println(json[index!]["valor_inicial"])
                minha.append(Carteira(id: index!, name: String(stringInterpolationSegment : json[index!]["time"]), valor: String(stringInterpolationSegment : json[index!]["valor_atual"]), quantidade: String(stringInterpolationSegment : json[index!]["quantidade"]), variacao: String(stringInterpolationSegment : json[index!]["valorizacao"])))
            }
        }
    }
    
    
    func loadPending() {
        
        
        if pendentes.count == 0{
            //Getting all the data and inserting in an array.
            //Accessing the JSON.
            let filePath = NSBundle.mainBundle().pathForResource("CarteiraVenda", ofType: "json")
            var readError : NSError?
            let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
            let json = JSON(data:data!)
            
            for (key : String, quest: JSON ) in json{
                var index = key.toInt()
                println(json[index!]["time"])
                println(json[index!]["valor_venda"])
                pendentes.append(Carteira(id: index!, name: String(stringInterpolationSegment : json[index!]["time"]), valor: String(stringInterpolationSegment : json[index!]["valor_venda"]), quantidade: String(stringInterpolationSegment : json[index!]["quantidade"]), variacao: String(stringInterpolationSegment : json[index!]["valorizacao"])))
            }
        }
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
        
        var calc = CalculoVariacao()
        
        var variacao_time_porcentagem = calc.performCalculation(StringToSigla(acoes[row].name) as String)
        
        if !pending {
            let cell = tableView.dequeueReusableCellWithIdentifier("carteiraCell", forIndexPath: indexPath) as! CarteiraCell
            cell.teamImage.image = UIImage(named: StringToSigla(acoes[row].name) as String)!
            cell.teamName.text = acoes[row].name
            if acoes[row].quantidade.toInt() <= 1 {
                cell.quantidade.text = acoes[row].quantidade + " ação"
            } else {
                cell.quantidade.text = acoes[row].quantidade + " ações"
            }
            
            if variacao_time_porcentagem >= 0{
                //cell.variacao.textColor = UIColor(red: 34.0, green: 246.0, blue: 22.0, alpha: 1.0)
                cell.variacao.textColor = UIColor.greenColor()
                cell.variacao.text = "+" + String(format: "%.2f", variacao_time_porcentagem) + "%"
            } else {
                //cell.variacao.textColor = UIColor(red: 255, green: 43, blue: 57, alpha: 1.0)
                cell.variacao.textColor = UIColor.redColor()
                cell.variacao.text = String(format: "%.2f", variacao_time_porcentagem) + "%"
            }
            
            cell.valor.text = "R$ " + String(format: "%.2f", (acoes[row].valor as NSString).doubleValue * ((variacao_time_porcentagem/100) + 1))
            
            cell.quantityTextField.text = acoes[row].quantidade
            cell.valueTextField.text = "R$ " + String(format: "%.2f", (acoes[row].valor as NSString).doubleValue * ((variacao_time_porcentagem/100) + 1))
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            
            cell.buyButton.layer.cornerRadius = 6
            
            cell.buyButton.tag = row
            cell.buyButton.addTarget(self, action: "Vender:", forControlEvents: .TouchUpInside)
            
            return cell
        } else{
            let cell = tableView.dequeueReusableCellWithIdentifier("carteiraVendaCell", forIndexPath: indexPath) as! CarteiraVendaCell
            cell.teamImage.image = UIImage(named: StringToSigla(acoes[row].name) as String)!
            cell.teamName.text = acoes[row].name
            cell.valor.text = "R$ " + String(format: "%.2f", (acoes[row].valor as NSString).doubleValue * ((variacao_time_porcentagem/100) + 1))
            if acoes[row].quantidade.toInt() <= 1 {
                cell.quantidade.text = acoes[row].quantidade + " ação"
            } else {
                cell.quantidade.text = acoes[row].quantidade + " ações"
            }
            
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            
            return cell
        }
        
        
    }
    
    @IBAction func Vender(sender: UIButton){
        
        var uiAlert = UIAlertController(title: "Alerta", message: "Deseja realmente vender?", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Sim", style: .Default, handler: { action in
            println("Click of default button")
            self.pendentes.append(self.minha[sender.tag])
            self.minha.removeAtIndex(sender.tag)
            self.acoes.removeAtIndex(sender.tag)
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancelar", style: .Cancel, handler: { action in
            println("Click of cancel button")
        }))
        
        
        
        //println(String(sender.tag))
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

        if !pending{
        if indexPath == selectedIndexPath {
            if selectedRow == indexPath.row {
                return CarteiraCell.defaultHeight
            } else{
                return CarteiraCell.expandedHeight
            }
        }
        else{
            return CarteiraCell.defaultHeight
        }
        } else{
            return CarteiraCell.defaultHeight
        }

    }
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        if pending {
            return true
        }else {
            return false
        }
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            minha.append(pendentes[indexPath.row])
            pendentes.removeAtIndex(indexPath.row)
            acoes.removeAtIndex(indexPath.row)
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func getPatrimonio() -> NSString{
        return patrimonio.text!
    }

    func getCash() -> String{
    return cash.text!
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

