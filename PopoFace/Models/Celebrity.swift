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
var zendaya : Celebrity = Celebrity(nom: "Zendaya", image: "zendaya")
var theRock : Celebrity = Celebrity(nom: "The Rock", image: "therock")
var billie : Celebrity = Celebrity(nom: "Billie Eilish", image: "billie")
var leonardo : Celebrity = Celebrity(nom: "Leonardo DiCaprio", image: "leonardo")
var ariana : Celebrity = Celebrity(nom: "Ariana Grande", image: "ariana")
var drake : Celebrity = Celebrity(nom: "Drake", image: "drake")
var margot : Celebrity = Celebrity(nom: "Margot Robbie", image: "margot")
var rihanna : Celebrity = Celebrity(nom: "Djamel Debout", image: "jame")
var cristiano : Celebrity = Celebrity(nom: "L'homme mystère", image: "myst")
var beyonce : Celebrity = Celebrity(nom: "Beyoncé", image: "beyonce")

let celebrities : [Celebrity] = [taylor, timothee, kylian, zendaya, theRock, billie, leonardo, ariana, drake, margot, rihanna, cristiano, beyonce]
