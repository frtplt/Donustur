//
//  PersonalInfoModel.swift
//  Donustur
//
//  Created by Firat on 19.02.2022.
//

import Foundation

struct PersonModel {
    let name: String
    let lastName: String
    let eMail: String
    let birtdayDate: String
    let phoneNumber: String
}

struct PersonModelMapInfo {
    let locationLatitude: Double
    let locationLongitude: Double
}

struct PersonTotalScore {
    let totalScore: Double
    let itemSender: String
}
