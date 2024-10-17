//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 31.08.2024.
//

import Foundation
import UIKit


final class ImagesListViewCell: UITableViewCell {
    // MARK: - Public Properties
    static let reuseIdentifier = "ImagesListCell"
    // MARK: - Private Properties
    private var imageCellView = UIImageView()
    private var likeButton = UIButton()
    private var dateLabel = UILabel()
    private var gradientView = UIView()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    // MARK: - IB Actions
    @objc
    private func didTapLikeButton(_ sender: Any) {
        //TODO: like service
    }
    // MARK: - Public Methods
    func configCell(for cell: ImagesListViewCell, with indexPath: IndexPath) {
        setImageCellView(for: cell, with: indexPath)
        setGradient(for: cell)
        setLikeButton(for: cell, with: indexPath)
        setDateLabel(for: cell)
    }
    
    // MARK: - Private Methods
    private func setImageCellView(for cell: ImagesListViewCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: "\(indexPath.row)") else { return }
        contentView.addSubview(cell.imageCellView)
        cell.imageCellView.image = image
        cell.imageCellView.contentMode = .scaleAspectFill
        cell.imageCellView.layer.cornerRadius = 16
        cell.imageCellView.layer.masksToBounds = true
        cell.contentView.backgroundColor = .ypBlack
        cell.backgroundColor = .ypBlack
        cell.selectionStyle = .none
        cell.imageCellView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.imageCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        cell.imageCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        cell.imageCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        cell.imageCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
    }
    
    private func setLikeButton(for cell: ImagesListViewCell, with indexPath: IndexPath) {
        cell.contentView.addSubview(cell.likeButton)
        cell.likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        cell.likeButton.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 4).isActive = true
        cell.likeButton.trailingAnchor.constraint(equalTo:  cell.contentView.trailingAnchor, constant: -16).isActive = true
        cell.likeButton.widthAnchor.constraint(equalToConstant: 42).isActive = true
        cell.likeButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        cell.likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        let isLiked = indexPath.row % 2 == 0
        let likeImage = isLiked ? UIImage(named: "like_button_on") : UIImage(named: "like_button_off")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
    
    private func setDateLabel(for cell: ImagesListViewCell) {
        
        cell.contentView.addSubview(cell.dateLabel)
        cell.dateLabel.text = dateFormatter.string(from: Date())
        cell.dateLabel.textColor = .white
        cell.dateLabel.font = .systemFont(ofSize: 13)
        cell.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cell.dateLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 24).isActive = true
        cell.dateLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -12).isActive = true
    }
    
    private func setGradient(for cell: ImagesListViewCell) {
        
        cell.contentView.addSubview(cell.gradientView)
        cell.gradientView.layer.masksToBounds = true
        cell.gradientView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        cell.gradientView.layer.cornerRadius = 16
        cell.gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.gradientView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16).isActive = true
        cell.gradientView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16).isActive = true
        cell.gradientView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -4).isActive = true
        cell.gradientView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        cell.gradientView.layoutIfNeeded()
        let gradientViewLayer = CAGradientLayer()
        gradientViewLayer.colors = [UIColor.ypBlack0.cgColor, UIColor.ypBlack20.cgColor]
        gradientViewLayer.frame = cell.gradientView.bounds
        if cell.gradientView.layer.sublayers?.count == nil  {
            cell.gradientView.layer.addSublayer(gradientViewLayer)
        }
    }
}



