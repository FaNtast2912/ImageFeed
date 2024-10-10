//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 19.09.2024.
//

import Foundation
import UIKit
import ProgressHUD

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController, WebViewViewControllerDelegate {
    // MARK: - IB Outlets

    // MARK: - Public Properties
    weak var delegate: AuthViewControllerDelegate?
    // MARK: - Private Properties
    private let segueIdentifier = "ShowWebView"
    private let oauth2Service = OAuth2Service.shared
    private let storage = OAuth2TokenStorage()
    // MARK: - Initializers

    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
        
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
    // MARK: - IB Actions
    
    // MARK: - Public Methods
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
        ProgressHUD.animationType = .ballVerticalBounce
        ProgressHUD.colorBackground = .ypBlack
        UIBlockingProgressHUD.show()
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
}


