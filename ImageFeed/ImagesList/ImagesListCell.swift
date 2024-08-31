//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 31.08.2024.
//

import Foundation
import UIKit


final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var imageCellView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
}
