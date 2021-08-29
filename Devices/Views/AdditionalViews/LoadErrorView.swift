//
//  LoadErrorView.swift
//  Devices
//
//  Created by iMac on 28.08.2021.
//

import UIKit

protocol LoadErrorViewDelegate: AnyObject {
    
    func didTapTryAgainButton()
}

class LoadErrorView: UIView {
    
    //MARK: - Properties
    weak var delegate: LoadErrorViewDelegate?

    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 24)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let tryAgainButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.backgroundColor = UIColor(red: 0.138, green: 0.129, blue: 0.596, alpha: 1).cgColor
        button.layer.cornerRadius = 20
        button.setTitle("ПОВТОРИТЬ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        return button
    }()

    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        
        addSubview(errorLabel)
        addSubview(tryAgainButton)
        
        tryAgainButton.addTarget(self,
                                 action: #selector(didTapTryAgainButton),
                                 for: .touchUpInside)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private func's
    private func makeConstraints() {
        
        errorLabel.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(80)
        }
        tryAgainButton.snp.makeConstraints { (make) in
            make.width.equalTo(127)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    
    //MARK: - Actions
    @objc private func didTapTryAgainButton() {
        
        delegate?.didTapTryAgainButton()
    }
}
