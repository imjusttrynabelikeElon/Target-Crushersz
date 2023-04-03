//
//  targetSlot.swift
//  Project 16 - 18
//
//  Created by Karon Bell on 2/15/23.
//
//

import Foundation

import SpriteKit
import UIKit

class targetSlot: SKNode {
    let sprite = SKSpriteNode(imageNamed: "slots")
    func configure(at position: CGPoint) {
       
        self.position = position
        
        let target = SKSpriteNode(imageNamed: "greenTarget")
        target.zPosition = 2
       target.scale(to: CGSizeMake(1, 47))
     //   addChild(target)
    }
    
}
