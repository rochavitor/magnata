//
//  Variacao.swift
//  Magnata
//
//  Created by Alexandre Katao on 8/27/15.
//  Copyright (c) 2015 Alexandre Katao. All rights reserved.
//

import UIKit

class CalculoVariacao {
    
    var resultados = Array<Resultado>()
    let json = ReadJson()
    
    let vitoria_casa = 2.5
    let vitoria_fora = 3.3
    let empate_casa = 1.0
    let empate_fora = 2.0
    let derrota_casa = -2.0
    let derrota_fora = -1.5
    let gols_pro_casa = 0.7
    let gols_pro_fora = 0.6
    let gols_contra_casa = -0.5
    let gols_contra_fora = -0.3
    
    
    // receber valorAtual dos dois times
    // receber o resultado do jogo
    
    
    // calcular a variacao baseado no resultado do jogo
    // calcular o valorFinal baseado na variacao
    
    
    // salvar a variacao e o valorFinal no mercadoAcoes.json
    
    init(){
        
    }
    
    func performCalculation(nome_time: String) -> Double {
        resultados = json.loadGames("Rodada21")
        var i = 0
        var variacao_time_porcentagem = 0.0
        
        for i = 0 ; i < resultados.count ; i++ {
            // Time Jogando Fora
            if resultados[i].escudoVisitante == nome_time {
                // Time Jogando Fora Vencedor
                if resultados[i].placarVisitante > resultados[i].placarCasa {
                    variacao_time_porcentagem += vitoria_fora
                }
                // Empate Fora
                else if resultados[i].placarVisitante == resultados[i].placarCasa {
                    variacao_time_porcentagem += empate_fora
                }
                // Time Jogando Fora Perdedor
                else {
                    variacao_time_porcentagem += derrota_fora
                }
                // Gols Pro Fora
                variacao_time_porcentagem += (resultados[i].placarVisitante as NSString).doubleValue * gols_pro_fora
                // Gols Contra Fora
                variacao_time_porcentagem += (resultados[i].placarCasa as NSString).doubleValue * gols_contra_fora
            }
            
            // Time Jogando em Casa
            if resultados[i].escudoCasa == nome_time {
                // Time Jogando em Casa Vencedor
                if resultados[i].placarCasa > resultados[i].placarVisitante {
                    variacao_time_porcentagem += vitoria_casa
                }
                    // Empate em Casa
                else if resultados[i].placarVisitante == resultados[i].placarCasa {
                    variacao_time_porcentagem += empate_casa
                }
                    // Time Jogando em Casa Perdedor
                else {
                    variacao_time_porcentagem += derrota_casa
                }
                // Gols Pro em Casa
                variacao_time_porcentagem += (resultados[i].placarCasa as NSString).doubleValue * gols_pro_casa
                // Gols Contra em Casa
                variacao_time_porcentagem += (resultados[i].placarVisitante as NSString).doubleValue * gols_contra_casa
            }
        }

        
        //println(variacao_time_porcentagem)

        
        
        return variacao_time_porcentagem
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
