//
//  OpacityView.swift
//  Devices
//
//  Created by iMac on 28.08.2021.
//

import UIKit

class OpacityView: UIView {
    
    //MARK: - Properties
    private let circleView: UIView = {
        let circle = UIView()
        circle.layer.cornerRadius = 25
        circle.backgroundColor = .white
        return circle
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loadIndicator")
        return imageView
    }()
    
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(white: 0, alpha: 0.6)

        imageView.rotate(duration: 0.6)
        circleView.addSubview(imageView)
        addSubview(circleView)
        
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Func's
    private func makeConstraints() {
        
        circleView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(26)
            make.width.height.equalTo(50)
        }
        
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(18.05)
            make.height.equalTo(19.95)
        }
    }
}


