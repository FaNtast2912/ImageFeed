//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 12.10.2024.
//
import UIKit

class AlertPresenter: AlertPresenterProtocol {
    // MARK: - Initializers
    private init() { }
    // MARK: - Public Methods
    static func showAlert(model: AlertModel, vc: UIViewController) {
        let alertController = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        let alertFirstAction = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        alertController.addAction(alertFirstAction)
        
        if model.buttonText2 != nil {
            let alertSecondAction = UIAlertAction(title: model.buttonText2, style: .default) { _ in
                vc.dismiss(animated: true)
            }
            alertController.addAction(alertSecondAction)
        }
        
        vc.present(alertController, animated: true, completion: nil)
    }
}