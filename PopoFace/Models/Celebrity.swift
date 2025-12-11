//
//  Fruit.swift
//  PopoFace
//
//  Created by caroletm on 11/12/2025.
//

import Foundation

struct Celebrity : Identifiable, FaceItem {
    var id : UUID = UUID()
    var nom : String
    var image : String
}

var taylor : Celebrity = Celebrity(nom: "Taylor Swift", image: "taylor")
var timothee : Celebrity = Celebrity(nom: "Timothee Chalamet", image: "timothee")
var kylian : Celebrity = Celebrity(nom: "Kylian Mbappé", image: "kylian")

let celebrities : [Celebrity] = [taylor, timothee, kylian]
