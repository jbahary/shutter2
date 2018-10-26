//
//  Shutter2ViewController.swift
//  Shutter2
//
//  Created by Jon Bahary on 10/26/18.
//  Copyright © 2018 Jon Bahary. All rights reserved.
//

import UIKit

class Shutter2ViewController: UIViewController {
    @IBOutlet weak var mainStackView: UIStackView!
    override func viewDidLoad(){
        super.viewDidLoad()
        loadStackItems()
    }
    
    func loadStackItems() {
        
        
        
        let screenWidth  = mainStackView.frame.size.width
        var screenHeight = mainStackView.frame.size.height
        
        screenHeight -= 100   // make room for 2 labels
        let lightBlue = UIColor(red: 165/255, green: 165/255, blue: 1.0, alpha: 1)
        let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
       
        label1.textAlignment = .left
        label1.text = ""
        label1.textColor = lightBlue
        mainStackView.addArrangedSubview(label1)
        
        let ht = screenHeight/5;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller1 = storyboard.instantiateViewController(withIdentifier: "ReusableCollectionViewController") as! ReusableCollectionViewController
       controller1.cellHeight = Int(ht * 2.0)
        controller1.cellWidth = Int(screenWidth - 30.0)
        
        controller1.view.heightAnchor.constraint(equalToConstant: ht*2.0).isActive = true
        controller1.filmType = .exclusive
        mainStackView.addArrangedSubview(controller1.view)
        addChild(controller1);
        controller1.heightContraint.constant = ht*2.0
      
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
      //  label2.center = CGPoint(x: 160, y: 285)
        label2.textAlignment = .left
        label2.text = "     Newly Added"
        label2.textColor = lightBlue
        label2.font = UIFont.boldSystemFont(ofSize: 16.0)
        mainStackView.addArrangedSubview(label2)
        
        let controller2 = storyboard.instantiateViewController(withIdentifier: "ReusableCollectionViewController") as! ReusableCollectionViewController
        controller2.filmType = .newlyAdded
        controller2.cellHeight = Int(ht)
        controller2.cellWidth = Int(0.75 * ht)
       
        controller2.view.heightAnchor.constraint(equalToConstant: ht ).isActive = true
        
        mainStackView.addArrangedSubview(controller2.view)
        addChild(controller2);
         controller2.heightContraint.constant = ht
        
        let label3 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
     //   label3.center = CGPoint(x: 160, y: 285)
        label3.textAlignment = .left
        label3.text = "     Curator's Choice"
        label3.textColor = lightBlue
         label3.font = UIFont.boldSystemFont(ofSize: 16.0)
        mainStackView.addArrangedSubview(label3)
        
        let controller3 = storyboard.instantiateViewController(withIdentifier: "ReusableCollectionViewController") as! ReusableCollectionViewController
        controller3.filmType = .curatorsChoice
        controller3.cellHeight = Int(ht)
        controller3.cellWidth = Int(0.75 * ht)
        
        controller3.view.heightAnchor.constraint(equalToConstant: ht ).isActive = true
        
        mainStackView.addArrangedSubview(controller3.view)
        addChild(controller3);
        controller3.heightContraint.constant = ht
        
        
        let label4 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label4.center = CGPoint(x: 160, y: 285)
        label4.textAlignment = .center
       
         mainStackView.addArrangedSubview(label4)
    
    }
}
