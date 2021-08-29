//
//  DeleteCellView.swift
//  Devices
//
//  Created by iMac on 28.08.2021.
//

import UIKit

protocol DeleteCellViewDelegate: AnyObject {
    
    func didTapCancelButton()
    func didTapDeleteButton()
}


class DeleteCellView: UIView {
    
    //MARK: - Properties
    weak var delegate: DeleteCellViewDelegate?
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.098, green: 0.129, blue: 0.173, alpha: 1)
        label.font = UIFont(name: "Roboto-Regular", size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = .white
        button.layer.backgroundColor = UIColor(red: 0.749, green: 0.773, blue: 0.812, alpha: 1).cgColor
        button.layer.cornerRadius = 20
        button.setTitle("ОТМЕНА", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.backgroundColor = UIColor(red: 1, green: 0.413, blue: 0.413, alpha: 1).cgColor
        button.layer.cornerRadius = 20
        button.setTitle("УДАЛИТЬ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        return button
        
    }()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 24
        addSubview(questionLabel)
        addSubview(cancelButton)
        addSubview(deleteButton)
        
        cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private func's
    private func makeConstraints() {
        
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(18)
            make.width.equalTo(210)
            make.height.equalTo(60)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(25)
            make.leading.equalToSuperview().offset(18)
            make.width.equalTo(128)
            make.height.equalTo(40)
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(17)
            make.width.equalTo(127)
            make.height.equalTo(40)
        }
    }
    
    
    //MARK: - Actions
    @objc func didTapCancelButton() {
        delegate?.didTapCancelButton()
    }
    
    @objc func didTapDeleteButton() {
        delegate?.didTapDeleteButton()
    }
    
}
