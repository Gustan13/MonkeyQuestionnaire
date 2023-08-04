//
//  SoundManager.swift
//  Quiz
//
//  Created by Gustavo Binder on 03/08/23.
//

import AVFoundation

class SoundManager {
    static var audioPlayer: AVAudioPlayer?

    static func playSound(_ sound: String, type: String, loops: Int) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                audioPlayer?.numberOfLoops = loops
            } catch {
                print("ERROR")
            }
        }
    }
}
