//
//  Clap.swift
//  ClapBeat
//
//  Created by Aye Thu Thu Zaw on 2020/06/05.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit
import AudioToolbox

class Clap: NSObject {
        var soundURL = NSURL()
        var soundID = SystemSoundID()


func setSound() {
    let mainBundle = CFBundleGetMainBundle()
    soundURL = CFBundleCopyResourceURL(mainBundle, "clap" as CFString?, "wav" as CFString?, nil)
    AudioServicesCreateSystemSoundID(soundURL, &soundID)
}
func play() {
    AudioServicesPlaySystemSound(soundID)
}

func repeatClap(count: Int) {
    var i = 0
    while(i < count) {
        self.play()
        i = i + 1
        usleep(500000);
    }
}
    override init() {
        super.init()
        setSound()
    }

}
