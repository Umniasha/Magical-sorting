//
//  MainViewController.swift
//  Magical sorting
//
//  Created by Oleg Arnaut  on 22.08.2023.
//

import UIKit
import SpriteKit
import AVFoundation

class MainViewController: UIViewController{

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MusicHelper.sharedHelper.playBackgroundMusic()
        // Do any additional setup after loading the view.
    }
    
  
    
    @IBAction func toMain(_ unwindSegue: UIStoryboardSegue){
        
    }

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
