import Foundation
import AVFoundation


class MusicPlayer {
  static let shared = MusicPlayer()
  var audioPlayer: AVAudioPlayer?
  var volumeEnable = true
   
  func clickSound() {
    if AppDelegate.shared.volumeEnable {
      guard let url = Bundle.main.url(forResource: "small", withExtension: "mp3") else { return }
      
      do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try AVAudioSession.sharedInstance().setActive(true)
        
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        
        guard let aPlayer = audioPlayer else { return }
        aPlayer.play()
        
      } catch let error {
        print(error.localizedDescription)
      }
    } else {
      return
    }
  }
    
    
}

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
    }
}
