//
//  ViewController.swift
//  Calculator
//
//  Created by HoangDucLe on 2/10/16.
//  Copyright © 2016 HoangDucLe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            display.text = display.text! + digit
            inputHistory.text = inputHistory.text! + digit
        }   else    {
            display.text=digit
            inputHistory.text = digit
            userIsTyping = true
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsTyping = false
        operandStack.append(displayValue)
        print("operandStack= \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return  NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text="\(newValue)"
            userIsTyping = false
        }
    }

    @IBAction func decimaldot(sender: AnyObject) {
        if (!display.text!.containsString(".")) {
            display.text = display.text! + "."
        }
        if (!inputHistory.text!.containsString(".")) {
            inputHistory.text = inputHistory.text! + "."
        }
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
            inputHistory.text = inputHistory.text! + operation
        switch operation {
            case "×": performOperation {$0 * $1}
            case "÷": performOperation {$1 / $0}
            case "+": performOperation {$0 + $1}
            case "−": performOperation {$1 - $0}
            case "√": performOperation1 {sqrt($0)}
            case "π": operandStack.append(M_PI)
            case "sin": performOperation1 {sin((($0)*M_PI)/180.0)}
            case "cos": performOperation1 {cos((($0)*M_PI)/180.0)}
            default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation1(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    

    @IBOutlet weak var inputHistory: UILabel!
    
    @IBAction func Clear() {
        operandStack.removeAll()
        display.text = "0"
        inputHistory.text=""
        userIsTyping = false
    }
    
}




