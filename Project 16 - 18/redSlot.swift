//
//  redSlot.swift
//  Project 16 - 18
//
//  Created by Karon Bell on 2/15/23.
//

import Foundation
import SpriteKit
import UIKit



class targetSlotRed: SKNode {
    let spritee = SKSpriteNode(imageNamed: "slots")
    func configure(at position: CGPoint) {
       
        self.position = position
        
        let targetsd = SKSpriteNode(imageNamed: "redTarget")
        targetsd.zPosition = 2
       targetsd.scale(to: CGSizeMake(50, 44))
        
     //   addChild(target)
    }
    
}
