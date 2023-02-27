//
//  shotSlot.swift
//  Project 16 - 18
//
//  Created by Karon Bell on 2/14/23.
//

// to change the asistant edtor change the

import SpriteKit
import UIKit



class shotSlot: SKNode {
    let sprite = SKSpriteNode(imageNamed: "slots")
    var score = 0
    
    var button: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var redTargets: [SKSpriteNode] = []
    
    
    
    func configure(at position: CGPoint) {
        
        
        
        
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        // let scoreLabel = SKLabelNode(text: "Score: \(score)")
        self.position = position
        sprite.name = "shotSlotNode"
        
   
        
        
        
        //   sprite.position = CGPoint(x: frame.midX, y: frame.midY)
        sprite.scale(to: CGSizeMake(220, 140))
        //  sprite.isUserInteractionEnabled = true
        sprite.zPosition = 1
     //   addChild(sprite)
        
        
        
     
    }
    
    
    
    
    
    
    
}
