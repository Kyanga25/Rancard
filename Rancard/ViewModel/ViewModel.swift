//
//  ViewModel.swift
//  Random
//
//  Created by Nathanael Mukyanga on 2024-04-24.
//
import SwiftUI
import AVFoundation
import AVKit

class ViewModel: ObservableObject {
    @Published public var model = Model()
    @Published public var audioPlayer: AVAudioPlayer?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    enum Play: String {
        case Win, Loose
    }
    
    @Published public var sounds: Play = .Loose
    
    func plays() {
        do {
            guard let soundPath = Bundle.main.path(forResource: sounds.rawValue, ofType: "mp3") else {
                print("Error: Sound file not found")
                return
            }
            
            let soundURL = URL(fileURLWithPath: soundPath)
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            // Ensure audio player is prepared before playing
            self.audioPlayer?.prepareToPlay()
            
            if model.trigger >= 0 {
                self.audioPlayer?.play()
            }
            
            if model.mute {
                self.audioPlayer?.volume = 0
            } else {
                self.audioPlayer?.volume = Float(model.vol)
            }
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func button() {
        self.model.currentScore = Int.random(in: 1...9)
        if model.index == model.currentScore {
            self.model.click = false
            self.sounds = .Win
            self.model.trigger += 1
        } else if model.index != model.currentScore {
            self.model.failure += 1
            self.sounds = .Loose
            plays()
        }
    }
}
