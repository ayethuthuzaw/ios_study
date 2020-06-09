//
//  PlayViewController.swift
//  GestureFlash
//
//  Created by Aye Thu Thu Zaw on 2020/06/09.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var completedGesturesLabel: UILabel!
    @IBOutlet weak var gestureImage: UIImageView!
    
    var startTime = NSDate()
    var completedGestures = Int()
    var currentGesture = Int()

    var timer = Timer()
    var timerCount = Double()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        var elapsedTime = startTime.timeIntervalSinceNow
        elapsedTime = -(elapsedTime)

        if segue.identifier == "toResultView" {
            let rvc = segue.destination as! ResultViewController
            rvc.time = elapsedTime
        }
    }
    
    func nextProblem() {
        
        if completedGestures == 30 {
            self.performSegue(withIdentifier: "toResultView", sender: self)
        } else {

            let gestureIcons = [
                UIImage(named: "swipe-right"),
                UIImage(named: "swipe-left"),
                UIImage(named: "swipe-up"),
                UIImage(named: "swipe-down"),
                UIImage(named: "pinch-in"),
                UIImage(named: "pinch-out"),
                UIImage(named: "rotate-right"),
                UIImage(named: "rotate-left")
            ]

            currentGesture = Int(arc4random() % 8)
            NSLog("got new gesture current: %d", currentGesture)

            gestureImage.image = gestureIcons[currentGesture]
            completedGesturesLabel.text = String(format: "%d", completedGestures)
        }
    }
    
    func setGestureRecognizers() {

        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(PlayViewController.pinchDetected(sender:)))
        self.view.addGestureRecognizer(pinchRecognizer)
        
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(PlayViewController.rotationDetected(sender:)))
        self.view.addGestureRecognizer(rotationRecognizer)

        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PlayViewController.swipeRightDetected(sender:)))
        swipeRightRecognizer.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRightRecognizer)

        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PlayViewController.swipeLeftDetected(sender:)))
        swipeLeftRecognizer.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeftRecognizer)

        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PlayViewController.swipeUpDetected(sender:)))
        swipeUpRecognizer.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUpRecognizer)

        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PlayViewController.swipeDownDetected(sender:)))
        swipeDownRecognizer.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDownRecognizer)
    }
    
    @objc func swipeRightDetected(sender: UIGestureRecognizer) {
        NSLog("右向きSwipe")
        NSLog("current: %d", currentGesture)

        if currentGesture == 0 {
            NSLog("NEXT")
            completedGestures += 1
            self.nextProblem()
        }
    }

    @objc func swipeLeftDetected(sender: UIGestureRecognizer) {
        NSLog("左向きSwipe")
        NSLog("current: %d", currentGesture)
 
        if currentGesture == 1 {
            NSLog("NEXT")
            completedGestures += 1
            self.nextProblem()
        }
    }

    @objc func swipeUpDetected(sender: UIGestureRecognizer) {
        NSLog("上向きSwipe")
        NSLog("current: %d", currentGesture)

        if currentGesture == 2 {
            NSLog("NEXT")
            completedGestures += 1
            self.nextProblem()
        }
    }

    @objc func swipeDownDetected(sender: UIGestureRecognizer) {
        NSLog("下向きSwipe")
        NSLog("current: %d", currentGesture)

        if currentGesture == 3 {
            NSLog("NEXT")
            completedGestures += 1
            self.nextProblem()
        }
    }
    
    @objc func rotationDetected(sender: UIRotationGestureRecognizer) {
        let radians = sender.rotation

        let degrees = radians * CGFloat(180/M_PI)
        if degrees > 90 {
            NSLog("時計回りにRotate degrees: %f", degrees)
            NSLog("current: %d", currentGesture)
            if currentGesture == 6 {
                NSLog("NEXT")
                completedGestures += 1
                self.nextProblem()
            }
        } else if degrees < -90 {
            NSLog("反時計回りにRotate degrees: %f", degrees)
            NSLog("current: %d", currentGesture)

            if currentGesture == 7 {
                NSLog("NEXT")
                completedGestures += 1
                self.nextProblem()
            }
        }
    }
    
    @objc func pinchDetected(sender: UIPinchGestureRecognizer) {

        let scale = sender.scale
        if scale > 2.4 {
            NSLog("外向きにPinch scale: %f", scale)
            NSLog("current: %d", currentGesture)

            if currentGesture == 5 {
                NSLog("NEXT")
                completedGestures += 1
                self.nextProblem()
            }
        } else if scale < 0.4 {
            NSLog("内向きにPinch scale: %f", scale)
            NSLog("current: %d", currentGesture)

            if currentGesture == 4 {
                NSLog("NEXT")
                completedGestures += 1
                self.nextProblem()
            }
        }
    }
    
    @objc func onTimer(timer: Timer) {
        timerCount = timerCount + 0.1
        timeLabel.text = String(format: "%.1f", timerCount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        completedGestures = 0
        self.setGestureRecognizers()
        self.nextProblem()
        
        timerCount = 0
        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(PlayViewController.onTimer(timer:)),
            userInfo: nil,
            repeats: true
        )
        
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
