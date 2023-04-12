//
//  GameScene.swift
//  Project 16 - 18
//
//  Created by Karon Bell on 2/14/23.
//

import Foundation
import SpriteKit
import UIKit
import AVFoundation

// next add a one min timer to the game and after it ends the game stops and it is over.
// now its just time to see why only one of my green targets are being detected
//but first detect when a red target or green target is tapped at the same location as the red dot.
// one green target has been detected so I know its now detecable so thats not the problem
// next see why the targets are not detectable
// it kinda seems like its working its just the detecting stregth is low. and i have to fix the timer and tap to play button..
// the target and red dot are now detected so thats not a problem

class GameScene: SKScene, ObservableObject {
    
    
    var sprite: SKSpriteNode!
    let myShotSlot = shotSlot()
    var shotSlotNode: shotSlot? // Define a property for shotSlotNode
    var imageView: UIImageView!
    var slots = [shotSlot]()
    var targets = [shotSlot]()
    var gameScore: SKLabelNode!
    var isPowerBarSelected = false
    var imageViewCopy: UIImageView!
    var moveTimer: Timer?
    var isPlaying = false
    var powerBarInitialPosition: CGPoint?
    var touchLocation: CGPoint?
    var lastUpdateTime: TimeInterval = 0
    var remainingTime = 6
    var imageViewRed: UIImageView!
    var imageViewRedBig: UIImageView!
    var imageViewGreenBig: UIImageView!
    var imageViewRedBigg: UIImageView!
    var imageViewGreenBigg: UIImageView!
    var imageViewRedBiggg: UIImageView!
    var imageViewGreenBiggg: UIImageView!
    var imageViewRedSmall: UIImageView!
    var imageViewGreenSmall: UIImageView!
    var isAnimating = false
    var selectedSlot: SKNode?
    var button: SKLabelNode!
    var highScoreLabel: SKLabelNode!
    
    var highScore = 0
    var isGameRunning = false
    var scoreLabel: SKLabelNode!
    var redTargets: [SKSpriteNode] = []
    var greenTargets: [SKSpriteNode] = []
    var score = 0
    var timerLabel: UILabel!
    var audioPlayer: AVAudioPlayer?
    var aPlayer: AVAudioPlayer?
    var aaPlayer: AVAudioPlayer?
    var homePageCreated = false
    var isGameStarted = false
    let BigTarget = SKSpriteNode(imageNamed: "redTarget")
    var buttonFrame: SKShapeNode!
    let backGround = SKSpriteNode(imageNamed: "background")
    let redTarget = SKSpriteNode(imageNamed: "redTarget")
    let redTargett = SKSpriteNode(imageNamed: "redTarget")
    let greenTarget = SKSpriteNode(imageNamed: "greenTarget")
    let green2  = SKSpriteNode(imageNamed: "greenTarget")
    let red2  = SKSpriteNode(imageNamed: "redTarget")
    let green3  = SKSpriteNode(imageNamed: "greenTarget")
    let green4  = SKSpriteNode(imageNamed: "greenTarget")
    let green5  = SKSpriteNode(imageNamed: "greenTarget")
    let green6  = SKSpriteNode(imageNamed: "greenTarget")
    let red3    = SKSpriteNode(imageNamed: "redTarget")
    let red4    = SKSpriteNode(imageNamed: "redTarget")
    let red5    = SKSpriteNode(imageNamed: "redTarget")
    let red6    = SKSpriteNode(imageNamed: "redTarget")
    let red7    = SKSpriteNode(imageNamed: "redTarget")
    let red8    = SKSpriteNode(imageNamed: "redTarget")
    let red9    = SKSpriteNode(imageNamed: "redTarget")
    let red10    = SKSpriteNode(imageNamed: "redTarget")
    let red11   = SKSpriteNode(imageNamed: "redTarget")
    let red12   = SKSpriteNode(imageNamed: "redTarget")
    let red13   = SKSpriteNode(imageNamed: "redTarget")
    let red14   = SKSpriteNode(imageNamed: "redTarget")
    var redDott: SKSpriteNode!
    var redDotNodes: [SKNode] = []
    
