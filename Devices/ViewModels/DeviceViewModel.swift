//
//  DeviceViewModel.swift
//  Devices
//
//  Created by iMac on 27.08.2021.
//

import Foundation


struct DeviceViewModel {
    
    let id: Int
    let name: String
    let iconURLString: String
    let isOnline: String
    let statusIconName: String
    let type: Int
    var status: String
    let lastWorkTime: Date
    
    init(with model: Device) {
        
        id             = model.id
        
        //Заменяем Робот - пылесос и Датчик газа на Робот пылесос и Датчик газа
        name           = model.name
            .replacingOccurrences(of: "-", with: "")
            .split(separator: " ").joined(separator: " ")
        
        iconURLString  = APICaller.Constants.basicURL + model.icon
        
        isOnline       = model.isOnline ? "ON LINE" : "OFF LINE"
        
        statusIconName = model.isOnline ? "statusOnline" : "statusOffline"
        
        type           = model.type
        
        status = ""
        
        if model.type == 1 {

            status = model.status.uppercased()

        } else if model.type == 2 {

            if model.status == "1" {

                status = "ГАЗ ОБНАРУЖЕН"

            } else if model.status == "2" {

                status = "ГАЗ НЕ ОБНАРУЖЕН"
            }
        }

        lastWorkTime = Date(timeIntervalSince1970: TimeInterval(model.lastWorkTime))
    }
    
}
