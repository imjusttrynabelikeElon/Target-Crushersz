//
//  GameScene.swift
//  Project 16 - 18
//
//  Created by Karon Bell on 2/14/23.
//

import SpriteKit
import UIKit
import AVFoundation

// the ui goes in the gamescene
// next add a one min timer to the game and after it ends the game stops and it is over.

//but first detect when a red target or green target is tapped at the same location as the red dot.
class GameScene: SKScene {
    
    // next see why the targets are not detectable
    var sprite: SKSpriteNode!
 // it kinda seems like its working its just the detecting stregth is low. and i have to fix the timer and tap to play button..
    // the target and red dot are now detected so thats not a problem
    // when ever your having a problem sharing data from one page to other just add the needed pages vars to the other page...
    let myShotSlot = shotSlot()
       
    var imageView: UIImageView!
    var slots = [shotSlot]()
    var targets = [shotSlot]()
    var gameScore: SKLabelNode!
    
    var shotSlotNode: shotSlot? // Define a property for shotSlotNode
    var imageViewCopy: UIImageView!
    var currentAnimation = 0
    var moveTimer: Timer?
    var isPlaying = false
    var isPowerBarSelected = false
      var powerBarInitialPosition: CGPoint?
      var touchLocation: CGPoint?
      var lastUpdateTime: TimeInterval = 0
    var remainingTime = 60
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
    var redDott: SKSpriteNode!
    
    var isGameRunning = false
    var scoreLabel: SKLabelNode!
      var redTargets: [SKSpriteNode] = []
      var greenTargets: [SKSpriteNode] = []
      var score = 0
    var timerLabel: UILabel!
    var audioPlayer: AVAudioPlayer?
    var aPlayer: AVAudioPlayer?
    var aaPlayer: AVAudioPlayer?
    var PlayNow = false
    var homePageCreated = false
    var isGameStarted = false
    let BigTarget = SKSpriteNode(imageNamed: "redTarget")
    var buttonFrame: SKShapeNode!
    let backGround = SKSpriteNode(imageNamed: "background")
    let redTarget = SKSpriteNode(imageNamed: "redTarget")
    let redTargett = SKSpriteNode(imageNamed: "redTarget")
    let greenTarget = SKSpriteNode(imageNamed: "greenTarget")
    let backGroundd = SKSpriteNode(imageNamed: "background")
    let intro = SKLabelNode(text: "Welcome To TargetCrushers! Created By Karon Bell!")
    let playNowButton = SKLabelNode(text: "Tap Red Target To Start a Game")
    var framee: SKShapeNode!
    var shadowNode: SKShapeNode!
    var frameee: SKShapeNode!
    let founder = SKLabelNode(text: "Founded by Karon Bell")
    var fframee: SKShapeNode!
    let slot =  shotSlot()
   // var score = 0 {
  //     didSet {
  //          gameScore.text = "Score: \(score)"
   //     }
 
    // next she why the redDots are not dectectable...
    
     
    
  

 
    
