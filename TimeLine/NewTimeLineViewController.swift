//
//  NewTimeLineViewController.swift
//  TimeLine
//
//  Created by 黄启明 on 2017/8/8.
//  Copyright © 2017年 Himin. All rights reserved.
//

import UIKit

class NewTimeLineViewController: UIViewController {
    
    var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupNavigationUI()
        
        setupTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationUI() {
        navigationItem.title = "新建"
        
        let rightButton = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doSave))
        rightButton.tintColor = buttonTintColor
        navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(doCancel))
        leftButton.tintColor = buttonTintColor
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func setupTextView() {
        textView = UITextView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        view.addSubview(textView)
    }
    
    func doCancel() {
        print("cancel")
        
//        textView?.resignFirstResponder()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func doSave() {
        print("save")
        
//        textView?.resignFirstResponder()
        
        _ = navigationController?.popViewController(animated: true)
        
        let text = textView.text != nil ? textView.text : ""
        let newItem = TimeLineModel(timeText: Date.currentDate(), contentText: text!)
        
        let vc = navigationController?.viewControllers[0] as! ViewController
        vc.sourceArray.append(newItem)
        vc.animationDisplay()
//        let lastIndexPath = NSIndexPath(row: (vc.sourceArray.count - 1), section: 0) as IndexPath
//        vc.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
//        .sourceArray.append(newItem)
//        .animationDisplay()
        
        
//        CoreDataManager.shareManager.addNewItem(timeText: Date.currentDate(), contentText: "this is a test")
        
//        //执行保存操作
//        //写入数据
//        var titleName = "新Note(无内容)"
//        if (textView?.text.characters.count)! < showTextCount {
//            if (textView?.text.characters.count)! > 0 {
//                titleName = (textView?.text)!
//            }
//        }
//        else {
//            let index = textView?.text.index((textView?.text.startIndex)!, offsetBy: showTextCount)
//            titleName = (textView?.text.substring(to: index!))!
//        }
        
        //        let str = NSMutableAttributedString(attributedString: (textView?.attributedText)!)
        //        let textAttachment = NSTextAttachment(data: nil, ofType: nil)
        //        textAttachment.image = UIImage(named: "img.png")
        //        let textAttachmentString = NSAttributedString(attachment: textAttachment)
        //        str.insert(textAttachmentString, at: 0)
        //        textView?.attributedText = str
        
//        CoreDataManager.shareManager.addNewItem(title: titleName, details: (textView?.text)!)
    }

}
