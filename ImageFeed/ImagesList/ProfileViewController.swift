//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Maksim Zakharov on 01.09.2024.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var mainScreenButton: UIButton!
    @IBOutlet var profileScreenButton: UIButton!
    @IBOutlet var numbersOfFavoritesButton: UIButton!
    @IBOutlet var userPickImageView: UIImageView!
    @IBOutlet var profileExitButton: UIButton!
    @IBOutlet var nameSecondNameLabel: UILabel!
    @IBOutlet var profileStatusLabel: UILabel!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Public Properties

    // MARK: - Private Properties
    private var photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    // MARK: - Initializers

    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        profileExitButton.setTitle("", for: .normal)
        mainScreenButton.setTitle("", for: .normal)
        profileScreenButton.setTitle("", for: .normal)
    }
    // MARK: - IB Actions
    @IBAction func profileExitButton(_ sender: Any) {
        
    }
    
    @IBAction func mainScreenButton(_ sender: Any) {
        
    }
    
    @IBAction func profileScreenButton(_ sender: Any) {
        
    }
    // MARK: - Public Methods

    // MARK: - Private Methods
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        
        guard let imageListCell = cell as? ImagesListCell else {
            print("problemm here!")
            return UITableViewCell()
            
        }
        
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width == 0 ? 1 : image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}

extension ProfileViewController {
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        cell.configCell(for: cell, with: indexPath)
    }
}
