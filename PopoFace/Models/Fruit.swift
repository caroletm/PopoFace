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
var pasteque : Fruit = Fruit(nom: "Pasteque", image: "watermelon")

var fruits : [Fruit] = [banane, pomme, pasteque]



