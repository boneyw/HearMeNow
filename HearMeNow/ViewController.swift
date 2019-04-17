//
//  ViewController.swift
//  HearMeNow
//
//  Created by william boney on 4/16/19.
//  Copyright © 2019 william boney. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var hasRecording = false
    var soundPLayer: AVAudioPlayer?
    var soundRecorder: AVAudioRecorder?
    var session : AVAudioSession?
    var soundPath : String?

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func recordPressed(_ sender: AnyObject) {
        
        if(soundRecorder?.isRecording == true)
        {
            soundRecorder?.stop()
            recordButton.setTitle("Record", for: UIControl.State.normal)
            hasRecording = true
        } else {
            session?.requestRecordPermission(){
                granted in
                if(granted == true)
                {
                    self.soundRecorder?.record()
                    self.recordButton.setTitle("Stop", for: UIControl.State.normal)
                }
                else {
                    print("Unable to record")
                }
            }
        }
    }
    
    @IBAction func playPressed(_ sender: AnyObject) {
        
        if(soundPLayer?.isPlaying == true)
        {
            soundPLayer?.pause()
            playButton.setTitle("Play", for: UIControl.State.normal)
        }
        else if (hasRecording == true)
        {
            let url = NSURL(fileURLWithPath: soundPath!)
            var error : NSError?
            soundPLayer = AVAudioPlayer(contentsOfURL: url, error: &error)
            if(error == nil)
            {
                soundPLayer?.delegate = self
                soundPLayer?.play()
            }
            else {
                print("Error initializing player \(String(describing: error))")
            }
            playButton.setTitle("Pause", for: UIControl.State.normal)
            hasRecording = false
        }
        else if (soundPLayer != nil)
        {
            soundPLayer?.play()
            playButton.setTitle("Pause", for: UIControl.State.normal)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        recordButton.setTitle("Record", for: UIControl.State.normal)
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButton.setTitle("Play", for: UIControl.State.normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        soundPath = "/(NSTemporaryDirectory())hearmenow.wav"
    
        _ = NSURL(fileURLWithPath: soundPath!)
        
        session = AVAudioSession.sharedInstance()
        
        try? AVAudioSession.sharedInstance().setActive(true)
        
        var _ : NSError?
        
        try? AVAudioSession.sharedInstance().setCategory( .playAndRecord, mode: .default, options: [])
        
        
        //soundRecorder = AVAudioRecorder.init(URL: erfl, settings: nil)
        
        
        if(Error.self != nil)
        {
            print("Error initializing the recorder: \(Error.self)")
        }
        soundRecorder?.delegate = self
        soundRecorder?.prepareToRecord(
    
        
    }


}

