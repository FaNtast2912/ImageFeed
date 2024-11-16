//
//  ViewController.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 30.08.2024.
//

import UIKit

final class ImagesListViewController: UIViewController, ImagesListCellDelegate, ImagesListViewControllerProtocol {
    // MARK: - Public Properties
    var presenter: ImagesListPresenterProtocol?
    // MARK: - Private Properties
    private var tableView: UITableView?
    private var imagesListServiceObserver: NSObjectProtocol?
    // MARK: - Overrides Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        presenter?.viewDidLoad()
        addImagesListServiceObserver()
    }
    
    // MARK: - Private Methods
    private func setTableView() {
        view.backgroundColor = .ypBlack
        let tableView = UITableView()
        tableView.register(ImagesListViewCell.self, forCellReuseIdentifier: ImagesListViewCell.reuseIdentifier)
        tableView.backgroundColor = .ypBlack
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        self.tableView = tableView
    }
    
    private func addImagesListServiceObserver() {
        imagesListServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ImagesListService.didChangeNotification,
                object: nil,
                queue: .main,
                using: { [weak self] _ in
                    guard let self = self else { return }
                    self.presenter?.didPhotoUpdate()
                }
            )
    }
    // MARK: - Public Methods
    func setupPresenter(_ presenter: ImagesListPresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    func updateTableViewAnimated(from oldCount: Int, to newCount: Int) {
        guard let tableView else {
            preconditionFailure("table view doesn't exist")
        }
        tableView.performBatchUpdates {
            let indexPaths = (oldCount..<newCount).map { i in
                IndexPath(row: i, section: 0)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        } completion: { _ in }
    }
    
    func imageListCellDidTapLike(for cell: ImagesListViewCell) {
        guard let tableView else { preconditionFailure("tableView doesn't exist") }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        UIBlockingProgressHUD.show()
        presenter?.updateLike(for: indexPath.row, cell: cell) { result in
            switch result {
            case .success(_):
                UIBlockingProgressHUD.dismiss()
            case .failure(let error):
                UIBlockingProgressHUD.dismiss()
                print("Cant refresh like condition \(error)")
            }
        }
    }
}

// MARK: - Extensions
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { preconditionFailure("presenter doesn't exist")}
        return presenter.returnPhotosCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListViewCell.reuseIdentifier, for: indexPath)
        
        guard let ImagesListViewCell = cell as? ImagesListViewCell else {
            return UITableViewCell()
        }
        ImagesListViewCell.delegate = self
        guard let presenter else { preconditionFailure("presenter doesn't exist") }
        
        let data = presenter.photosName
        
        configCell(for: ImagesListViewCell, with: indexPath, from: data)
        
        return ImagesListViewCell
    }
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter else { preconditionFailure("presenter doesn't exist") }
        let singleImageViewController = SingleImageViewController()
        let image = presenter.returnPhoto(by: indexPath.row)
        singleImageViewController.image = image
        singleImageViewController.modalPresentationStyle = .fullScreen
        present(singleImageViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let presenter else { preconditionFailure("presenter doesn't exist") }
        let image = presenter.returnPhoto(by: indexPath.row)
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width == 0 ? 1 : image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}

extension ImagesListViewController {
    func configCell(for cell: ImagesListViewCell, with indexPath: IndexPath, from data: [Photo]) {
        if cell.configCell(for: cell, with: indexPath, from: data) {
            guard let tableView else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ImagesListViewController {
    func tableView( _ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let presenter else { preconditionFailure("presenter doesn't exist") }
        presenter.loadNextPageIfNeeded(currentNumbers: indexPath.row)
    }
}
