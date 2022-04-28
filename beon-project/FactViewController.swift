//
//  ViewController.swift
//  beon-project
//
//  Created by Fernando Marins on 28/04/22.
//

import UIKit

class FactViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var factLabel: UILabel!
    
    private var fact: Fact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @IBAction func getFactAction(_ sender: Any) {
        guard let text = inputTextField.text else { return }
        downloadFact(input: text)
    }
    
    private func downloadFact(input: String) {
        APIService.downloadFact(factNumber: input) { [weak self] result in
            switch result {
            case .success(let fact):
                self?.fact = fact
                DispatchQueue.main.async {
                    self?.factLabel.text = fact.text
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            downloadFact(input: text)
        }
    }
}

extension FactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            downloadFact(input: text)
        }
        textField.resignFirstResponder()
        return true
    }
    
}
