//
//  ViewController.swift
//  UnderOver7
//
//  Created by Jordan on 2018-06-12.
//  Copyright © 2018 Jordan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let maximumBet : Double = 500
    var cash : Double = 100
    var stake : Double = 0
    var tdice = 0

    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var gainLoss: UILabel!
    @IBOutlet weak var dice1Image: UIImageView!
    @IBOutlet weak var dice2Image: UIImageView!
    @IBOutlet weak var uVal: UILabel!
    @IBOutlet weak var eVal: UILabel!
    @IBOutlet weak var oVal: UILabel!
    @IBOutlet weak var betUnder: CustomStepper!
    @IBOutlet weak var betEqual: CustomStepper!
    @IBOutlet weak var betOver: CustomStepper!
    @IBOutlet weak var betSelector: UISegmentedControl!
    
    @IBAction func betPressed(_ sender: AnyObject) {
        let d1 = Int(arc4random_uniform(6) + 1)
        let d2 = Int(arc4random_uniform(6) + 1)

        tdice = d1 + d2
        updateDiceImage(dice1: d1, dice2: d2)
        makePayout(result: tdice, under: betUnder.value, equal: betEqual.value, over: betOver.value)
    }
    
    @IBAction func betToUnderStepper(_ sender: AnyObject) {
        updateMaxBet()
        uVal.text = "$\(Int(betUnder.value))"
    }
    @IBAction func betToEqualStepper(_ sender: AnyObject) {
        updateMaxBet()
        eVal.text = "$\(Int(betEqual.value))"
    }
    @IBAction func betToOverStepper(_ sender: AnyObject) {
        updateMaxBet()
        oVal.text = "$\(Int(betOver.value))"
    }
    
    @IBAction func betSelectorPressed(_ sender: AnyObject) {
        updateMaxBet()
        switch betSelector.selectedSegmentIndex
        {
        case 0:
            betUnder.stepValue = 1
            betEqual.stepValue = 1
            betOver.stepValue = 1
            updateMaxBet()
        case 1:
            betUnder.stepValue = 5
            betEqual.stepValue = 5
            betOver.stepValue = 5
            updateMaxBet()
        case 2:
            betUnder.stepValue = 10
            betEqual.stepValue = 10
            betOver.stepValue = 10
            updateMaxBet()
        case 3:
            betUnder.stepValue = 25
            betEqual.stepValue = 25
            betOver.stepValue = 25
            updateMaxBet()
        case 4:
            betUnder.stepValue = 100
            betEqual.stepValue = 100
            betOver.stepValue = 100
            updateMaxBet()
        default:
            break
        }
    }
    
    func updateDiceImage(dice1: Int, dice2: Int) {
        dice1Image.image = UIImage(named: "\(String(dice1)).png")
        dice2Image.image = UIImage(named: "\(String(dice2)).png")
    }
    
    func updateMaxBet() {
        if (cash < maximumBet) {
            let calculatedValue = betUnder.value + betEqual.value + betOver.value
            betUnder.maximumValue = calculatedValue >= cash ? betUnder.value: cash
            betEqual.maximumValue = calculatedValue >= cash ? betEqual.value: cash
            betOver.maximumValue = calculatedValue >= cash ? betOver.value: cash
        }
    }
    
    func makePayout(result: Int, under: Double, equal: Double, over: Double) {
        var cashChange : Double
        if (result < 7) {
            cashChange = under - (equal + over)
        }
        else if (result > 7) {
            cashChange = over - (under + equal)
        }
        else {
            cashChange = equal*4 - (under + over)
        }
        cash += cashChange
        if (cashChange >= 0) {
            gainLoss.text = "+$\(Int(cashChange))"
            gainLoss.textColor = UIColor.green
        }
        else {
            gainLoss.text = "-$\(Int(abs(cashChange)))"
            gainLoss.textColor = UIColor.red
        }
        money.text = "$\(Int(cash))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        money.text = "$\(Int(cash))"
        gainLoss.text = ""
        uVal.text = "$\(Int(betUnder.value))"
        eVal.text = "$\(Int(betEqual.value))"
        oVal.text = "$\(Int(betOver.value))"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

