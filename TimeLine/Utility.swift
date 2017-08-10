//
//  Utility.swift
//  TimeLine
//
//  Created by 黄启明 on 2017/8/8.
//  Copyright © 2017年 Himin. All rights reserved.
//

import UIKit

extension String {
    ///根据串长度自动计算size
    func heightWithConstraintWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil)
        
        return boundingBox.size.height
    }
}

extension UILabel {
    convenience init(frame: CGRect, cornerRadius: CGFloat) {
        self.init(frame: frame)
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}

extension Date {
    static func currentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
//        let formatter = "YY/M/d h:m a"
        let formatter = "M/d h:m"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = formatter
        let dateString = dateFormatter.string(from: date)
//        print(dateString)
        return dateString
    }
}

extension TimeLineItem {

}
