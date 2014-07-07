//
//  ViewController.swift
//  CalculatorSwift
//
//  Created by Admin on 07.07.14.
//  Copyright (c) 2014 Konstantin Kokorin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var leftOperand: Float? = nil
    var rightOperand: Float? = nil
    var operator: Character? = nil
    var memory: Float? = nil
    var resetNumberLabelOnNextAppending: Bool = false
    
    @IBOutlet var numberLabel: UILabel
    @IBOutlet var operationLabel: UILabel
    
    
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clear(nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clear(sender: UIButton?) {
        
        self.leftOperand = nil
        self.rightOperand = nil
        self.numberLabel.text = ""
        self.operationLabel.text = ""

    }
    
    @IBAction func numberAndDotAsText(sender: UIButton) {
        
        var button: UIButton = sender as UIButton
        var titleButtonStr: String = button.titleLabel.text
        
        if resetNumberLabelOnNextAppending == true {
            
            self.numberLabel.text = ""
            resetNumberLabelOnNextAppending = false
        }
        
        if titleButtonStr == "." {
            
            if !contains(self.numberLabel.text as String, ".") {
                
                self.numberLabel.text = self.numberLabel.text + "."
            }
            return
        }
        
        if self.numberLabel.text == "0" {
            
            if titleButtonStr == "." {
                
                return
            }
            
            self.numberLabel.text = titleButtonStr
            
        } else {
            
            self.numberLabel.text = self.numberLabel.text + titleButtonStr
        }
        
    }
    
    func calculate() {
        
        if !self.operator || !self.rightOperand {
            return
        }
        
        if self.operator == "/" && (self.rightOperand == 0.0 || self.rightOperand == nil) {
            
            var alert: UIAlertView! = UIAlertView(title: "Unable to divide 0!", message: "", delegate: nil, cancelButtonTitle: "OK")
            
            alert.show()
            return
        }
        
        var result: Float = 0
        
        switch self.operator! {
            
        case "+":
            result = self.leftOperand! + self.rightOperand!
            
        case "-":
            result = self.leftOperand! - self.rightOperand!
            
        case "*":
            result = self.leftOperand! * self.rightOperand!
            
        case "/":
            result = self.leftOperand! / self.rightOperand!
            
        default:
            result = 0
        }
        
        self.leftOperand = result
        self.numberLabel.text = "\(result)"
        self.rightOperand = nil
        self.resetNumberLabelOnNextAppending = false
    }
    
    @IBAction func operation(sender: UIButton) {
        
        if self.leftOperand == nil {
            
            var text: NSString = self.numberLabel.text
            self.leftOperand = Float(text.doubleValue)
            self.rightOperand = nil
        } else if !resetNumberLabelOnNextAppending {
            
            var text: NSString = self.numberLabel.text
            self.rightOperand = Float(text.doubleValue)
            self.calculate()
        }
        
        var button = sender as UIButton
        var titleButtonStr: NSString = button.titleLabel.text
        
        titleButtonStr = titleButtonStr.substringWithRange(NSMakeRange(0, 1))
        
        var char: Character = Character(titleButtonStr)
        
        self.operator = char
        self.operationLabel.text = titleButtonStr
        self.resetNumberLabelOnNextAppending = true
    }
    
    @IBAction func equal(sender: UIButton) {
        
        if self.operator == nil || self.leftOperand == nil {
            return
        }
        
        var numaberLabelToText: NSString = self.numberLabel.text
        
        self.rightOperand = Float(numaberLabelToText.doubleValue)
        self.calculate()
        self.operationLabel.text = ""
        self.operator = nil
    }
    
    @IBAction func nagative(sender: UIButton) {
        
        if resetNumberLabelOnNextAppending {
            
            self.leftOperand = nil
            self.resetNumberLabelOnNextAppending = false
        }
        
        self.operator = nil
        self.operationLabel.text = ""
        
        var numberLabelToText: String = self.numberLabel.text
        
        if numberLabelToText.hasPrefix("-") {
            
            self.numberLabel.text = numberLabelToText.substringFromIndex(1)
        } else {
            
            self.numberLabel.text = "-" + numberLabelToText
        }
    }
    
    @IBAction func memoryClear(sender: UIButton) {
        self.memory = 0
    }
    
    @IBAction func memoryPlus(sender: UIButton) {
        
        if !self.memory {
            
            self.memory = 0
        }
        
        var numberLabelToText: NSString = self.numberLabel.text
        var num: Float = Float(numberLabelToText.doubleValue)
        
        self.memory = self.memory! + num
        self.resetNumberLabelOnNextAppending = true
    }
    
    @IBAction func memoryMinus(sender: UIButton) {
        
        if !self.memory {
            
            self.memory = 0
        }
        
        var numberLabelToText: NSString = self.numberLabel.text
        var num: Float = Float(numberLabelToText.doubleValue)
        
        self.memory = self.memory! - num
        self.resetNumberLabelOnNextAppending = true
    }
    
    @IBAction func memoryRecall(sender: UIButton) {
        
        if !self.memory {
            
            self.memory = 0
        }

        self.numberLabel.text = "\(self.memory)"
        
        if !self.operator {
            
            self.leftOperand = self.memory
        }
        
        self.resetNumberLabelOnNextAppending = true
    }
}

