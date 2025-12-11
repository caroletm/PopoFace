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

let vegetables: [Vegetable] = [brocoli, carotte, tomate]

