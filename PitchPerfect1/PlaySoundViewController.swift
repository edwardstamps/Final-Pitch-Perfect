//
//  PlaySoundViewController.swift
//  PitchPerfect1
//
//  Created by Edward Stamps on 1/6/15.
//  Copyright (c) 2015 Edward Stamps. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!

    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    @IBOutlet weak var PlaySlow: UIButton!

    @IBOutlet weak var PlayFast: UIButton!
    
    @IBOutlet weak var PlayHigh: UIButton!
   
    @IBOutlet weak var PlayDown: UIButton!
    
    @IBOutlet weak var Stop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    audioPlayer=AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
    audioPlayer.enableRate=true
        
    audioEngine = AVAudioEngine()
    audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)

   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func PlaySlow(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate=0.5
        audioPlayer.currentTime=0.0
        audioPlayer.play()
        
    }
  
  
    @IBAction func PlayFast(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate=1.5
        audioPlayer.currentTime=0.0
        audioPlayer.play()
    }
    
    @IBAction func PlayHigh(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func PlayDown(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
       
    }
    

    @IBAction func Stop(sender: UIButton) {
        audioPlayer.stop()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
