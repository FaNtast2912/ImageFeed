//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 31.08.2024.
//

import Foundation
import UIKit


final class ImagesListCell: UITableViewCell {
    // MARK: - IB Outlets
    @IBOutlet private var imageCellView: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var gradientView: UIImageView!
    // MARK: - Public Properties
    static let reuseIdentifier = "ImagesListCell"
    // MARK: - Private Properties
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    // MARK: - Public Methods
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        
        guard let image = UIImage(named: "\(indexPath.row)") else { return }
        
        cell.imageCellView.image = image
        cell.dateLabel.text = dateFormatter.string(from: Date())
        let isLiked = indexPath.row % 2 == 0
        let likeImage = isLiked ? UIImage(named: "like_button_on") : UIImage(named: "like_button_off")
        cell.likeButton.setTitle("", for: .normal)
        cell.likeButton.setImage(likeImage, for: .normal)
        addGradient()
    }
    func addGradient() {
        gradientView.layer.masksToBounds = true
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        let gradientViewLayer = CAGradientLayer()
        gradientViewLayer.colors = [UIColor.ypBlack0.cgColor, UIColor.ypBlack20.cgColor]
        gradientViewLayer.frame = gradientView.bounds
        if self.gradientView.layer.sublayers?.count == nil  {
            gradientView.layer.addSublayer(gradientViewLayer)
        }
    }
    // MARK: - Private Methods
    
}
