//
//  FaceItem.swift
//  PopoFace
//
//  Created by Apprenant156 on 11/12/2025.
//
import Foundation

protocol FaceItem: Identifiable {
    var nom: String { get }
    var image: String { get }
}
