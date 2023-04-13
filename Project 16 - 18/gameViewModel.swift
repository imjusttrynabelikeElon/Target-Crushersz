//
//  gameViewModel.swift
//  Project 16 - 18
//
//  Created by Karon Bell on 4/9/23.
//


import UIKit
import SpriteKit
import AVFoundation
import Foundation



//
class GameViewModel: SKScene, ObservableObject {
    var gS: GameScene?
    
    
    
    
    
    weak var gameScene: GameScene?
    
    
    init(gameScene: GameScene) {
        self.gameScene = gameScene
        super.init(size: gameScene.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: gameScene!.self)
            
            
            
            
            let tappedNode = gameScene?.nodes(at: location).first(where: { gameScene!.redDotNodes.contains($0) })
            
            if let redDotNode = tappedNode {
                // handle touch on red dot here
                
                print("Tapped on red dot")
                
                for greenTargetNode in gameScene!.greenTargets {
                    if greenTargetNode.contains(redDotNode.position) {
                        gameScene!.score += 1
                        print("Green target tapped at red dot")
                        gameScene!.scoreLabel.text = "Score: \(gameScene?.score)"
                        print(gameScene?.score)
                    }
                }
                
                for redTargetNode in gameScene!.redTargets {
                    if redTargetNode.contains(redDotNode.position) {
                        gameScene!.score -= 1
                        print("Red target tapped at red dot")
                        gameScene!.scoreLabel.text = "Score: \(gameScene!.score)"
                        print(gameScene?.score)
                    }
                }
            }
            
            
            
            // the touchesBegan is not underStanding the withname "redDott" because I put "green" and the score with up everytime I tapped on the green target
            
            if let shotSlotNode = gameScene!.self.childNode(withName: "shotSlot"), shotSlotNode.contains(location) {
                if let redDotNode =  gameScene!.self.childNode(withName: "redDott") {
                    redDotNode.position = location
                    print("Moved red dot to location: \(location)")
                }
            }
            
            if let powerBarNode = gameScene!.self.childNode(withName: "powerBar"), powerBarNode.contains(location) {
                gameScene?.isPowerBarSelected = true
                gameScene?.powerBarInitialPosition = powerBarNode.position
                gameScene?.touchLocation = location
                gameScene?.lastUpdateTime = touch.timestamp
            }
            
            // Check if the spinning red target was tapped
            if let redTargetNodes = gameScene!.self.children.filter({ $0.name == "bigTarget" }) as? [SKSpriteNode],
               let redTargetNode = redTargetNodes.first(where: { $0.contains(location) }) {
                
                // Loop through the array of red target nodes and add them to the scene
                
                print("UJHV")
                // Show other children
                for  child in gameScene!.self.children {
                    if child.isHidden {
                        child.isHidden = false
                        
                    }
                    
                }
                
                gameScene?.addChild((gameScene?.button)!)
                gameScene?.addChild((gameScene!.buttonFrame)!)
                gameScene?.addChild(gameScene!.backGround)
                gameScene?.addChild((gameScene?.scoreLabel)!)
                gameScene?.addChild((gameScene?.highScoreLabel)!)
                
                
                gameScene!.view?.addSubview((gameScene!.timerLabel)!)
                
                for target in gameScene!.redTargets {
                    gameScene?.addChild(target)
                    
                    
                }
                
                for target in gameScene!.greenTargets {
                    gameScene?.addChild(target)
                }
                
                
                
                gameScene?.backGroundd.removeFromParent()
                gameScene?.intro.removeFromParent()
                gameScene?.framee.removeFromParent()
                gameScene?.BigTarget.removeFromParent()
                gameScene?.shadowNode.removeFromParent()
                gameScene?.playNowButton.removeFromParent()
                gameScene?.founder.removeFromParent()
                gameScene?.framee.removeFromParent()
                gameScene?.frameee.removeFromParent()
                gameScene?.fframee.removeFromParent()
                
            }
            
        }
        
        // Check if the play button was tapped
        guard let touch = touches.first else { return }
        let location = touch.location(in: gameScene!.self)
        let touchedNodes = gameScene!.nodes(at: location)
        
