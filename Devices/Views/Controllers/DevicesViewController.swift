//
//  ViewController.swift
//  Devices
//
//  Created by iMac on 26.08.2021.
//

import UIKit
import SnapKit

class DevicesViewController: UIViewController {
    
    //MARK: - Properties
    enum HiddenCases {
        case success
        case loading
        case error
    }
    
    private let mainLabel: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Умные вещи")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let refreshButton = RefreshButton()
    
    private var collectionView: UICollectionView!
    
    private var devices = [Device]()
    
    private var deleteView: DeleteCellView?
    
    private var errorView = LoadErrorView()
    
    private let opacityView = OpacityView()
    
    
    //MARK: - Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor(red: 0.098, green: 0.129, blue: 0.173, alpha: 1).cgColor
        
        view.addSubview(mainLabel)
        view.addSubview(opacityView)
        
        opacityView.layer.zPosition = 1
        
        configureErrorLabel()
        
        configureCollectionView()
        
        configureRefreshButton()
        
        makeConstraints()
        
        fetchDevices()
    }
    
    
    private func configureErrorLabel() {

        errorView.delegate        = self
        errorView.layer.zPosition = -2
        errorView.isHidden        = true
        
        view.addSubview(errorView)
    }
    
    
    private func configureCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 40
        let size = view.frame.width - 60
        layout.itemSize = CGSize(width: size, height: 200)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate   = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .white
        collectionView.layer.backgroundColor = UIColor(red: 0.098, green: 0.129, blue: 0.173, alpha: 1).cgColor
        collectionView.layer.zPosition = -1
        
        collectionView.register(DeviceCollectionViewCell.self,
                                forCellWithReuseIdentifier: DeviceCollectionViewCell.identifire)
        
        
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
    }
    
    
    private func configureRefreshButton() {
        
        view.addSubview(refreshButton)
        
        refreshButton.layer.zPosition = 0
        
        refreshButton.addTarget(self, action: #selector(didTapRefreshButton), for: .touchUpInside)
    }
    
    
    private func makeConstraints() {
        
        opacityView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        mainLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(77)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            make.leading.bottom.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        
        refreshButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(26)
            make.width.equalTo(143)
            make.height.equalTo(51)
        }
        
        errorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(200)
        }
    }
    
    
    private func fetchDevices() {
        
        makeHidden(hiddenCases: .loading)
        
        APICaller.shared.getDevices { [weak self] result in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                switch result {
                
                case .success(let devices):
                    
                    self?.devices = devices.sorted{ $1.id < $0.id}
                    self?.collectionView.reloadData()
                    self?.makeHidden(hiddenCases: .success)
                    
                case .failure(let error):
                    
                    self?.errorView.errorLabel.text = "Что то пошло не так, ошибка\n" + error.localizedDescription
                    self?.makeHidden(hiddenCases: .error)
                    
                }
            }
        }
    }
    
    
    private func makeHidden(hiddenCases: HiddenCases) {
        
        switch hiddenCases {
        
        case .loading:
            opacityView.isHidden    = false
            collectionView.isHidden = true
            refreshButton.isHidden  = true
            errorView.isHidden      = true
            
        case .success:
            opacityView.isHidden    = true
            collectionView.isHidden = false
            refreshButton.isHidden  = false
            errorView.isHidden      = true

        case .error:
            opacityView.isHidden    = true
            collectionView.isHidden = true
            refreshButton.isHidden  = true
            errorView.isHidden      = false
        }
        
        if opacityView.isHidden {
            opacityView.imageView.stopAnimating()
        }
    }
    
    
    //MARK: - Actions
    @objc private func didTapRefreshButton() {
        
        fetchDevices()
    }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension DevicesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeviceCollectionViewCell.identifire, for: indexPath) as? DeviceCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let device = devices[indexPath.row]
        let viewModel = DeviceViewModel(with: device)
        cell.configure(with: viewModel)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        deleteView = DeleteCellView(frame:
                                        CGRect(origin: view.bounds.origin,
                                               size: CGSize(width: 300, height: 200)))
        deleteView?.delegate = self
        
        let deviceNameQuestion = devices[indexPath.row].name.lowercased() + "?"
        deleteView?.questionLabel.text = "Вы хотите удалить \(deviceNameQuestion)"
        
        self.view.addSubview(self.deleteView!)
        
        collectionView.isUserInteractionEnabled = false
        refreshButton.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.2) {
            
            self.deleteView?.center = self.view.center
        }
    }
}

//MARK: - LoadErrorViewDelegate
extension DevicesViewController: LoadErrorViewDelegate {
    
    func didTapTryAgainButton() {
        opacityView.imageView.rotate(duration: 0.6)
        fetchDevices()
    }
}

//MARK: - DeleteCellViewDelegate
extension DevicesViewController: DeleteCellViewDelegate {
    
    func didTapCancelButton() {
        
        UIView.animate(withDuration: 0.3) {
            
            self.deleteView?.removeFromSuperview()
        }
        
        collectionView.isUserInteractionEnabled = true
        refreshButton.isUserInteractionEnabled = true
    }
    
    
    func didTapDeleteButton() {
        
        guard let selectedCells = collectionView.indexPathsForSelectedItems,
              let item = selectedCells.map({ $0.item }).first else { return }
        
        devices.remove(at: item)
        
        UIView.animate(withDuration: 0) {
            self.deleteView?.removeFromSuperview()
        }
        
        collectionView.deleteItems(at: selectedCells)
        
        collectionView.isUserInteractionEnabled = true
        refreshButton.isUserInteractionEnabled = true
    }
}

