//
//  TimeLineModel.swift
//  TimeLine
//
//  Created by 黄启明 on 2017/8/8.
//  Copyright © 2017年 Himin. All rights reserved.
//

import UIKit

class TimeLineModel: NSObject {
    
    var iscellAlreadyLoad = false
    
    var timeText: String
    var contentText: String
    var sectionName = "text"
    
    init(timeText: String, contentText: String) {
        self.timeText = timeText
        self.contentText = contentText
    }
    
}
