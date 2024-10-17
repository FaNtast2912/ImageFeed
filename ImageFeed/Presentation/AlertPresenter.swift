//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 12.10.2024.
//
import UIKit

class AlertPresenter: AlertPresenterProtocol {
    // MARK: - Private Properties
    private weak var delegate: UIViewController?
    // MARK: - Initializers
    init(delegate: UIViewController?) {
        self.delegate = delegate
    }
    // MARK: - Public Methods
    func showAlert(model: AlertModel) {
        let alertController = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        alertController.addAction(alertAction)
        
        delegate?.present(alertController, animated: true, completion: nil)
    }
}
