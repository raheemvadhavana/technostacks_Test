//
//  ViewController.swift
//  Test
//
//  Created by Raheem vadhavana on 30/09/20.
//  Copyright © 2020 Raheem vadhavana. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.textField.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let intNumber = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return intNumber.isSuperset(of: characterSet)
    }
    @IBAction func goButtonClicked( sender: UIButton){
        
        let controller = self.storyboard?.instantiateViewController(identifier: "ButtonsViewController") as! ButtonsViewController
        controller.numberOfButtons = Int(self.textField.text!)
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

