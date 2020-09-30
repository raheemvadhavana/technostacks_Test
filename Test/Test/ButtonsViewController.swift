//
//  ButtonsViewController.swift
//  Test
//
//  Created by Raheem vadhavana on 30/09/20.
//  Copyright © 2020 Raheem vadhavana. All rights reserved.
//

import UIKit

enum State{
    case white
    case blue
    case red
}

struct ColorButton {
    var id: Int
    var state: State
}

class ButtonsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var numberOfButtons: Int!
    
    var buttonArray: [ColorButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.genrateButtonArray()
        self.genrateRandomNumber()
    }
    
    func genrateButtonArray(){
        
        for i in 1...numberOfButtons{
            buttonArray.append(ColorButton(id: i, state: .white))
        }
    }
    
    func genrateRandomNumber(){
        
        var whiteButtons = self.buttonArray.filter{$0.state == .white}
        var whiteButtonMap = whiteButtons.map{$0.id}
        var randomGenrator = SystemRandomNumberGenerator()
        
        
        for _ in 1...3{

            guard let random = whiteButtonMap.randomElement(using: &randomGenrator) else{
                self.collectionView.reloadData()
                return
            }
            
            if let index = self.buttonArray.firstIndex(where: {$0.id == random}){
                self.buttonArray[index].state = .blue
            }
            
            if let index = whiteButtonMap.firstIndex(where: {$0 == random}){
                whiteButtonMap.remove(at: index)
            }
            
        }
        self.collectionView.reloadData()
    }
}

extension ButtonsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonArray.count
//        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ButtonCollectionCell

        if buttonArray[indexPath.row].state == .white{
            cell.buttonView.backgroundColor = .white
            cell.isUserInteractionEnabled = false
        }else if buttonArray[indexPath.row].state == .blue{
            cell.buttonView.backgroundColor = .blue
            cell.isUserInteractionEnabled = true
        }else{
            cell.buttonView.backgroundColor = .red
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.buttonArray[indexPath.row].state = .red
        self.genrateRandomNumber()
    }
    
    
}

class ButtonCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonView: UIView!
}
