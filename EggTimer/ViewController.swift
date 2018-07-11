//
//  ViewController.swift
//  EggTimer
//
//  Created by Adam Moore on 3/19/18.
//  Copyright © 2018 Adam Moore. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var timer = Timer()
    
    var startingTime = Int()
    
    var timeLeft = Int()
    
    var timerIsGoing = false
    
    func startTimer() {
        if timerIsGoing == false {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.processTimer), userInfo: nil, repeats: true)
            timerIsGoing = true
        }
    }
    
    func stopTimer() {
        if timerIsGoing == true {
            timer.invalidate()
            timerIsGoing = false
        }
    }
    
    func resetTimer() {
        timer.invalidate()
        timerLabel.text = String(startingTime)
        timeLeft = startingTime
        timerIsGoing = false
    }
    
    func add10Seconds() {
        guard let currentTime = Int(timerLabel.text!) else {
            return
        }
        timeLeft = currentTime + 10
        if timeLeft > startingTime {
            timeLeft = startingTime
        }
        timerLabel.text = String(timeLeft)
    }
    
    func subtract10Seconds() {
        guard let currentTime = Int(timerLabel.text!) else {
            return
        }
        timeLeft = currentTime - 10
        if timeLeft < 0 {
            timeLeft = currentTime
        }
        timerLabel.text = String(timeLeft)
    }
    
    @objc func processTimer() {
        if timeLeft > 0 {
            timeLeft -= 1
        } else {
            timer.invalidate()
            timerIsGoing = false
        }
        timerLabel.text = String(timeLeft)
    }
    
    @IBOutlet weak var timerTextField: UITextField!
    
    @IBAction func setTimerLabelFromTextField(_ sender: UIButton) {
        guard let inputtedSecondsFromTimerTextField = Int(timerTextField.text!) else {
            startingTime = 210
            timeLeft = startingTime
            return
        }
        startingTime = inputtedSecondsFromTimerTextField
        timeLeft = startingTime
        timerLabel.text = String(timeLeft)
    }
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func startTimerButton(_ sender: UIBarButtonItem) {
        startTimer()
    }
    
    @IBAction func stopTimerButton(_ sender: UIBarButtonItem) {
       stopTimer()
    }
    
    @IBAction func resetTimerButton(_ sender: UIBarButtonItem) {
        resetTimer()
    }
    
    @IBAction func add10SecondsButton(_ sender: UIBarButtonItem) {
        add10Seconds()
    }
    
    @IBAction func subtract10SecondsButton(_ sender: UIBarButtonItem){
        subtract10Seconds()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timerLabel.text = ""
        timerTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        timerTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