    let backGroundd = SKSpriteNode(imageNamed: "background")
    let intro = SKLabelNode(text: "Welcome To TargetCrushers! Created By Karon Bell!")
    let playNowButton = SKLabelNode(text: "Tap The Spining Red Target To Start A Game")
    var framee: SKShapeNode!
    var shadowNode: SKShapeNode!
    var frameee: SKShapeNode!
    let founder = SKLabelNode(text: "Song Playing is Always Be My Baby Sung By Mariah Carrey")
    var fframee: SKShapeNode!
    let targeet = SKSpriteNode(imageNamed: "greenTarget")
    let targeett = targetSlotRed()
    let slot =  shotSlot()
    
    var gameViewModel: GameViewModel?
    
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel
        super.init(size: gameViewModel.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // any additional setup code
    }
    
    var gVM: GameViewModel?
    
    class ShotSlot: SKNode {
        let sprite = SKSpriteNode(imageNamed: "slots")
        var score = 0
        
        var button: SKLabelNode!
        var scoreLabel: SKLabelNode!
        var redTargets: [SKSpriteNode] = []
        
        
        func configure(at position: CGPoint) {
            
            
            
            
            scoreLabel = SKLabelNode(text: "Scoreee: \(score)")
            
            // let scoreLabel = SKLabelNode(text: "Score: \(score)")
            self.position = position
            sprite.name = "shotSlotNode"
            
            
            
            
            
            //   sprite.position = CGPoint(x: frame.midX, y: frame.midY)
            sprite.scale(to: CGSizeMake(220, 140))
            //  sprite.isUserInteractionEnabled = true
            sprite.zPosition = 1
            addChild(sprite)
            
            
            
            
        }
        
    }
    
    
    
