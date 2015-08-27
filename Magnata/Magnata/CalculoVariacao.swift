//
//  Variacao.swift
//  Magnata
//
//  Created by Alexandre Katao on 8/27/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

struct CalculoVariacao {
    
    // receber
    var resultado: Resultado
    var valorAtual: String
    
    
    //  calcular
    var valorFinal: String
    var variacao: String
    
    
    // receber valorAtual dos dois times
    // receber o resultado do jogo
    
    
    // calcular a variacao baseado no resultado do jogo
    // calcular o valorFinal baseado na variacao
    
    
    // salvar a variacao e o valorFinal no mercadoAcoes.json
    
    func performCalculation() -> Double {
        
        return 0.0
    }
    
    func saveJson(){}
    
   
}

/*
Uma classe Pessoa tem um atributo dataDeNascimento e um método idade

Faz sentido O model resultado ter um metodo que calcula a variacao??
se fizer, calcular a variacao no model de resultado

*/


// em algum ViewController
//            let calc = CalculoVariacao(resultado: asfd, valor )
//            calc.performCalculation()

/*

* Pontuacao        casa		fora
* Vitoria		2.5			3.0
* empate 		1			1.5
* derrota		-2			-1.5
* gols pró		0.5         0.8
* gols contra	-0.5        -0.3


Incluir no calculo de variacao:

+ Ganho/perda de posições na tabela
+ Cartoes amarelos e vermelhos   (-)
+ relação entre as posições dos times
+ rivalidade (Classico)
+ Odds na bolsa esportiva



*/