    // now finsh making the Front screen... its 1 2 3
    func createSlot(at position: CGPoint, redDotName: String) -> (SKNode, SKSpriteNode?) {
   
         slot.configure(at: position)
        // addChild(slot)
         slots.append(slot)
     
         redDott = SKSpriteNode(color: .red, size: CGSize(width: 80, height: 30))
         redDott.position = CGPoint(x: position.x, y: position.y - 1)
         redDott.zPosition = 40
         redDott.name = redDotName
         redDott.size = CGSize(width: 50, height: 50)
        
        slot.addChild(redDott)
        return (slot, redDott)
    }


  
    override func didMove(to view: SKView) {
    
     
        createHomePage()
        
        
        setupAudioPlayer()
      setupAudioPlayer2()
     setupAudioPlayer3()
        
        button = SKLabelNode()
        button.text = "Tap To Play"
        button.position = CGPoint(x: 210, y: 90)
        button.zPosition = 33
        button.fontSize = 19
        button.fontColor = .white
        button.fontName = "Arial"
        button.name = "playButton"

       
      //  button.isUserInteractionEnabled = true
       
        

     //   button.zPosition = 2
   //  button.isUserInteractionEnabled = true
     

   //  addChild(button)
        
        
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
      
       
    
        // this code breaks my slots into 3 rows and 3 cloumms of the shotSlots.
        
       
        
        // Add score label
            scoreLabel = SKLabelNode(text: "Score: \(score)")
            scoreLabel.fontSize = 24
            scoreLabel.fontName = "HelveticaNeue-Bold"
            scoreLabel.horizontalAlignmentMode = .center
            scoreLabel.verticalAlignmentMode = .top
            scoreLabel.position = CGPoint(x: size.width/2, y: size.height - 50)
        //    addChild(scoreLabel)
            
     
            // Add red targets
            for i in 0..<6 {
              
                redTarget.size = CGSize(width: 80, height: 80)
                redTarget.position = CGPoint(x: size.width/2 - 200 + CGFloat(i) * 120, y: size.height/2)
             //   redTarget.isUserInteractionEnabled = true
                redTarget.zPosition = 111
                redTarget.name = "redTarget"
               
         //       addChild(redTarget)
                redTargets.append(redTarget)
            }
        
        for i in 0..<7 {

       
            redTargett.size = CGSize(width: 110, height: 80)
            redTargett.position = CGPoint(x: size.width/2 - 200 + CGFloat(i) * 120, y: size.height/2)
            redTargett.zPosition = 111
            redTargett.name = "redTargets"
       
            //    redTargett.isUserInteractionEnabled = true
       //     addChild(redTargett)
            redTargets.append(redTargett)
        }

            
            // Add green targets
            for i in 0..<11 {
             
                greenTarget.size = CGSize(width: 80, height: 80)
                greenTarget.position = CGPoint(x: size.width/2 + 80 + CGFloat(i) * 120, y: size.height/2)
                greenTarget.zPosition = 111
                
                greenTarget.name = "greenTarget"
             
             
         //       greenTarget.isUserInteractionEnabled = true
                // keep these off isUserInteractionEnabled... all of themmm
       //         addChild(greenTarget)
                greenTargets.append(greenTarget)
            }
        
        moveTimer?.fire()
        
        timerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 399, height: 63))
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
        
     
       founder.fontSize = 26
       founder.fontName = "Verdana-BoldItalic"
       founder.color = .white
       founder.fontColor = .orange
       founder.position = CGPoint(x: 490, y: 111)
        founder.verticalAlignmentMode = .center
       founder.zPosition = 99
        addChild(founder)
        framee = SKShapeNode(rectOf: CGSize(width: 433, height: intro.frame.height + 20), cornerRadius: 10)
        framee.position = CGPoint(x: 490, y: 111)
        framee.fillColor = .white
        framee.alpha = 2
        framee.zPosition = 98

        addChild(framee)
       
        
        
        if let path = Bundle.main.path(forResource: "intro", ofType: "mp3") {
               let url = URL(fileURLWithPath: path)
               do {
                   aaPlayer = try AVAudioPlayer(contentsOf: url)
                   aaPlayer?.play()
               } catch {
                   print("Error loading audio file")
               }
           }
    }
    

    
    func moveTargets() {
        let screenSize = UIScreen.main.bounds.size
        let xRange = UInt32(screenSize.width - 50)
        let yRange = UInt32(screenSize.height - 50)
        
        // Animate the red targets
        for redTarget in redTargets {
            let randomX = CGFloat(arc4random_uniform(xRange)) - 110
            let randomY = CGFloat(arc4random_uniform(yRange))
            let destination = CGPoint(x: randomX, y: randomY)
            let moveAction = SKAction.move(to: destination, duration: 2.0)
            redTarget.run(moveAction)
            
        }
        
        // Animate the green targets
        for greenTarget in greenTargets {
            let randomX = CGFloat(arc4random_uniform(xRange)) - 110
            let randomY = CGFloat(arc4random_uniform(yRange))
            let destination = CGPoint(x: randomX, y: randomY)
            let moveAction = SKAction.move(to: destination, duration: 2.0)
            greenTarget.run(moveAction)
           
        }
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            let redDotNode = nodes(at: location).first(where: { $0.name?.hasPrefix("redDot") == true })
            if let redDotNode = redDotNode {
                print("Tapped on red dot")

                for greenTargetNode in greenTargets {
                    if greenTargetNode.contains(redDotNode.position) {
                        score += 1
                        print("Green target tapped at red dot")
                        scoreLabel.text = "Score: \(score)"
                        print(score)
                    }
                }

                for redTargetNode in redTargets {
                    if redTargetNode.contains(redDotNode.position) {
                        score -= 1
                        print("Red target tapped at red dot")
                        scoreLabel.text = "Score: \(score)";
                        print(score)
                    }
                

                }
            }

            if let shotSlotNode = self.sprite.childNode(withName: "shotSlot"), shotSlotNode.contains(location) {
                if let redDotNode = self.childNode(withName: "redDott") {
                    redDotNode.position = location
                    print("Moved red dot to location: \(location)")
                }
            }

            if let powerBarNode = self.sprite.childNode(withName: "powerBar"), powerBarNode.contains(location) {
                isPowerBarSelected = true
                powerBarInitialPosition = powerBarNode.position
                touchLocation = location
                lastUpdateTime = touch.timestamp
            }

            // Check if the spinning red target was tapped
            if let redTargetNode = self.childNode(withName: "bigTarget"), redTargetNode.contains(location) {
                print("Tapped on red target")
                // Show other children
                for child in self.children {
                    if child.isHidden {
                        child.isHidden = false
                    }
                }
             //   addChild(redDott)
                addChild(buttonFrame)
                addChild(backGround)
                // addChild(gameScore)
                addChild(scoreLabel)
                addChild(button)
                //    addChild(redTarget)
                //   addChild(redTargett)
                //   addChild(greenTarget)
                
                view?.addSubview(timerLabel)
              //  addChild(shotSlot)
                
//                addChild(redDott)
                
                // addChild(sprite)
                
                
                
                print("Nodes unhidden")
                backGroundd.removeFromParent()
                intro.removeFromParent()
                framee.removeFromParent()
                BigTarget.removeFromParent()
                shadowNode.removeFromParent()
                playNowButton.removeFromParent()
                founder.removeFromParent()
                framee.removeFromParent()
                frameee.removeFromParent()
                fframee.removeFromParent()
                
                // Create slots
                for i in 0..<3 {
                    let (slot1, redDott1) = createSlot(at: CGPoint(x: 120 + (i * 370), y: 560), redDotName: "redDott1")
                    let (slot2, redDott2) = createSlot(at: CGPoint(x: 120 + (i * 370), y: 370), redDotName: "redDott2")
                    let (slot3, redDott3) = createSlot(at: CGPoint(x: 120 + (i * 370), y: 200), redDotName: "redDott3")
                    addChild(slot1)
                    addChild(slot2)
                    addChild(slot3)
                    addChild((redDott1!)
                    addChild(redDott2!)
                    addChild(redDott3!)
                }


                // Create targets
                for i in 0..<1 {
                    let greenTarget = createGreenTarget(at: CGPoint(x: 120 + (i * 370), y: 560))
                            addChild(greenTarget)
                   
                }
                
                for i in 0..<1 {
                    let redTarget = createRedTarget(at: CGPoint(x: 860 + (i * 370), y: 200))
                          addChild(redTarget)
                  
                }
                
            }
            
        }

        // Check if the play button was tapped
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)

        for node in touchedNodes {
            if node.name == "playButton" {
                print("Play button tapped")
                playButtonTapped()
            }
        }
    }

    @objc func playButtonTapped() {
        if isPlaying {
            // Pause the game
           

            isPlaying = false
          //  timerLabel.text = "\(remainingTime)"
            isPaused = true // toggle the paused state
            button.text = "Tap to Play"
            // Pause game logic
            aPlayer?.pause()
            moveTimer?.invalidate()
        } else {
            // Start the game
            isPlaying = true
            aPlayer?.play()
            print("Tap to play!")
            isPaused = false // toggle the paused state
            button.text = "Pause Game"
            // Start game logic
            moveTimer?.invalidate()
            moveTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
                self?.moveTargets()
            }
            
            
            // this is the amount
          //  resetTimer()
            // Start the timer for remaining time
         // or any other value you want to set initially
        //timerLabel.text = "\(remainingTime)"
            moveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.timerLabel.text = "\(self.remainingTime)"
                // this puts the timer on the screen and makes it work correctly
                self.remainingTime -= 1
              //  self.timerLabel.text = "\(self.remainingTime)"
                if self.remainingTime == 0 {
                    self.endGame()
                    self.isPlaying = false
                    self.isPaused = true
                    self.timerLabel.text = "Game Over! Score: \(self.score)"
                    self.audioPlayer?.play()
                    self.aPlayer?.stop()
                    self.moveTimer?.invalidate()
                    self.remainingTime = 60
                    self.score = 0
                    self.scoreLabel.text = "Score \(self.score)"
                  //  self.resetTimer()
                  
                }
              
               
            }
           
            
        }
        
        if remainingTime == 0 {
           
        }
       
       // self.resetTimer()
    }
    func pauseGame() {
        isPlaying = false
           moveTimer?.invalidate()
           moveTimer = nil
            // Pause the game animation
            isGameRunning = false
          button.text = "Tap to Play"
            // Add code to pause the game animation
        }

    // now we need to make this greenTarget slide.
   
    func endGame() {
        func endGame() {
            isGameRunning = false
            moveTimer?.invalidate()
            moveTimer = nil
            // any other game-related cleanup code goes here
        }


            // Handle the end of the game...
        }
    
 
    
 
  

    func startTimer() {
        moveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.remainingTime -= 1
            self.timerLabel.text = "\(self.remainingTime)"
            if self.remainingTime == 0 {
                self.endGame()
                self.audioPlayer?.play()
            }
        }
    }

    func resetTimer() {
        remainingTime = 60 // or any other value you want to set initially
        timerLabel.text = "\(remainingTime)"
        moveTimer?.invalidate()
        moveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.remainingTime -= 1
            self.timerLabel.text = "\(self.remainingTime)"
            if self.remainingTime == 0 {
                self.endGame()
                self.isPlaying = false
                self.isPaused = true
                self.timerLabel.text = "Game Over!: Score: \(self.score)"
                self.audioPlayer?.play()
                self.moveTimer?.invalidate()
            }
        }
    }

  
   
    func slotTapped(_ slot: shotSlot) {
        // Make the slot sprite blink
        print("Tapped on slot")
        let blinkOut = SKAction.fadeAlpha(to: 0.2, duration: 0.15)
        let blinkIn = SKAction.fadeAlpha(to: 1, duration: 0.15)
        let blink = SKAction.sequence([blinkOut, blinkIn])
        let blinkForever = SKAction.repeatForever(blink)
        slot.sprite.run(blinkForever)
        print("Started blinking")
        // Handle the slot tap logic
        if slot === shotSlotNode {
            print("Tapped on shot slot node")
        }
    }

  
  
  

    func createGreenTarget(at position: CGPoint) -> SKNode {
        let target = SKSpriteNode(imageNamed: "greenTarget")
        target.position = position
        target.name = "greenTarget"
        target.zPosition = 50
       // addChild(target)
        return target
    }

   
    
    func createRedTarget(at position: CGPoint) -> SKNode {
        let targett = targetSlotRed()
        
      targett.configure(at: position)
        
        targett.configure(at: position)
 
        
     //   addChild(targett)
      //  slotsRed.append(targett)
        return targett
    }
    
    func setupAudioPlayer() {
           guard let url = Bundle.main.url(forResource: "cute", withExtension: "mp3") else {
               return
           }
           
           do {
               audioPlayer = try AVAudioPlayer(contentsOf: url)
               audioPlayer?.prepareToPlay()
           } catch {
               print("Error loading audio file: \(error)")
           }
       }
    func setupAudioPlayer2() {
           guard let url = Bundle.main.url(forResource: "chill", withExtension: "mp3") else {
               return
           }
           
           do {
               aPlayer = try AVAudioPlayer(contentsOf: url)
               aPlayer?.prepareToPlay()
           } catch {
               print("Error loading audio file: \(error)")
           }
       }
    
    func setupAudioPlayer3() {
           guard let url = Bundle.main.url(forResource: "intro", withExtension: "mp3") else {
               return
           }
           
           do {
               aPlayer = try AVAudioPlayer(contentsOf: url)
               aPlayer?.prepareToPlay()
           } catch {
               print("Error loading audio file: \(error)")
           }
       }
       
       // ...
   

  override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
}
