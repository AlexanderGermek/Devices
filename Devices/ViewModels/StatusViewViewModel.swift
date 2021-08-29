//
//  StatusViewViewModel.swift
//  Devices
//
//  Created by iMac on 28.08.2021.
//

import Foundation


struct StatusViewViewModel {
    
    let iconName: String
    let statusText: String
    
    init(with model: DeviceViewModel) {
        
        iconName = model.type == 1 ? "rocket" : (model.status == "ГАЗ ОБНАРУЖЕН" ? "drop.triangle" : "noGas")
        
        statusText = model.status
    }
}
