//
//  WhackSlot.swift
//  Project14
//
//  Created by Görkem Gültekin on 18.02.2021.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    var charNode:SKSpriteNode!
    var isVisible = false
    var isHit = false
    func configure(at position:CGPoint) {
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        addChild(cropNode)
    }
    
    
    

}
