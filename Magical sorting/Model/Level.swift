//
//  Level.swift
//  Magical sorting
//
//  Created by Oleg Arnaut  on 22.08.2023.
//

import Foundation

var level : Int = 10
var crystal : Int = 0

let nameArray = ["William Lane",
                 "Charles Lucas",
                 "Grant Skinner",
                 "Earl Green",
                 "Anthony Tate",
                 "Gervase Black",
                 "Eric Fox",
                 "Myron Parsons",
                 "John Hill",
                 "Godfrey Morris"]

func saveData(){
    UserDefaults.standard.set(level, forKey: "GameLevel")
    UserDefaults.standard.set(crystal, forKey: "GameCrystal")
    UserDefaults.standard.synchronize()
}

func loadData(){
    if let saveLevel = UserDefaults.standard.integer(forKey: "GameLevel") as? Int{
        level = saveLevel
    } else {
        level = 1
    }
    
    
    if let saveCrystal = UserDefaults.standard.integer(forKey: "GameCrystal") as? Int{
        crystal = saveCrystal
    } else {
        crystal = 0
    }
    
}


