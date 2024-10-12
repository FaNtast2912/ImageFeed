//
//  AlertModel.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 12.10.2024.
//

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)
}
