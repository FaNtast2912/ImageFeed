//
//  ImagesListCellDelegate.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 04.11.2024.
//

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(for cell: ImagesListViewCell)
}
