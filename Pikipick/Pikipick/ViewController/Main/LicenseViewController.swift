//
//  LicenseViewController.swift
//  Pikipick
//
//  Created by woo0 on 2022/07/16.
//

import UIKit

class LicenseViewController: UIViewController {
	var openSources: [OpenSource] = [OpenSource(openSourceName: "Apple Frameworks", licenseName: "Apple MIT License", url: "https://developer.apple.com/documentation/", copyright: "Copyright Apple lnc."), OpenSource(openSourceName: "Apple Swift", licenseName: "Apache-2.0 license", url: "https://github.com/apple/swift", copyright: "Copyright Apple lnc. and the Swift project authors")]
	var licenses: [License] = [License(licenseName: "Apache-2.0 license", licanseNotice: "ApacheLicense.txt"), License(licenseName: "MIT License", licanseNotice: "MITLicense.txt")]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
}
