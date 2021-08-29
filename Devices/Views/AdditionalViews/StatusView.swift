//
//  StatusView.swift
//  Devices
//
//  Created by iMac on 26.08.2021.
//

import UIKit
import SnapKit
import SDWebImage

class StatusView: UIView {

    //MARK: - Properties
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        return label
    }()
        
    private let statusIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private var size = CGSize()
    
    //MARK: - Init and LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.masksToBounds = true
        layer.backgroundColor = UIColor(red: 0.138, green: 0.129, blue: 0.596, alpha: 1).cgColor
        layer.cornerRadius = 13.5
        
        addSubview(statusLabel)
        addSubview(statusIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    private func makeConstraints() {
        
        statusLabel.snp.remakeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(width - 49)
        }
        
        statusIcon.snp.remakeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(19)
            make.centerY.equalToSuperview()
        }
    }
    
    public func configure(with model: StatusViewViewModel) {
        
        statusLabel.text = model.statusText
        
        if model.statusText.hasPrefix("ГАЗ ОБНАРУЖЕН") {
            
            statusIcon.image = UIImage(systemName: "exclamationmark.circle")
            statusIcon.tintColor = .white
            
        } else {
            
            statusIcon.image = UIImage(named: model.iconName)
            
        }
        
        let widthForText = model.statusText.width(withConstrainedHeight: 27, font: statusLabel.font)
        
        frame = CGRect(origin: CGPoint(x: 15, y: 162), size: CGSize(width: widthForText + 49, height: 27) )
        
        makeConstraints()
    }
    
}
