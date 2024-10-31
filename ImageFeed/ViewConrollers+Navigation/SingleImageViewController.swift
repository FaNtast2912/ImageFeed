//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 03.09.2024.
//

import Foundation
import UIKit

final class SingleImageViewController: UIViewController {
    // MARK: - Public Properties
    var image: Photo? {
        didSet {
            guard isViewLoaded, let image else { return }
            imageView.kf.setImage(with: image.largeImageURL)
            imageView.frame.size = image.size
        }
    }
    // MARK: - Private Properties
    private var imageView = UIImageView()
    private var backButton: UIButton?
    private var scrollView = UIScrollView()
    private var likeButton: UIButton?
    private var shareButton: UIButton?
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setSingleImageScreen()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
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
        //TODO: like service
    }
    // MARK: - Private Methods
    private func setSingleImageScreen() {
        setImageView()
        setScrollView()
        setBackButton()
        setLikeButton()
        setShareButton()
    }
    
    private func setImageView() {
        guard let image else { return }
        let imageView = UIImageView()
        imageView.kf.setImage(with: image.largeImageURL)
        imageView.frame.size = image.size
        imageView.contentMode = .scaleAspectFit
        
        self.imageView = imageView
    }
    
    private func setScrollView() {
        let scrollView = UIScrollView()
        view.layoutIfNeeded()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        
        scrollView.layoutIfNeeded()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.scrollView = scrollView
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
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
        guard let image else {preconditionFailure("Image doesn't exist")}
        rescaleAndCenterImageInScrollView(image: image)
        
    }
    
    private func rescaleAndCenterImageInScrollView(image: Photo) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale =   visibleRectSize.width / imageSize.width
        let vScale =  visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.zoomScale = scale
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
}

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
