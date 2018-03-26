//
//  buttonCell.swift
//  test
//
//  Created by Suliac LE-GUILLOU on 3/26/18.
//  Copyright © 2018 Suliac LE-GUILLOU. All rights reserved.
//

import UIKit

final class ButtonCell: UICollectionViewCell {
    
    var item: String? {
        didSet {
            label.text = item
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
