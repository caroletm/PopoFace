//
//  Fruit.swift
//  PopoFace
//
//  Created by caroletm on 11/12/2025.
//

import Foundation

struct Vegetable : Identifiable, FaceItem {
    var id : UUID = UUID()
    var nom : String
    var image : String
}

var brocoli: Vegetable = Vegetable(nom: "Brocoli", image: "brocoli")
var carotte: Vegetable = Vegetable(nom: "Carotte", image: "carrot")
var tomate: Vegetable = Vegetable(nom: "Tomate", image: "tomato")
var poivron: Vegetable = Vegetable(nom: "Poivron", image: "bellpepper")
var aubergine: Vegetable = Vegetable(nom: "Aubergine", image: "eggplant")
var courgette: Vegetable = Vegetable(nom: "Courgette", image: "zucchini")
var concombre: Vegetable = Vegetable(nom: "Concombre", image: "cucumber")
var champignon: Vegetable = Vegetable(nom: "Champignon", image: "mushroom")
var mais: Vegetable = Vegetable(nom: "Maïs", image: "corn")
var oignon: Vegetable = Vegetable(nom: "Oignon", image: "onion")
var salade: Vegetable = Vegetable(nom: "Salade", image: "lettuce")
var radis: Vegetable = Vegetable(nom: "Radis", image: "radish")
var choufleur: Vegetable = Vegetable(nom: "Chou-fleur", image: "cauliflower")

let vegetables: [Vegetable] = [brocoli, carotte, tomate, poivron, aubergine, courgette, concombre, champignon, mais, oignon, salade, radis, choufleur]

