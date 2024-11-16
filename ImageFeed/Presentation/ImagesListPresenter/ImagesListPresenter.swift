//
//  ImagesListPresenter.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 16.11.2024.
//

final class ImagesListPresenter: ImagesListPresenterProtocol {
    // MARK: - IB Outlets

    // MARK: - Public Properties
    var photosName: [Photo] = []
    weak var view: ImagesListViewControllerProtocol?
    // MARK: - Private Properties
    private let imagesListService = ImagesListService.shared
    // MARK: - Initializers

    // MARK: - Overrides Methods

    // MARK: - IB Actions

    // MARK: - Public Methods
    func viewDidLoad() {
        imagesListService.fetchPhotosNextPage()
    }
    
    func didPhotoUpdate() {
        let oldCount = photosName.count
        let newCount = imagesListService.photos.count
        photosName = imagesListService.photos
        if oldCount != newCount {
            view?.updateTableViewAnimated(from: oldCount, to: newCount)
        }
    }
    
    func updateLike(for photoNumber: Int, cell: ImagesListViewCell, _ completion: @escaping (Result<Bool , Error>) -> Void) {
        let photo = photosName[photoNumber]
        imagesListService.changeLike(photoId: photo.id, isLike: !photo.isLiked) { [weak self] response in
            guard let self else { preconditionFailure("self doesn't exist")}
            switch response {
            case.success(let currentLike):
                self.photosName[photoNumber].isLiked = currentLike
                cell.refreshLikeImage(to: currentLike)
                completion(.success(true))
            case.failure(let error):
                print("error - \(error)")
                completion(.failure(error))
            }
        }
    }
    func returnPhotosCount() -> Int {
        photosName.count
    }
    func returnPhotoData() -> [Photo] {
        photosName
    }
    func returnPhoto(by number: Int) -> Photo {
        photosName[number]
    }
    func loadNextPageIfNeeded(currentNumbers: Int) {
        guard currentNumbers == photosName.count - 1 else {return}
        imagesListService.fetchPhotosNextPage()
    }
    // MARK: - Private Methods
}
