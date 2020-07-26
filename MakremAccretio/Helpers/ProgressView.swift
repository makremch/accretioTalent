//
//  ProgressView.swift
//  MakremAccretio
//
//  Created by Makrem chambah on 7/26/20.
//  Copyright © 2020 Makrem. All rights reserved.
//

import UIKit
import SVProgressHUD


class ProgressView {
    static  func startLoding() {
        print(7)
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(.cyan)
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setDefaultMaskType(.black)
    }
    static  func StopLoding() {
        SVProgressHUD.dismiss()
    }
}
