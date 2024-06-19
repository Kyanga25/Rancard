//
//  Model.swift
//  Rancard
//
//  Created by Nathanael Mukyanga on 2024-05-23.
//
import Foundation
import SwiftUI
import AVKit

// Model
struct Model:Equatable {
    var rondom:Int
    var currentScore:Int
    var trigger:Int
    var win:Bool
    var sel:Int
    var click:Bool
    var failure:Int
    var disable:Bool
    var mute:Bool
    var vol:Int
    let cards:[Int]
    var index:Int
    
    init() {
           rondom = 0
           currentScore = 0
           trigger = 0
           win = false
           sel = 0
           click = false
           failure = 0
           disable = false
           mute = false
           vol = 1
           cards = [Int](1...9)
           index = 0
       }
  
}
