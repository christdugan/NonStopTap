//
//  ViewController.swift
//  NonStopTap
//
//  Created by Christopher Dugan on 4/19/16.
//  Copyright © 2016 ctd. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var bassButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var player: AVAudioPlayer!

    var timer: NSTimer! //main tapper timer
    var colorTimer: NSTimer! //additional timer for interval of bass button color change
    
    var sectionCount = 0.0
    var score = 0
    
    var isRed = true
    var didScore = false
    
    var track = Track() //initialize demo track
    
    //song time duration between changes in beat rate
    var firstSectionDuration: Double = 25.0
    var secondSectionDuration: Double = 0.0
    //TO DO: manually time other song sections, input values
    
    override func viewDidLoad() {
        super.viewDidLoad()
        track.setupTrack()
        track.calculateBPMrates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func runSection(beat: Double) {
        timer = NSTimer.scheduledTimerWithTimeInterval(beat, target: self, selector: "runScoreFlow", userInfo: nil, repeats: true)
    }
    
    func runScoreFlow() {
        //reset ability to score / tap button
        bassButton.backgroundColor = UIColor.redColor()
        isRed = true
        didScore = false
        
        //continues until number of beats * beat duration = duration of section
        sectionCount += track.eighthBeat
        if (sectionCount >= firstSectionDuration) {
            //reset main timer and sectionCount following completion of section
            timer = nil
            sectionCount = 0
        }
        else {
            //timer to reset button using different beat rate to create clickable window
            colorTimer = NSTimer.scheduledTimerWithTimeInterval(track.sixteenthBeat, target: self, selector: "resetBassButton", userInfo: nil, repeats: false)
        }
    }
    
    @IBAction func bassButtonTap(sender: AnyObject) {
        //gain points when tapping bass button during green intervals, lose when tapping during red intervals
        if (isRed) {
            score -= 1
            scoreLabel.text = "\(score)"
        }
        else if (!isRed && !didScore) {
            score += 1
            scoreLabel.text = "\(score)"
            didScore = true
        }
    }
    
    func resetBassButton() {
        //reset bass button following red intervals
        bassButton.backgroundColor = UIColor.greenColor()
        isRed = false
    }
    
    @IBAction func playButtonTap(sender: AnyObject) {
        if player != nil {
            if player.playing {
                self.player.pause()
                //TO DO: reset counts and values
            }
        }
        else {
            playSong("Aurora", mediaType: "mp3")
            runSection(track.eighthBeat)
            runSection(track.singleBeat)
            //TO DO: run next beat rate sections sequentially
        }
    }
    
    func playSong(songName: String, mediaType: String) {
        //play track of a given filename and media type
        do {
            self.player =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(songName, ofType: mediaType)!))
            self.player.play()
        } catch {
            print("Error dropping the bass")
        }
    }

}

