//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 03.09.2024.
//

import Foundation
import UIKit

final class SingleImageViewController: UIViewController {
    
    // MARK: - IB Outlets
    private var imageView: UIImageView?
    private var backButton: UIButton?
    private var scrollView: UIScrollView?
    private var likeButton: UIButton?
    private var shareButton: UIButton?
    
    // MARK: - Public Properties
    var image: UIImage? {
        didSet {
            guard isViewLoaded, let image, let imageView else { return }
            imageView.image = image
            imageView.frame.size = image.size
            rescaleAndCenterImageInScrollView(image: image)
        }
    }
    // MARK: - Private Properties
    
    // MARK: - Initializers
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setSingleImageScreen()
    }
    // MARK: - IB Actions
    @objc
    private func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func didTapShareButton(_ sender: Any) {
        guard let image else { return }
        let share = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        present(share, animated: true, completion: nil)
    }
    
    @objc
    private func didTapLikeButton(_ sender: Any) {
        
    }
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        guard let scrollView else { return }
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = imageSize.width /  visibleRectSize.width
        let vScale = imageSize.height / visibleRectSize.height
        let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    private func setSingleImageScreen() {
        guard let image else { return }
        setImageView()
        setScrollView()
        setBackButton()
        setLikeButton()
        setShareButton()
        rescaleAndCenterImageInScrollView(image: image)
    }
    
    private func setImageView() {
        guard let image else { return }
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame.size = image.size
        imageView.contentMode = .scaleAspectFit
        self.imageView = imageView
    }
    
    private func setBackButton() {
        guard let buttonImage = UIImage(named: "chevronBackward") else { preconditionFailure("backButton button image doesn't exist") }
        let backButton = UIButton.systemButton(
            with: buttonImage,
            target: self,
            action: #selector(didTapBackButton)
        )
        backButton.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        backButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        
        self.backButton = backButton
    }
    
    private func setScrollView() {
        guard let imageView else { return }
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.scrollView = scrollView
    }
    
    private func setLikeButton() {
        guard let buttonImage = UIImage(named: "likeButton") else { preconditionFailure("likeButton image doesn't exist") }
        let likeButton = UIButton(type: .custom)
        likeButton.setImage(buttonImage, for: .normal)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(likeButton)
        
        likeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69).isActive = true
        likeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 711).isActive = true
        
        self.likeButton = likeButton
    }
    
    private func setShareButton() {
        guard let buttonImage = UIImage(named: "shareButton") else { preconditionFailure("shareButton image doesn't exist") }
        let shareButton = UIButton(type: .custom)
        shareButton.setImage(buttonImage, for: .normal)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shareButton)
        
        shareButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -69).isActive = true
        shareButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 711).isActive = true
        
        self.shareButton = shareButton
    }
}



extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
