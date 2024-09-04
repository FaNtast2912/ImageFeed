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
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Public Properties
    var image: UIImage?
    // MARK: - Private Properties
    
    // MARK: - Initializers
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    // MARK: - IB Actions
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
}
