//
//  ImagesListViewControllerProtocol;.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 16.11.2024.
//

public protocol ImagesListViewControllerProtocol: AnyObject {
    var presenter: ImagesListPresenterProtocol? { get set }
    func updateTableViewAnimated(from oldCount: Int, to newCount: Int)
    func setupPresenter(_ presenter: ImagesListPresenterProtocol)
    func addImagesListServiceObserver()
}
