//
//  RecordSoundsViewController.swift
//  PitchPerfect1
//
//  Created by Edward Stamps on 12/9/14.
//  Copyright (c) 2014 Edward Stamps. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var recordButton: UIButton!

    @IBOutlet weak var RecordinginProgress: UILabel!
   
    @IBOutlet weak var STOPrecording: UIButton!
    
    @IBOutlet weak var Tap2Record: UIButton!
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    @IBAction func STOPrecording(sender: UIButton) {RecordinginProgress.hidden=true;STOPrecording.hidden=true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        STOPrecording.hidden=true
        recordButton.enabled=true
        Tap2Record.hidden=false
    
    }


    @IBAction func RecordAudio(sender: UIButton) {
        recordButton.enabled=false
        RecordinginProgress.hidden=false
        STOPrecording.hidden=false
        Tap2Record.hidden=true
        
        //TODO: Record the users voice"
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        var currentDateTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        var recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        var pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        // Audio Session
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //initialize and record
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate=self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool){
    if(flag){
        
        recordedAudio=RecordedAudio(filePathUrl:recorder.url, title:recorder.url.lastPathComponent)
        
 
        
        //move to next seen
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
    }else{
        println("Recording was unsuccessful")
        recordButton.enabled=true
        STOPrecording.hidden=true
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier=="stopRecording"){
            let playSoundsVC:PlaySoundViewController = segue.destinationViewController as PlaySoundViewController
            let data = sender as RecordedAudio
            playSoundsVC.recievedAudio = data
        }
    }
        
}

