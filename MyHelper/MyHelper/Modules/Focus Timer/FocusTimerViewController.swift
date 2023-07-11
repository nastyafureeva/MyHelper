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
    
    var timer = Timer()
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @IBAction func startButton(_ sender: Any) {
        if (seconds != 0){
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1,target: self,selector: #selector(FocusTimerViewController.timerClass),userInfo: nil,repeats: true)
        }
        timeLabel.textColor = .brown
        
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
        timeLabel.textColor = .red
    }
    
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        seconds = 0;
        timeLabel.text = "\(seconds / 3600):\((seconds % 3600) / 60):\((seconds % 3600) % 60)"
    }
    
    
    @objc func timerClass(){
            seconds -= 1
            timeLabel.text = String(seconds)
            
            if (seconds == 0){
                timer.invalidate()
            }
            
            self.timeLabel.text = "\(seconds / 3600):\((seconds % 3600) / 60):\((seconds % 3600) % 60)"
        }
    
    @IBAction func newTime(_ sender: Any) {
            let alertController = UIAlertController(title: "Установка таймера", message: "Введите время", preferredStyle: .alert)

            alertController.addTextField { (textField) in
                textField.placeholder = "Часы"
                textField.keyboardType = .numberPad
            }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Минуты"
                textField.keyboardType = .numberPad
            }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Секунды"
                textField.keyboardType = .numberPad
            }

            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            let setTimerAction = UIAlertAction(title: "Установить", style: .default) { (_) in
                guard let hoursText = alertController.textFields?[0].text,
                      let minutesText = alertController.textFields?[1].text,
                      let secondsText = alertController.textFields?[2].text,
                      let hours = Int(hoursText),
                      let minutes = Int(minutesText),
                      let seconds = Int(secondsText) else { return }
                
                let timeInSeconds = (hours * 3600) + (minutes * 60) + seconds
                
                self.seconds  = timeInSeconds
                
                
                self.timeLabel.text = "\(timeInSeconds / 3600):\((timeInSeconds % 3600) / 60):\((timeInSeconds % 3600) % 60)"
                print("Установлен таймер на \(hours) часов и \(minutes) минут (\(timeInSeconds) секунд)")
            }
            alertController.addAction(setTimerAction)
            
        

            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
            rootViewController?.present(alertController, animated: true, completion: nil)
        }
}
