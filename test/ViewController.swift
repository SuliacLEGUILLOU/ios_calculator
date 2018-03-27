//
//  ViewController.swift
//  test
//
//  Created by Suliac LE-GUILLOU on 3/26/18.
//  Copyright © 2018 Suliac LE-GUILLOU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    
    private let reuseid = "reussi"
    
    private var previous_entry = ""
    private var operation = ""
    
    private let button: [String] = ["AC", "+/-", "", "/", "7", "8", "9", "*", "4", "5", "6", "-", "1", "2", "3", "+", "0", "", "", "="]
    
    private let label:  UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout =  UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    private func setupConstraint() {
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(label)
        view.addSubview(collectionView)
        
        setupConstraint()
        
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: reuseid )
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return button.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cel = collectionView.dequeueReusableCell(withReuseIdentifier: reuseid, for: indexPath) as? ButtonCell else { return UICollectionViewCell() }
        
        cel.item = button[indexPath.item]
        
        if indexPath.item < 3 {
            cel.backgroundColor = .gray
        } else if indexPath.item % 4 == 3 {
            cel.backgroundColor = .orange
        }
        
        return cel
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width / 4, height: collectionView.frame.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("[DEBUG]", button[indexPath.item])
        
        if let number = Int(button[indexPath.item]){
            if label.text == "0" || label.text == "Err" {
                label.text = String(number)
            } else {
                label.text = label.text! + String(number)
            }
        } else if button[indexPath.item] == "AC" {
            label.text = "0"
        } else if button[indexPath.item] == "+/-" && label.text != "0" && label.text != "Err" {
            if label.text!.hasPrefix("-") {
                label.text!.remove(at: label.text!.startIndex)
            } else {
                label.text = "-" + label.text!
            }
        } else if button[indexPath.item] == "=" && previous_entry != "" {
            var result: (partialValue: Int, overflow: Bool)?
            
            print("operating \(previous_entry) \(operation) \(label.text!)")
            switch (operation) {
            case "+":
                result = Int(previous_entry)?.addingReportingOverflow(Int(label.text!)!)
                break
            case "-":
                result = Int(previous_entry)?.subtractingReportingOverflow(Int(label.text!)!)
                break
            case "*":
                result = Int(previous_entry)?.multipliedReportingOverflow(by: Int(label.text!)!)
                break
            case "/":
                result = Int(previous_entry)?.dividedReportingOverflow(by: Int(label.text!)!)
                break
            default:
                break
            }
            if result == nil || result!.overflow {
                label.text = "Err"
            } else {
                label.text = String(result!.partialValue)
            }
        } else {
            previous_entry = label.text!
            operation = button[indexPath.item]
            label.text = "0"
        }
    }
}