    override func didMove(to view: SKView) {
        
        
        gVM = GameViewModel(gameScene: self)
        
        createHomePage()
        //  gVM!.playButtonTapped()
        
        
        //   gVM!.resetTimer()
        gVM!.setupAudioPlayer()
        gVM!.setupAudioPlayer2()
        gVM!.player()
        
        
        
        
        func createSlot(at position: CGPoint, slotNumber: Int) -> (SKNode, SKSpriteNode) {
            let slot = GameScene.ShotSlot()
            slot.configure(at: position)
            
            let redDot: SKSpriteNode
            if let existingNode =  childNode(withName: "redDot\(slotNumber)") as? SKSpriteNode {
                redDot = existingNode
            } else {
                redDot = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
                redDot.name = "redDot\(slotNumber)"
                redDot.position = position
                redDot.zPosition = 40
                addChild(redDot)
            }
            
            return (slot, redDot)
        }
        
        
        
        redTarget.size = CGSize(width: 80, height: 80)
        redTarget.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // redTarget.isUserInteractionEnabled = true
        redTarget.zPosition = 102
        redTarget.name = "redTarget1"
        redTargets.append(redTarget)
        
        
        red2.size = CGSize(width: 80, height: 80)
        red2.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red2.isUserInteractionEnabled = true
        red2.zPosition = 103
        red2.name = "redTarget2"
        redTargets.append(red2)
        
        
        red3.size = CGSize(width: 80, height: 80)
        red3.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red3.isUserInteractionEnabled = true
        red3.zPosition = 104
        red3.name = "redTarget3"
        redTargets.append(red3)
        
        
        red4.size = CGSize(width: 80, height: 80)
        red4.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red4.isUserInteractionEnabled = true
        red4.zPosition = 105
        red4.name = "redTarget4"
        redTargets.append(red4)
        
        
        red5.size = CGSize(width: 80, height: 80)
        red5.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red5.isUserInteractionEnabled = true
        red5.zPosition = 106
        red5.name = "redTarget5"
        redTargets.append(red5)
        
        
        red6.size = CGSize(width: 80, height: 80)
        red6.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red6.isUserInteractionEnabled = true
        red6.zPosition = 107
        red6.name = "redTarget6"
        redTargets.append(red6)
        
        
        red7.size = CGSize(width: 80, height: 80)
        red7.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red7.isUserInteractionEnabled = true
        red7.zPosition = 108
        red7.name = "redTarget7"
        redTargets.append(red7)
        
        
        red8.size = CGSize(width: 80, height: 80)
        red8.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red8.isUserInteractionEnabled = true
        red8.zPosition = 109
        red8.name = "redTarget8"
        redTargets.append(red8)
        
        
        red9.size = CGSize(width: 80, height: 80)
        red9.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red9.isUserInteractionEnabled = true
        red9.zPosition = 110
        red9.name = "redTarget9"
        redTargets.append(red9)
        
        
        red10.size = CGSize(width: 80, height: 80)
        red10.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red10.isUserInteractionEnabled = true
        red10.zPosition = 111
        red10.name = "redTarget10"
        redTargets.append(red10)
        
        
        red11.size = CGSize(width: 80, height: 80)
        red11.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        // red11.isUserInteractionEnabled = true
        red11.zPosition = 112
        red11.name = "redTarget31"
        redTargets.append(red11)
        
        
        red12.size = CGSize(width: 110, height: 80)
        red12.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        red12.zPosition = 123
        red12.name = "redTarget9"
        redTargets.append(red12)
        
        red13.size = CGSize(width: 110, height: 80)
        red13.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        red13.zPosition = 119
        red13.name = "redTarget11"
        redTargets.append(red13)
        
        red14.size = CGSize(width: 110, height: 80)
        red14.position = CGPoint(x: size.width/2 - 250, y: size.height/2)
        red14.zPosition = 118
        red14.name = "redTarget12"
        redTargets.append(red14)
        
        redTargett.size = CGSize(width: 110, height: 80)
        redTargett.position = CGPoint(x: size.width/2 - 210, y: size.height/2)
        redTargett.zPosition = 117
        redTargett.name = "redTarget13"
        redTargets.append(redTargett)
        
        
        greenTarget.size = CGSize(width: 80, height: 80)
        greenTarget.position = CGPoint(x: size.width/2 - 320, y: size.height/2)
        greenTarget.zPosition = 111
        greenTarget.name = "greenTarget1"
        greenTargets.append(greenTarget)
        
        green2.size = CGSize(width: 80, height: 80)
        green2.position = CGPoint(x: size.width/2 - 320, y: size.height/2)
        green2.zPosition = 116
        green2.name = "greenTarget2"
        greenTargets.append(green2)
        
        green3.size = CGSize(width: 80, height: 80)
        green3.position = CGPoint(x: size.width/2 - 320, y: size.height/2)
        green3.zPosition = 115
        green3.name = "greenTarget3"
        greenTargets.append(green3)
        
        green4.size = CGSize(width: 80, height: 80)
        green4.position = CGPoint(x: size.width/2 - 320, y: size.height/2)
        green4.zPosition = 114
        green4.name = "greenTarget4"
        greenTargets.append(green4)
        
        green5.size = CGSize(width: 80, height: 80)
        green5.position = CGPoint(x: size.width/2 - 320, y: size.height/2)
        green5.zPosition = 113
        green5.name = "greenTarget5"
        greenTargets.append(green5)
        
        green6.size = CGSize(width: 80, height: 80)
        green6.position = CGPoint(x: size.width/2 - 320, y: size.height/2)
        green6.zPosition = 112
        green6.name = "greenTarget6"
        greenTargets.append(green6)
        
        
        button = SKLabelNode()
        button.text = "Tap To Play"
        button.position = CGPoint(x: 210, y: 90)
        button.zPosition = 33
        button.fontSize = 19
        button.fontColor = .white
        button.fontName = "Arial"
        button.name = "playButton"
        
        
        buttonFrame = SKShapeNode(rectOf: CGSize(width: button.frame.width + 90, height: button.frame.height + 90), cornerRadius: 5)
        buttonFrame.fillColor = .black
        buttonFrame.strokeColor = .white
        buttonFrame.lineWidth = 2
        buttonFrame.position = button.position
        buttonFrame.zPosition = 1
        //   addChild(buttonFrame)
        
        //  button.isUserInteractionEnabled = true
        
        
        backGround.position = CGPoint(x: 512, y: 384)
        backGround.blendMode = .replace
        backGround.zPosition = -1
        // line 20 makes sure things go on top of the background view.
        backGround.scale(to: CGSizeMake(1024, 768))
        // I used line 21 to strech the image out to fix my scrrens size because I know I set my screen size to 1024 in the GameScene UI
        
        //    addChild(backGround)
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 480, y: 70)
        //  addChild(gameScore)
        //   self.view?.isMultipleTouchEnabled = true
        
        
        //   view.isUserInteractionEnabled = true
        // this code breaks my slots into 3 rows and 3 cloumms of the shotSlots.
        
        
        
