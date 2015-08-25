//
//  ReadJson.swift
//  Magnata
//
//  Created by Vítor Machado Rocha on 24/08/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

class ReadJson {
    
    /** Read the JSON, create Alimentos objects with name and image. If is the first launch, pass these objects to Core Data**/
    func loadGames() -> Array<Resultado> {
        
        var resultados = Array<Resultado>()
        
        ///Read JSON
        let path = NSBundle.mainBundle().pathForResource("Resultados", ofType: "txt")
        var error: NSError?
        let jsonData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: &error)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        ///Array to build the objects
        var games : NSArray = jsonResult["Resultados"] as! NSArray
        
 
            //Create Alimentos and pass to context
            for buildArray in games {
            
                resultados.append(Resultado(posicaoCasa: (buildArray.objectForKey("Posição Casa")) as! String, escudoCasa: (buildArray.objectForKey("Escudo Casa")) as! String, placarCasa: (buildArray.objectForKey("Placar Casa")) as! String, placarVisitante: (buildArray.objectForKey("Placar Visitante")) as! String, escudoVisitante: (buildArray.objectForKey("Escudo Visitante")) as! String, posicaoVisitante: (buildArray.objectForKey("Posição Visitante")) as! String))
                
            }
        
        return resultados
    }
    
    
}