        for node in touchedNodes {
            if node.name == "playButton" {
                print("Play button tapped")
                playButtonTapped()
                print("ONJ")
            }
        }
        
    }
    
    
    
    
    @objc func playButtonTapped() {
        
        
        if gameScene!.isPlaying {
            // Pause the game
            
            
            gameScene!.isPlaying = false
            //  timerLabel.text = "\(remainingTime)"
            gameScene!.isPaused = true // toggle the paused state
            gameScene?.button.text = "Tap to Play"
            // Pause game logic
            gameScene?.aaPlayer?.pause()
            gameScene?.moveTimer?.invalidate()
        } else {
            // Start the game
            
            gameScene!.isPlaying = true
            gameScene!.aaPlayer?.play()
            print("Tap to play!")
            gameScene?.isPaused = false // toggle the paused state
            gameScene?.button.text = "Pause Game"
            // Start game logic
            gameScene?.moveTimer?.invalidate()
            gameScene?.moveTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
                self?.moveTargets()
            }
            
            // this is amount
            // this is the amount
            // this
            //  resetTimer()
            // Start the timer for remaining time
            // or any other value you want to set initially
            //timerLabel.text = "\(remainingTime)"
            gameScene?.moveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.gameScene!.timerLabel.text = "\(self.gameScene!.remainingTime)"
                // this puts the timer on the screen and makes it work correctly
                self.gameScene!.remainingTime -= 1
                //  self.timerLabel.text = "\(self.remainingTime)"
                if self.gameScene!.remainingTime == 0 {
                    
                    self.endGame()
                    //  self.resetTimer()
                    //  self.createHomePage()
                    
                    //  self.createHomePage()
                    
                    
                    // Check if the user beat the high score
                    
                    
                    
                    // Reset the score to 0
                }
                
            }
            
        }
        
        if gameScene?.remainingTime == 0 {
            
        }
        
        // self.resetTimer()
    }
    
    
    func pauseGame() {
        gameScene!.isPlaying = false
        gameScene?.moveTimer?.invalidate()
        gameScene?.moveTimer = nil
        //  gameScene?.Pause the game animation
        gameScene?.isGameRunning = false
        gameScene?.button.text = "Tap to Play"
        // Add code to pause the game animation
    }
    
    // now we need to make this greenTarget slide.
    
    func endGame() {
        gameScene!.isPlaying = false
        gameScene?.isPaused = true
        if  gameScene!.isPaused {
            gameScene?.button.text = "Play Again"
            
            
        } else  {
            gameScene?.aaPlayer?.play()
            //  player()
        }
        
        
        
        gameScene?.timerLabel.text = "Game Over! Score: \(gameScene!.score)"
        resetTimer()
        gameScene?.aaPlayer?.stop()
        gameScene?.audioPlayer?.play()
        gameScene?.aPlayer?.stop()
        
        
        gameScene?.moveTimer?.invalidate()
        // Check if the user beat the high score
        if gameScene!.score > gameScene!.highScore {
            // Update the high score
            gameScene?.highScore =  gameScene!.score
            UserDefaults.standard.set( gameScene?.highScore, forKey: "highScore")
            print("New high score: \(UserDefaults.standard.integer(forKey: "highScore"))")
        }
        // Reset the score to 0
        gameScene?.score = 0
        gameScene?.scoreLabel.text = "Score: \(gameScene!.score)"
        
        
        
        
    }
    
    
    func startTimer() {
        gameScene?.moveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.gameScene?.remainingTime -= 1
            self.gameScene?.timerLabel.text = "\(self.gameScene!.remainingTime)"
            if self.gameScene?.remainingTime == 0 {
                self.endGame()
                self.gameScene?.audioPlayer?.play()
            }
        }
    }
    
    func resetTimer() {
        gameScene?.remainingTime = 6 // or any other value you want to set initially
        gameScene?.timerLabel.text = "\(gameScene!.remainingTime)"
        gameScene?.moveTimer?.invalidate()
        gameScene?.moveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.gameScene?.remainingTime -= 1
            self.gameScene?.timerLabel.text = "\(self.gameScene!.remainingTime)"
            if self.gameScene?.remainingTime == 0 {
                self.endGame()
                self.gameScene!.isPlaying = false
                self.isPaused = true
                self.gameScene?.timerLabel.text = "Game Over!: Score: \(self.gameScene!.score)"
                self.gameScene?.audioPlayer?.play()
                self.gameScene?.moveTimer?.invalidate()
                
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
        if slot == gameScene?.shotSlotNode {
            print("Tapped on shot slot node")
        }
    }
    
    
    func moveTargets() {
        let screenSize = UIScreen.main.bounds.size
        let xRange = UInt32(screenSize.width - 50)
        let yRange = UInt32(screenSize.height - 50)
        
        // Animate the red targets
        for redTarget in gameScene!.redTargets {
            let randomX = CGFloat(arc4random_uniform(xRange)) - 110
            let randomY = CGFloat(arc4random_uniform(yRange))
            let destination = CGPoint(x: randomX, y: randomY)
            let moveAction = SKAction.move(to: destination, duration: 2.0)
            redTarget.run(moveAction)
            
        }
        
        // Animate the green targets
        for greenTarget in gameScene!.greenTargets {
            let randomX = CGFloat(arc4random_uniform(xRange)) - 110
            let randomY = CGFloat(arc4random_uniform(yRange))
            let destination = CGPoint(x: randomX, y: randomY)
            let moveAction = SKAction.move(to: destination, duration: 2.0)
            greenTarget.run(moveAction)
            
        }
    }
    
    
    func createGreenTarget(at position: CGPoint)  {
        
        gameScene?.targeet.position = position
        gameScene?.targeet.name = "greenTarget"
        gameScene?.targeet.zPosition = 50
        // addChild(targeet)
        
    }
    
    
    func createRedTarget(at position: CGPoint)  {
        
        
        gameScene!.targeett.configure(at: position)
        
        gameScene!.targeett.configure(at: position)
        
        
        //   addChild(targeett)
        //  slotsRed.append(targeett)
        
    }
    
    func setupAudioPlayer() {
        guard let url = Bundle.main.url(forResource: "cute", withExtension: "mp3") else {
            return
        }
        
        do {
            gameScene?.audioPlayer = try AVAudioPlayer(contentsOf: url)
            gameScene?.audioPlayer?.prepareToPlay()
            
        } catch {
            print("Error loading audio file: \(error)")
        }
    }
    func setupAudioPlayer2() {
        guard let url = Bundle.main.url(forResource: "MC", withExtension: "mp3") else {
            return
        }
        
        do {
            gameScene?.aPlayer = try AVAudioPlayer(contentsOf: url)
            gameScene?.aPlayer?.prepareToPlay()
            
        } catch {
            print("Error loading audio file: \(error)")
        }
    }
    
    
    // ...
    
    
    
    func player() {
        
        if let path = Bundle.main.path(forResource: "MC", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                gameScene!.aaPlayer = try AVAudioPlayer(contentsOf: url)
                gameScene!.aaPlayer?.play()
                gameScene!.aaPlayer?.numberOfLoops = -1
            } catch {
                print("Error loading audio file")
            }
        }
        
        // logic code
        
        
        
    }
    
}
