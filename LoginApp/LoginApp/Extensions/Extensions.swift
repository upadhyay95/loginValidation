//
//  Extensions.swift
//  LoginApp
//
//  Created by abhishek kumar upadhyay on 04/04/20.
//  Copyright © 2020 abhishek kumar upadhyay. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:CGRect(x: iconViewFrameXY, y: iconViewFrameXY, width: iconViewFRameHeightWidth, height: iconViewFRameHeightWidth))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:CGRect(x: iconViewFRameHeightWidth, y: 0, width: conContainerViewHeightView, height: conContainerViewHeightView))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
