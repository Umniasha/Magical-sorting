//
//  Objects.swift
//  Magical sorting
//
//  Created by Oleg Arnaut  on 18.08.2023.
//

import Foundation
import SpriteKit

struct Objects{
    
    let name: String
    let size: CGSize
    var position : CGPoint
    var zPosition : CGFloat
   
    
    
    
    func createNode()->SKSpriteNode{
        let spriteNode = SKSpriteNode(imageNamed: name)
        spriteNode.name = name
        spriteNode.size = size
        spriteNode.position = position
        spriteNode.zPosition = zPosition
        
        return spriteNode
    }
    
}
