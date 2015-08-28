//
//  ViewControllerMercado.swift
//  Magnata
//
//  Created by Alexandre Katao on 8/21/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//


import UIKit

class MercadoVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var acoes = [Mercado]()
    
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
    
    func loadTeams() {
        
        //Accessing the JSON.
        let filePath = NSBundle.mainBundle().pathForResource("MercadoAcoes", ofType: "json")
        var readError : NSError?
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        let json = JSON(data:data!)
        
        
        //Getting all the data and inserting in an array.
        for (key : String, quest: JSON ) in json{
            var index = key.toInt()
            println(json[index!]["time"])
            println(json[index!]["valor_inicial"])
            acoes.append(Mercado(id: index!, name: String(stringInterpolationSegment : json[index!]["time"]), valor: String(stringInterpolationSegment : json[index!]["valor_atual"]), variacao: String(stringInterpolationSegment : json[index!]["valorizacao"])))
        }
    }
    
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acoes.count
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mercadoCell", forIndexPath: indexPath) as! MercadoCell
        
        let row = indexPath.row
        cell.teamImage.image = UIImage(named: StringToSigla(acoes[row].name) as String!)
        cell.teamName.text = acoes[row].name
        
        
        var calc = CalculoVariacao()
        
        var variacao_time_porcentagem = calc.performCalculation(StringToSigla(acoes[row].name) as String)
        
        cell.valor.text = "R$ " + String(format: "%.2f", (acoes[row].valor as NSString).doubleValue * ((variacao_time_porcentagem/100) + 1))
        
        if variacao_time_porcentagem >= 0{
            //cell.variacao.textColor = UIColor(red: 34.0, green: 246.0, blue: 22.0, alpha: 1.0)
            cell.variacao.textColor = UIColor.greenColor()
            cell.variacao.text = "+" + String(format: "%.2f", variacao_time_porcentagem) + "%"
        } else {
            //cell.variacao.textColor = UIColor(red: 255, green: 43, blue: 57, alpha: 1.0)
            cell.variacao.textColor = UIColor.redColor()
            cell.variacao.text = String(format: "%.2f", variacao_time_porcentagem) + "%"
        }
        
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
//        println(acoes[row].quantidade)
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

public class Mercado {
    public var id: Int
    public var name: String
    public var valor: String
    public var variacao: String
    
    public init(id: Int, name: String, valor: String, variacao: String) {
        self.id = id
        self.name = name
        self.valor = valor
        self.variacao = variacao
    }
}
