//
//  TimeLineCell.swift
//  TimeLine
//
//  Created by 黄启明 on 2017/8/8.
//  Copyright © 2017年 Himin. All rights reserved.
//

import UIKit

class TimeLineCell: UITableViewCell {
    
    var timeLabel = UILabel(frame: CGRect.zero, cornerRadius: 3)
    var contentLabel = UILabel(frame: CGRect.zero, cornerRadius: 3)
    
    var lineLayer = CAShapeLayer()
    
    var timeLineLayout: TimeLineLayout!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeLabel.frame = timeLineLayout.timeLabelRect
        contentLabel.frame = timeLineLayout.contentLabelRect
        
        //动画
        if timeLineLayout.model.iscellAlreadyLoad {
            lineLayer.path = animationPath()
        }
        else {
            animationLayer()
        }
        
    }
    
    func configurationCell(layout: TimeLineLayout) {
        self.timeLineLayout = layout
        
        timeLabel.text = layout.model.timeText
        timeLabel.font = layout.timeLabelFont
        contentLabel.text = layout.model.contentText
        contentLabel.font = layout.contentLabelFont
    }
    
    ///
    fileprivate func setupView() {
        timeLabel.textColor = UIColor.black
        timeLabel.backgroundColor = themeColor
        timeLabel.textAlignment = .right
        contentView.addSubview(timeLabel)
        
        contentLabel.textColor = UIColor.black
        contentLabel.backgroundColor = themeColor
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 0
        contentView.addSubview(contentLabel)
        
        lineLayer.strokeColor = UIColor.orange.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.lineWidth = 1.0
        contentView.layer.addSublayer(lineLayer)
    }
    
    ///
    fileprivate func animationPath() -> CGPath {
        let pointX = timeLineLayout.linePositionX
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: pointX, y: 0))
        
        let radius: CGFloat = 3.0
        let pointY = timeLineLayout.verticalDistance + timeLineLayout.timeLabelRect.size.height * 0.5
        path.addLine(to: CGPoint(x: pointX, y: pointY - radius))
        
        path.addArc(withCenter: CGPoint(x: pointX, y: pointY), radius: radius, startAngle: degreesToRadian(-90), endAngle: degreesToRadian(450), clockwise: true)
        
        path.addLine(to: CGPoint(x: pointX, y: timeLineLayout.totalHeight))
        
        return path.cgPath
    }
    
    fileprivate func degreesToRadian(_ degrees: CGFloat) -> CGFloat {
        return degrees * CGFloat.pi / 180
    }
    
    fileprivate func animationLayer() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = animationDuration
        lineLayer.path = animationPath()
        lineLayer.add(animation, forKey: nil)
    }
    
}
