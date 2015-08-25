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
        cell.valor.text = acoes[row].valor
        cell.quantidade.text = acoes[row].quantidade
        
        
        return cell
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
        //println(acoes[row].quantidade)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! MercadoCompraCell).watchFrameChanges()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! MercadoCompraCell).ignoreFrameChanges()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath == selectedIndexPath {
            return MercadoCompraCell.expandedHeight
        }
        else{
            return MercadoCompraCell.defaultHeight
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
