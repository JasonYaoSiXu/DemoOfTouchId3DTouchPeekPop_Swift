//
//  ScrolViewInfo.swift
//  TouchId3DPeek
//
//  Created by yaosixu on 16/7/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

// 因为这里每个tableViewCell显示的内容相同，所以用ScrolViewInfo封装cell显示的内容
class ScrolViewInfo : NSObject {
    
    let titleImage : UIImage?
    let titleString : String?
    let subTitleString : String?
    let selectedAction: () -> Void
    
    init(titleImage: UIImage?, titleString: String?, subTitleString: String, selectedAction: () -> Void) {
        self.titleImage = titleImage
        self.titleString = titleString
        self.subTitleString = subTitleString
        self.selectedAction = selectedAction
        super.init()
    }
    
}
