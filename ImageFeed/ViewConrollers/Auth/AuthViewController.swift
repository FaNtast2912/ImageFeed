//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 19.09.2024.
//

import Foundation
import UIKit


class AuthViewController: UIViewController, WebViewViewControllerDelegate {
    
    // MARK: - IB Outlets

    // MARK: - Public Properties

    // MARK: - Private Properties
    private let segueIdentifier = "ShowWebView"
    private let oauth2Service = OAuth2Service.shared
    // MARK: - Initializers

    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
        
    }
    // MARK: - IB Actions
    let color: UIColor = .ypBlack
    // MARK: - Public Methods
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        //TODO: process code
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }

    // MARK: - Private Methods
    private func configureBackButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav_back_button")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor? = UIColor.ypBlack
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(segueIdentifier)") }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
}


