//
//  UIButtonsLayoutView.swift
//  Calculator
//
//  Created by Doolot on 8/2/22.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

protocol UIButtonsLayoutDelegate: AnyObject {
    func onClickButton(title: String)
}

class UIButtonsLayoutView: UIView {
    
    private lazy var horizontalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    
    public weak var delegate: UIButtonsLayoutDelegate? = nil
    
    //ButtonModel(title:  , titleColor: <#T##UIColor#>, color: <#T##UIColor#>)
    private let buttons = [
        [ButtonModel("AC", .black, .gray),ButtonModel("+/-", .black, .gray),ButtonModel("%", .black, .gray),ButtonModel("/", .black, .orange)],
        [ButtonModel("7", .white, .darkGray),ButtonModel("8", .white, .darkGray),ButtonModel("9", .white, .darkGray),ButtonModel("*", .white, .orange)],
        [ButtonModel("4", .white, .darkGray),ButtonModel("5", .white, .darkGray),ButtonModel("6", .white, .darkGray),ButtonModel("+", .white, .orange)],
        [ButtonModel("1", .white, .darkGray),ButtonModel("2", .white, .darkGray),ButtonModel("3", .white, .darkGray),ButtonModel("-", .white, .orange)],
        [ButtonModel("0", .white, .darkGray),ButtonModel("0", .white, .darkGray),ButtonModel(".", .white, .darkGray),ButtonModel("=", .white, .orange)]
        
    ]
    
    private func secondStart(_ cornerRadius: Double){
        buttons.forEach {buttonsItem in
            let stack = createStack()
            
            buttonsItem.forEach { item in
                stack.addArrangedSubview(createButton(model: item, cornerRadius))
            }
            self.horizontalStack.addArrangedSubview(stack)
        }
        let left = createStack()
        let right = createStack()
        
        let sumStack = createStack()
        
        left.addArrangedSubview(createButton(model: ButtonModel("0", .white, .darkGray), cornerRadius))
        
        sumStack.addArrangedSubview(left)
        
        
        right.addArrangedSubview(createButton(model: ButtonModel(".", .white, .darkGray), cornerRadius))
        right.addArrangedSubview(createButton(model: ButtonModel("=", .white, .orange), cornerRadius))
        
        sumStack.addArrangedSubview(right)
        
        horizontalStack.addArrangedSubview(sumStack)
        
    }
    
    func createButtonLayouts(cornerRadius: Double) {
        addSubview(horizontalStack)
        horizontalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        secondStart(cornerRadius)
    }
    
    private func createButton(model: ButtonModel,_ cornerRadius: Double) -> UIButton{
        let view = UIButton()
        view.addTarget(self, action: #selector(clickButtons(view:)), for: .touchUpInside)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.setTitle(model.title, for: .normal)
        view.layer.cornerRadius = (cornerRadius / 2.0) - 8
        view.backgroundColor = model.color
        view.setTitleColor(model.titleColor, for: .normal)
        return view
    }
    private func createStack() -> UIStackView{
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }
    
    @objc func clickButtons(view: UIButton) {
        delegate?.onClickButton(title: view.titleLabel?.text ?? String())
    }
}
