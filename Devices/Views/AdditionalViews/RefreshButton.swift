//
//  RefreshButton.swift
//  Devices
//
//  Created by iMac on 26.08.2021.
//

import UIKit

class RefreshButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 25
        
        backgroundColor = .white
        
        setTitleColor(.black, for: .normal)
        
        setTitle("ОБНОВИТЬ", for: .normal)
        
        titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
