//
//  ViewController.swift
//  Magnata
//
//  Created by Alexandre Katao on 8/20/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

class ViewControllerCarteira: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var acoes = [Carteira]()
    
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
        let filePath = NSBundle.mainBundle().pathForResource("Carteira", ofType: "json")
        var readError : NSError?
        let data = NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingUncached,error: &readError)
        let json = JSON(data:data!)
        
        
        //Getting all the data and inserting in an array.
        for (key : String, quest: JSON ) in json{
            var index = key.toInt()
            println(json[index!]["time"])
            println(json[index!]["valor_inicial"])
            acoes.append(Carteira(id: index!, name: String(stringInterpolationSegment : json[index!]["time"]), valor: String(stringInterpolationSegment : json[index!]["valor_atual"]), quantidade: String(stringInterpolationSegment : json[index!]["quantidade"]), variacao: String(stringInterpolationSegment : json[index!]["valorizacao"])))
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
        let cell = tableView.dequeueReusableCellWithIdentifier("carteiraCell", forIndexPath: indexPath) as! CarteiraCell
        
        let row = indexPath.row
        cell.teamName.text = acoes[row].name
        cell.valor.text = acoes[row].valor
        cell.quantidade.text = acoes[row].quantidade
        cell.variacao.text = acoes[row].variacao
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(acoes[row].quantidade)
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

