//
//  ImageFeedTests.swift
//  ImageFeedTests
//
//  Created by Maksim Zakharov on 30.08.2024.
//

import XCTest
import ImageFeed
import Foundation
@testable import ImageFeed

final class WebViewTests: XCTestCase {
    
    func testViewControllerCallsViewDidLoad() {
        //given
        let viewController = WebViewViewController()
        let presenter = WebViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        //when
        _ = viewController.view
        //then
        XCTAssert(presenter.viewDidLoadCalled) // behavior verification
    }
    
    func testPresenterCallsLoadRequest() {
        // given
        let viewController = WebViewViewControllerSpy()
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        presenter.viewDidLoad()
        
        //then
        XCTAssert(viewController.loadRequestCalled)
        
    }
    
    func testProgressVisibleWhenLessThenOne() {
        //given
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 0.6
        //when
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        //then
        XCTAssertFalse(shouldHideProgress)
    }
    
    func testProgressVisibleWhenOne() {
        //given
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 1
        //when
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        //then
        XCTAssertTrue(shouldHideProgress)
    }
    
    func testAuthHelperAuthURL() {
        //given
        let configuration = AuthConfiguration.standard
        let authHelper = AuthHelper(configuration: configuration)
        //when
        let url = authHelper.authURL()
        guard let urlString = url?.absoluteString else {
            XCTFail("Auth URL is nil")
            return
        }
        //then
        XCTAssertTrue(urlString.contains(configuration.authURLString))
        XCTAssertTrue(urlString.contains(configuration.accessKey))
        XCTAssertTrue(urlString.contains(configuration.redirectURI))
        XCTAssertTrue(urlString.contains("code"))
        XCTAssertTrue(urlString.contains(configuration.accessScope))
    }
    
    func testCodeFromURL() {
        //given
        let authHelper = AuthHelper()
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/authorize/native") else {
            XCTFail("Cant make URL Components from string")
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "code", value: "test code")
        ]
        guard let url = urlComponents.url else {
            XCTFail("Cant make URL from URLComponents")
            return
        }
        //when
        let code = authHelper.code(from: url)
        //then
        XCTAssertEqual(code, "test code")
    }
    
}

final class WebViewPresenterSpy: WebViewPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var view: WebViewViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didUpdateProgressValue(_ newValue: Double) {
        
    }
    
    func code(from url: URL) -> String? {
        return nil
    }
}

final class WebViewViewControllerSpy: WebViewViewControllerProtocol {
    var presenter: WebViewPresenterProtocol?
    var loadRequestCalled: Bool = false
    
    func load(request: URLRequest) {
        loadRequestCalled = true
    }
    
    func setProgressValue(_ newValue: Float) {
        
    }
    
    func setProgressHidden(_ isHidden: Bool) {
        
    }
    
}
