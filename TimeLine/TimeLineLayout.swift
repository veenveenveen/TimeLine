//
//  TimeLineLayout.swift
//  TimeLine
//
//  Created by 黄启明 on 2017/8/8.
//  Copyright © 2017年 Himin. All rights reserved.
//

import UIKit

class TimeLineLayout: NSObject {
    
    let horizontalDistance: CGFloat = 15.0
    let verticalDistance: CGFloat = 15.0
    
    let timeLabelFont: UIFont = UIFont.systemFont(ofSize: 12.0)
    let contentLabelFont: UIFont = UIFont.systemFont(ofSize: 14.0)
    
    var timeLabelRect = CGRect.zero
    var contentLabelRect = CGRect.zero
    
    var linePositionX: CGFloat = 0
    var totalHeight: CGFloat = 0
    
    var model: TimeLineModel
    
    init(model: TimeLineModel) {
        self.model = model
        super.init()
        
        layoutWith(model: model)
    }
    
    fileprivate func layoutWith(model: TimeLineModel) {
        let timeLabelWidth: CGFloat = 60.0
        let timeLabelHeight: CGFloat = 20.0
        
        timeLabelRect = CGRect(x: horizontalDistance, y: verticalDistance, width: timeLabelWidth, height: timeLabelHeight)
        
        let contentLabelOriginX = timeLabelWidth + horizontalDistance * 2
        let contentLabelWidth = screenWidth - timeLabelWidth - horizontalDistance * 3
        let contentLabelHeight = model.contentText.heightWithConstraintWidth(contentLabelWidth, font: timeLabelFont) + 10
        
        contentLabelRect = CGRect(x: contentLabelOriginX, y: verticalDistance, width: contentLabelWidth, height: contentLabelHeight)
        
        linePositionX = horizontalDistance + timeLabelWidth + horizontalDistance * 0.5
        
        totalHeight = verticalDistance * 2 + max(timeLabelHeight, contentLabelHeight)
        
    }

}
