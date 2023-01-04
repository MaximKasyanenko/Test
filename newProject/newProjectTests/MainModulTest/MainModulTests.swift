//
//  newProjectTests.swift
//  newProjectTests
//
//  Created by Maksim Kasyanenko on 03.01.2023.
//

import XCTest
@testable import newProject

final class MainModulTest: XCTestCase {
    var data: Data!
    var mockNetworkServise: MockNetworkServiseProtocol!
    var view: MainViewProtocol!
    var router: RouterProtocol!
    var trackServise: TrackServiceProtocol!
    var mainPresenter: PresenterProtocol!
    
    override func setUpWithError() throws {
        data = Data()
        mockNetworkServise = MockNetworkServise(data: data)
        trackServise = TrackService(network: mockNetworkServise)
        view = MainViewController()
        router = Router(navigationController: UINavigationController(), sceneBuilder: SceneBuilder())
        mainPresenter = MainPresenter(view: view, router: router, trackServise: trackServise)
        
    }
    
    override func tearDownWithError() throws {
        data = nil
        mockNetworkServise = nil
        view = nil
        router = nil
        trackServise = nil
        mainPresenter = nil
    }
    
    func testMainPresentorGetTrackComplite() {
        DispatchQueue.global().async { [self] in
            mainPresenter.getTrack(serch: "Test Test")
        }
        expectToEventually(mainPresenter.tracks?.first?.artistName == mockNetworkServise.mockTrackComplite.first?.artistName)
    }
    
    func testMainPresentorGetTrackFailur() {
        DispatchQueue.global().async { [self] in
            mainPresenter.getTrack(serch: "Tap")
        }
        expectToEventually(mainPresenter.tracks?.first?.artistName == mockNetworkServise.mockTrackFailure.first?.artistName)
    }
    
    func testMainPresenterDetImage() {
        let exp = expectation(description: "My")
        var dataTest: Data?
        mainPresenter.getImage(url: "Test") { data in
            dataTest = data
            exp.fulfill()
        }
        waitForExpectations(timeout: 2) { error in
            XCTAssertNotNil(dataTest)
        }
    }
}



