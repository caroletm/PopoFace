//
//  Fruit.swift
//  PopoFace
//
//  Created by caroletm on 11/12/2025.
//

import Foundation

struct Fruit : Identifiable, FaceItem {
    var id : UUID = UUID()
    var nom : String
    var image : String
}

var banane: Fruit = Fruit(nom: "Banane", image: "banana")
var pomme : Fruit = Fruit(nom: "Pomme", image: "apple")
var pasteque : Fruit = Fruit(nom: "Pastèque", image: "watermelon")
var fraise : Fruit = Fruit(nom: "Fraise", image: "strawberry")
var orange : Fruit = Fruit(nom: "Orange", image: "orange")
var raisin : Fruit = Fruit(nom: "Raisin", image: "grape")
var ananas : Fruit = Fruit(nom: "Ananas", image: "pineapple")
var kiwi : Fruit = Fruit(nom: "Kiwi", image: "kiwi")
var cerise : Fruit = Fruit(nom: "Cerise", image: "cherry")
var peche : Fruit = Fruit(nom: "Pêche", image: "peach")
var citron : Fruit = Fruit(nom: "Citron", image: "lemon")
var mangue : Fruit = Fruit(nom: "Mangue", image: "mango")
var myrtille : Fruit = Fruit(nom: "Myrtille", image: "blueberry")

var fruits : [Fruit] = [banane, pomme, pasteque, fraise, orange, raisin, ananas, kiwi, cerise, peche, citron, mangue, myrtille]



