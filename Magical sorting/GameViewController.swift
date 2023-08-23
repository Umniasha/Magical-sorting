//
//  GameViewController.swift
//  Magical sorting
//
//  Created by Oleg Arnaut  on 15.08.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameScene : GameScene!
    
    
    @IBOutlet weak var tryAgainOutlet: UIButton!
    @IBOutlet var loseImage: [UIImageView]!
    @IBOutlet weak var magic: UIButton!
    @IBOutlet weak var crystalLable: UIButton!
    @IBOutlet weak var timerLable: UIButton!
   
    @IBOutlet weak var nameOutlet: UIStackView!
    
    @IBOutlet weak var backNameOutlet: UIImageView!
    @IBOutlet weak var stackWithResultsOutlet: UIStackView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    @IBOutlet var nameLableCollection: [UILabel]!
    @IBOutlet var scoreLableCollection: [UILabel]!
    @IBOutlet weak var yourTime: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "GameScene") {
                
                scene.scaleMode = .aspectFill
                gameScene = scene as! GameScene
                gameScene.gameViewController = self
                
                view.presentScene(scene)
                
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
       
    }

    override var shouldAutorotate: Bool {
        return true
    }

   
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return  .portrait
        } else {
            return .portrait
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func nextGameButton(_ sender: Any) {
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "GameScene") {
                
                scene.scaleMode = .aspectFill
                gameScene = scene as! GameScene
                gameScene.gameViewController = self
                
                view.presentScene(scene)
                
            }
            
            view.ignoresSiblingOrder = true
            
        }
    }
}
