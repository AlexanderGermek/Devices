//
//  DeviceCollectionViewCell.swift
//  Devices
//
//  Created by iMac on 26.08.2021.
//

import UIKit

class DeviceCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    //MARK: - Properties
    static let identifire = "DeviceCollectionViewCell"
    
    private let type: Int = 0
    
    private let indicatorStatusView: UIImageView = {
        let ballView = UIImageView()
        ballView.layer.cornerRadius = 12
        return ballView
    }()
    
    private let indicatorStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(white: 1, alpha: 1)
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        return label
    }()
    
    private let deviceLabel: VerticalTopAlignLabel = {
        let label = VerticalTopAlignLabel()
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0.098, green: 0.129, blue: 0.173, alpha: 1)
        label.font = UIFont(name: "Roboto-Regular", size: 24)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let iconImageView = SVGImageView()
    
    private let statusView = StatusView()
    
    private let clockImageView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        return label
    }()
    
    
    //MARK: - Init and lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupContentView()
        makeConstraints()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        indicatorStatusView.image = nil
        indicatorStatusLabel.text = nil
        deviceLabel.text          = nil
        iconImageView.load(urlString: "")
        statusView.frame          = .zero
        timeLabel.text            = nil
        clockImageView.image      = nil
    }
    
    
    //MARK: - Private func's
    private func setupView() {
        backgroundColor = nil
        layer.backgroundColor = UIColor(red: 0.938, green: 0.891, blue: 0.891, alpha: 1).cgColor
        layer.cornerRadius = 20
    }
    
    private func setupContentView() {
        
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.671, green: 0.413, blue: 1, alpha: 1).cgColor,
          UIColor(red: 0.286, green: 0.294, blue: 0.922, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer0.bounds = contentView.bounds.insetBy(dx: -0.5*contentView.bounds.size.width, dy: -0.5*contentView.bounds.size.height)
        layer0.position = contentView.center
        contentView.layer.addSublayer(layer0)

        contentView.layer.cornerRadius = 15
        
        contentView.addSubview(indicatorStatusView)
        contentView.addSubview(indicatorStatusLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(deviceLabel)
        contentView.addSubview(statusView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(clockImageView)
        
        contentView.layer.masksToBounds = true
    }
    
    private func makeConstraints() {
        
        let rightOffset = CGFloat(17)
        
        indicatorStatusView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(rightOffset)
            make.width.height.equalTo(12)
        }
        
        indicatorStatusLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(indicatorStatusView.snp.trailing).offset(5)
            make.height.equalTo(14)
            make.width.equalTo(100)
        }
        
        deviceLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(rightOffset)
            make.top.equalTo(indicatorStatusLabel.snp.bottom).offset(14)
            make.width.equalTo(130)
            make.height.equalTo(60)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(rightOffset)
            make.width.height.equalTo(98)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(rightOffset)
            make.bottom.equalToSuperview().inset(18)
            make.height.equalTo(14)
            make.width.equalTo(60)
        }
        
        clockImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(timeLabel.snp.leading).offset(-7)
            make.bottom.equalToSuperview().inset(16)
            make.width.height.equalTo(20)
        }
    }
    

    private func getStringDays(from date1: Date, to date2: Date = Date()) -> String {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: date1, to: date2)
        
        let days = components.day ?? 0
        let daysString = days < 10 ? "0\(days)" : "\(days)"
        
        let hours = components.hour ?? 0
        let hoursString = hours < 10 ? "0\(hours)" : "\(hours)"
        
        let minutes = components.minute ?? 0
        let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        
        return daysString + ":" + hoursString + ":" + minutesString
    }
    
    
    //MARK: - Public func's
    public func configure(with viewModel: DeviceViewModel) {
        
        indicatorStatusView.image = UIImage(named: viewModel.statusIconName)
        
        indicatorStatusLabel.text = viewModel.isOnline
        
       
        deviceLabel.text = viewModel.name.uppercased()
        deviceLabel.drawText(in: CGRect(x: 0, y: 0, width: 140, height: 56.5))

        iconImageView.load(urlString: viewModel.iconURLString)

        
        let statusViewModel = StatusViewViewModel(with: viewModel)
        statusView.configure(with: statusViewModel)
        
        if viewModel.type == 1 && viewModel.status == "ВЫКЛЮЧЕН" {
        
            timeLabel.text = getStringDays(from: viewModel.lastWorkTime)
            clockImageView.image = UIImage(named: "clock")
        }
    }
}
