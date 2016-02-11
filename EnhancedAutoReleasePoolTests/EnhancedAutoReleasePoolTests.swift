//
//  EnhancedAutoReleasePoolTests.swift
//  EnhancedAutoReleasePoolTests
//
//  Created by Suguru Kishimoto on 2016/02/11.
//
//

import XCTest
@testable import EnhancedAutoReleasePool

class EnhancedAutoReleasePoolTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func mockImage() -> UIImage {
        return UIImage(contentsOfFile: NSBundle(forClass: self.dynamicType).pathForResource("test", ofType: "png")!)!
    }
    
    func testAutoReleasePools() {
        
        // MARK: normal autoreleasepool
        var arr1 = [Int]()
        (0..<10000).forEach { _ in
            autoreleasepool {
                let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
                imgView.image = mockImage()
                arr1.append(1)
                imgView.image = nil
            }
        }
        XCTAssertEqual(arr1.count, 10000)
        
        // MARK: autorelease and return value
        var arr2 = [Int]()
        (0..<10000).forEach { _ in
            let value = autoreleasepool { () -> Int in
                let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
                imgView.image = mockImage()
                imgView.image = nil
                return 1
            }
            arr2.append(value)
        }
        XCTAssertEqual(arr2.count, 10000)
        
        // MARK: autorelease and return value?
        var arr3 = [Int?]()
        (0..<10000).forEach { index in
            let value = autoreleasepool { () -> Int? in
                let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
                imgView.image = mockImage()
                imgView.image = nil
                return (index % 2 == 0 ? nil : 1)
            }
            arr3.append(value)
        }
        XCTAssertEqual(arr3.count, 10000)
        
        // MARK: autorelease with try
        var arr4 = [Int]()
        do {
            try (0..<10000).forEach { index in
                try autoreleasepool {
                    if (index == 5000) {
                        throw NSError(domain: "", code: 0, userInfo: nil)
                    }
                    let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
                    imgView.image = mockImage()
                    arr4.append(1)
                    imgView.image = nil
                }
            }
        } catch ( _) {
            
        }
        XCTAssertEqual(arr4.count, 5000)
        
        // MARK: autorelease with try and return value
        var arr5 = [Int]()
        do {
            try (0..<10000).forEach { index in
                let value: Int = try autoreleasepool {
                    if (index == 5000) {
                        throw NSError(domain: "", code: 0, userInfo: nil)
                    }
                    let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
                    imgView.image = mockImage()
                    imgView.image = nil
                    return 1
                }
                arr5.append(value)
            }
        } catch ( _) {
        }
        XCTAssertEqual(arr5.count, 5000)

        // MARK: autorelease with try and return value?
        var arr6 = [Int?]()
        do {
            try (0..<10000).forEach { index in
                let value: Int? = try autoreleasepool {
                    if (index == 5000) {
                        throw NSError(domain: "", code: 0, userInfo: nil)
                    }
                    let imgView = UIImageView(frame: CGRectMake(0, 0, 5000, 5000))
                    imgView.image = mockImage()
                    imgView.image = nil
                    return (index % 2 == 0 ? nil : 1)
                }
                arr6.append(value)
            }
            
        } catch ( _) {
        }
        XCTAssertEqual(arr6.count, 5000)


    }
    
}
