//
//  MainViewmodel.swift
//  Calculator
//
//  Created by Doolot on 6/2/22.
//

import Foundation
protocol MainDelegate: AnyObject {
    func showMath(math: String)
    func showResult(result: String)
}

class MainViewModel {
    
    private weak var delegate: MainDelegate? = nil
    
    init (delegate: MainDelegate) {
        self.delegate = delegate
    }
    
    private var math = "0"
    private var operators = ["+","-","*","/","."]
    
    func clickButton(_ title: String) {
        if title == "=" {
            return
        }
        
        if title == "AC" {
            clearLast()
        }else if !(operators.contains(String(math.last ?? Character(""))) && operators.contains(title)){
           calculateMathResult(title )
        }
        
    }
    private func clearLast(){
        math = String(math.dropLast())
        
        if math.count == 1 {
            math = "0"
        }
        
        calculatorMath(math)
    }
    private func calculateMathResult(_ title: String){
        if (String(math.first ?? Character("")))  == "0"{
            math = String(math.dropFirst())
        }
        math = math + title
        
        calculatorMath(math)
        
    }
    
    private func calculatorMath(_ math: String) {
        if !operators.contains(String(math.last ?? Character(""))) {
            let expr = NSExpression(format: math)
            if let result = expr.expressionValue(with: nil, context: nil) as? NSNumber {
                delegate?.showResult(result: String(result.doubleValue))
            } else {
                delegate?.showResult(result: "0")
            }
        } else {
            delegate?.showResult(result: "0")
        }
        
        delegate?.showMath(math: math)
    }
}
