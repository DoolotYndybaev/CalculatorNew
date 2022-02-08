//
//  ViewController.swift
//  Calculator
//
//  Created by Doolot on 6/2/22.
//

import UIKit

class MainController: UIViewController {
    
    private lazy var resultLabel = UIResultLabel()
    private lazy var buttonsLayout = UIButtonsLayoutView()
    private lazy var viewModel: MainViewModel = {
        return MainViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainWindow()
        setupViews()
    }
    
    private func setupMainWindow(){
        view.backgroundColor = .black
    }
    
    private func setupViews() {
        buttonsLayout.delegate = self
        
        view.addSubview(buttonsLayout)
        buttonsLayout.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeArea.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo((self.view.frame.width / 4.0) * 5)
        }
        buttonsLayout.createButtonLayouts(cornerRadius: ((self.view.frame.width / 4.0)))
        
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(buttonsLayout.snp.top).offset(-16)
        }
    }
}
extension MainController: UIButtonsLayoutDelegate {
    func onClickButton(title: String) {
        viewModel.clickButton(title)
    }
}
extension MainController: MainDelegate {
    func showMath(math: String) {
        resultLabel.setMath(math: math)
    }
    
    func showResult(result: String) {
        resultLabel.setResult(result: result)
    }
    
}
