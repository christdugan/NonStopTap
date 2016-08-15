//
//  Track.swift
//  NonStopTap
//
//  Created by Christopher Dugan on 4/19/16.
//  Copyright © 2016 ctd. All rights reserved.
//

import Foundation

class Track {
    
    var name: String = "" //track file name
    var mediaType: String = "" //file type extension
    var bpm: Double = 0 //track beats per minute

    //beat rate values derived by bpm var
    var singleBeat: Double = 0.0
    var halfBeat: Double = 0.0
    var quarterBeat: Double = 0.0
    var eighthBeat: Double = 0.0
    var sixteenthBeat: Double = 0.0
    
    func setupTrack() {
        name = "Aurora"
        mediaType = "mp3"
        bpm = 170.0
    }
    
    func calculateBPMrates() {
        //calculates number of beats per second, half second, quarter second, etc. for varied beat rates to be used per section
        singleBeat = Double(bpm / 60).roundToPlaces(10)
        halfBeat = Double(bpm / 120).roundToPlaces(10)
        quarterBeat = Double(bpm / 240).roundToPlaces(10)
        eighthBeat = Double(bpm / 480).roundToPlaces(10)
        sixteenthBeat = Double(bpm / 960).roundToPlaces(10)
    }
    
}