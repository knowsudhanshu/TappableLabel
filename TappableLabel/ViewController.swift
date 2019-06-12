//
//  ViewController.swift
//  TappableLabel
//
//  Created by Sudhanshu Sudhanshu on 12/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let label: TappableLabel = TappableLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            ])
        
        let privacyText = "Privacy Policy"
        let termsText = "Terms of Use"
        let agreementText = "I agree to \(privacyText) and \(termsText) of Longwalks"
        let attributedString = NSMutableAttributedString(string: agreementText, attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.black,
            .kern: 0.11
            ])
        
        var tappableRanges: [NSRange] = []
        let linkAttrbutes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.orange, .underlineStyle: NSUnderlineStyle.single.rawValue,
                             .underlineColor: UIColor.orange]
        let privaryRange = (agreementText as NSString).range(of: privacyText)
        tappableRanges.append(privaryRange)
        
        attributedString.addAttributes(linkAttrbutes, range: privaryRange)
        
        let termsRange = (agreementText as NSString).range(of: termsText)
        tappableRanges.append(termsRange)
        
        attributedString.addAttributes(linkAttrbutes, range: termsRange)
        
        label.numberOfLines = 0
        label.addAction(for: attributedString, at: tappableRanges)
        label.tapCallback = { index in
            print("index: \(index) -> range: \(tappableRanges[index])")
        }
    }
}
