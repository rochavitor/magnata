//
//  Resultado.swift
//  Magnata
//
//  Created by Vítor Machado Rocha on 25/08/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

class Resultado {
    
    var posicaoCasa: String!
    var timeCasa: String!
    var escudoCasa: String!
    var placarCasa: String!
    var placarVisitante: String!
    var escudoVisitante: String!
    var timeVisitante: String!
    var posicaoVisitante: String!
    
    init(posicaoCasa:String, escudoCasa: String, placarCasa: String, placarVisitante: String, escudoVisitante: String, posicaoVisitante: String) {
        self.posicaoCasa = posicaoCasa
        self.escudoCasa = escudoCasa
        self.placarCasa = placarCasa
        self.placarVisitante = placarVisitante
        self.escudoVisitante = escudoVisitante
        self.posicaoVisitante = posicaoVisitante
    }
    
}
