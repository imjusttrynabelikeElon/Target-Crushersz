//
//  GameViewController.swift
//  Project 16 - 18
//
//  Created by Karon Bell on 2/14/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    // now all the targets are tappable
    // next see why your score is not updating when the green and red targets are tapped.
    var imageView: UIImageView!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    //  let timeIntervalRange = 1.0...3.0 // in seconds
    // let speedRange = 50...100 // in p
    
    // two more big problems... detect when a user taps the screen when a target is at the middle of the slot... aka the red dot only.
    var scoreLabel: UILabel!
    // ...
    let targetSize: CGFloat = 50
    
    var tapGestures: [UIImageView: UITapGestureRecognizer] = [:]

    
    // last randomise the targets for each row to side back and forth at diffrent times and speeds giving a user points when they hit green targets on the red dots and make them lose points when they hit the red targets by mistake
   
    
    var imageViewCopy: UIImageView!
    var currentAnimation = 0
    var redd = UIImageView(image: UIImage(named: "redTarget"))
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
    
    var imageViews: [UIImageView] = []
   
    var greenTargets: [UIImageView] = []
    
    var redTargets: [UIImageView] = []
    // this is the amount of time
    // do some code so for all the image Views with different shapes and sizes so that for each row they use each imageView at random times and different speeds, most likley using a timer.
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //   tapGesture.addTarget(self, action: #selector(handleTap(_:)))
        
        for imageView in imageViews {
       
        //    imageView.isUserInteractionEnabled = true
        
        }
        for imageView in imageViews {
            //    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            //   imageView.isUserInteractionEnabled = true
            //   imageView.addGestureRecognizer(tapGesture)
        }
        
     
        // the big green slots.
//        view.addSubview(imageViewGreenSmall)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                view.isUserInteractionEnabled = true
            }
            
        //    view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            
        }
        
        
        
        for imageView in imageViews {
            
              //  imageView.isUserInteractionEnabled = true
        //    imageView.addGestureRecognizer(tapGesture)
            // print("green target tapped")
             // randomizeAnimation(for: imageView)
        }
        
       
    }
    
     
    
    // this is the amount of the time we will take to have
    
    // this is the reason why ai beleave that I am going to tgo toi the amount of the ocean and I will see
    // now we got it to blink
    
    

    
    

  
  
  





        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return .allButUpsideDown
            } else {
                return .all
            }
        }
        
        override var prefersStatusBarHidden: Bool {
            return true
        }
    }
    

  
