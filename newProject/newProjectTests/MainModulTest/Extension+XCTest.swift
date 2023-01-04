//
//  Extension+.swift
//  newProjectTests
//
//  Created by Maksim Kasyanenko on 04.01.2023.
//
import XCTest

extension XCTest {
    func expectToEventually(_ test: @autoclosure () -> Bool, timeout: TimeInterval = 1.0, message: String = "") {
        let runLoop = RunLoop.current
        let timeoutDate = Date(timeIntervalSinceNow: timeout)
        repeat {
            if test() {
                return
            }
            runLoop.run(until: Date(timeIntervalSinceNow: 0.01))
        } while Date().compare(timeoutDate) == .orderedAscending
        XCTFail(message)
    }
}
