//
//  ViewControllerResultados.swift
//  Magnata
//
//  Created by Vítor Machado Rocha on 24/08/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

class ResultadosVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var resultados = Array<Resultado>()
    let json = ReadJson()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*tableView.backgroundColor = UIColor(red: 243.0/255, green: 243.0/255, blue: 243.0/255, alpha: 0.93)
        tableView.layer.cornerRadius = 8.0
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = UIColor( red: 153/255, green: 153/255, blue:0/255, alpha: 1.0 ).CGColor
        tableView.layer.borderWidth = 2.0*/
        
        resultados = json.loadGames()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultados.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultadosCell", forIndexPath: indexPath) as! ResultadosCell
        
        let row = indexPath.row
        
        cell.posicaoCasa.text = resultados[row].posicaoCasa
        cell.timeCasa.text = resultados[row].escudoCasa
        cell.placarCasa.text = resultados[row].placarCasa
        cell.escudoCasa.image = UIImage(named: resultados[row].escudoCasa)
        
        cell.placarVisitante.text = resultados[row].placarVisitante
        cell.posicaoVisitante.text = resultados[row].posicaoVisitante
        cell.timeVisitante.text = resultados[row].escudoVisitante
        cell.escudoVisitante.image = UIImage(named: resultados[row].escudoVisitante)
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        //        println(acoes[row].quantidade)
    }
    
    
}

