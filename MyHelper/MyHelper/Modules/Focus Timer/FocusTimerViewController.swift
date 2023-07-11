//
//  FocusTimerViewController.swift
//  MyHelper
//
//  Created by Диана Аксакова on 11.07.2023.
//

import UIKit

class FocusTimerViewController: ViewController{
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var timer = Timer()
    var seconds = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: Any) {
        if (seconds != 0){
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1,target: self,selector: #selector(FocusTimerViewController.timerClass),userInfo: nil,repeats: true)
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        seconds = 60;
        timeLabel.text = String(seconds)
    }
    
    @IBAction func plusButton(_ sender: Any) {
        seconds = seconds + 15
        timeLabel.text = String(seconds)
    }
    
    @IBAction func minusButton(_ sender: Any) {
        if (seconds != 0){
            seconds = seconds - 15
            timeLabel.text = String(seconds)
        }
    }
    
    @objc func timerClass(){
        seconds -= 1
        timeLabel.text = String(seconds)
        
        if (seconds == 0){
            timer.invalidate()
        }
    }
}