        // Add score label
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.fontSize = 26
        scoreLabel.fontName = "HelveticaNeue-Bold"
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.verticalAlignmentMode = .top
        
        scoreLabel.position = CGPoint(x: 220, y: size.height - 50)
        //    addChild(scoreLabel)
        
        highScoreLabel = SKLabelNode(text: "High Scoree: \(highScore)")
        highScoreLabel.text = "New high score: \(UserDefaults.standard.integer(forKey: "highScore"))"
        
        highScoreLabel.fontSize = 26
        highScoreLabel.fontName = "HelveticaNeue-Bold"
        highScoreLabel.horizontalAlignmentMode = .center
        highScoreLabel.verticalAlignmentMode = .top
        highScoreLabel.position = CGPoint(x: 766, y: size.height - 50)
        
        
        
        
        timerLabel = UILabel(frame: CGRect(x: 490, y: 890, width: 399, height: 63))
        timerLabel.center = CGPoint(x: 610, y: 300)
        timerLabel.textColor = .black
        timerLabel.layer.zPosition = -2
        timerLabel.backgroundColor = .white
        
        
        
        // Initialize the timer label
        
        //   timerLabel.layer.zPosition = -1
        timerLabel.center = CGPoint(x: view.frame.size.width / 2, y: 100)
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 40)
        //     view.addSubview(timerLabel) // Add the timer label to the view
        
        
        sprite = SKSpriteNode(imageNamed: "slots")
        sprite.position = CGPoint(x: 100, y: 100)
        // addChild(sprite)
        
        
        for i in 0..<3 {
            let (slot1, redDott1) = createSlot(at: CGPoint(x: 120 + (i * 370), y: 560), slotNumber: i + 1)
            let (slot2, redDott2) = createSlot(at: CGPoint(x: 120 + (i * 370), y: 370), slotNumber: i + 4)
            let (slot3, redDott3) = createSlot(at: CGPoint(x: 120 + (i * 370), y: 200), slotNumber: i + 7)
            addChild(slot1)
            addChild(slot2)
            addChild(slot3)
            redDotNodes.append(redDott1)
            redDotNodes.append(redDott2)
            redDotNodes.append(redDott3)
        }
        
        
        moveTimer?.fire()
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Call your existing touchesBegan function here
        gVM?.touchesBegan(touches, with: event)
        
        
        
    }
    
    
    
    
    
    func createHomePage() {
        
        backGroundd.position = CGPoint(x: 512, y: 384)
        backGroundd.blendMode = .replace
        backGroundd.zPosition = -3
        backGroundd.scale(to: CGSizeMake(1024, 768))
        addChild(backGroundd)
        if homePageCreated {
            
            aaPlayer?.play()
            
        }
        
        
        intro.fontSize = 26
        intro.fontName = "Verdana-BoldItalic"
        intro.color = .white
        intro.fontColor = .orange
        intro.verticalAlignmentMode = .center
        intro.position = CGPoint(x: 490, y: 650)
        intro.zPosition = 99
        addChild(intro)
        
        
        
        fframee = SKShapeNode(rectOf: CGSize(width: intro.frame.width + 20, height: intro.frame.height + 20), cornerRadius: 10)
        fframee.position = CGPoint(x: 490, y: 650)
        fframee.fillColor = .white
        fframee.alpha = 2
        fframee.zPosition = 98
        
        addChild(fframee)
        
        
        BigTarget.zPosition = 2
        BigTarget.scale(to: CGSizeMake(280, 234))
        BigTarget.name = "bigTarget"
        BigTarget.position = CGPoint(x: 490, y: 370)
        
        
        addChild(BigTarget)
        
        let blinkAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.2, duration: 0.5),
            SKAction.wait(forDuration: 0.5),
            SKAction.fadeAlpha(to: 1.0, duration: 0.5),
            SKAction.wait(forDuration: 0.5)
        ])
        ;
        // run the blinkAction repeatedly on the target node
        BigTarget.run(SKAction.repeatForever(blinkAction))
        
        
        
        let rotateAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1.0)
        BigTarget.run(SKAction.repeatForever(rotateAction))
        
        
        shadowNode = SKShapeNode(circleOfRadius: BigTarget.size.width/1.9)
        shadowNode.fillColor = .clear
        shadowNode.alpha = 0.5
        shadowNode.zPosition = BigTarget.zPosition - 1
        shadowNode.position = BigTarget.position
        addChild(shadowNode)
        
        let shadowOffset = CGSize(width: 5, height: -5)
        shadowNode.position = CGPoint(x: shadowNode.position.x + shadowOffset.width, y: shadowNode.position.y + shadowOffset.height)
        
        shadowNode.setScale(1.1)
        
        
        playNowButton.fontSize = 26
        playNowButton.fontName = ""
        playNowButton.color = .white
        playNowButton.fontColor = .orange
        playNowButton.position = CGPoint(x: 490, y: 571)
        playNowButton.verticalAlignmentMode = .center
        playNowButton.zPosition = 99
        addChild(playNowButton)
        
        frameee = SKShapeNode(rectOf: CGSize(width: 533, height: intro.frame.height + 20), cornerRadius: 10)
        frameee.position = CGPoint(x: 490, y: 571)
        frameee.fillColor = .white
        frameee.alpha = 2
        frameee.zPosition = 98
        addChild(frameee)
        // this is amount their is that this
        // thiufygifufigayyiusfdiugsdgasuhoafoigua
        //isdusiuiufdosispougaiygduygaiufoipaauaiug
        
        founder.fontSize = 26
        founder.fontName = "Verdana-BoldItalic"
        founder.color = .white
        founder.fontColor = .orange
        founder.position = CGPoint(x: 490, y: 111)
        founder.verticalAlignmentMode = .center
        founder.zPosition = 99
        addChild(founder)
        framee = SKShapeNode(rectOf: CGSize(width: 883, height: intro.frame.height + 20), cornerRadius: 10)
        framee.position = CGPoint(x: 487, y: 108)
        framee.fillColor = .white
        framee.alpha = 2
        framee.zPosition = 98
        
        addChild(framee)
        
        // kvfuddofuhvfdoihvfeoierghoefrighgreoihgoe3rihgoerihgoeihrgoeihrtgoeirhgoei3hrgoi4rehgior4eigheoigjoeirghr34oighreoigroeigrhir4o
        
        
        
        //    playNowButtonn()
        
        
    }
    
    
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
}
