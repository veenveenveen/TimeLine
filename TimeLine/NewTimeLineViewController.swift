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
        
        textView?.resignFirstResponder()
        
        let text = textView.text != nil ? textView.text : ""
        let newItem = CoreDataManager.shareManger.insertNewItem(contentText: text!)
        
        _ = navigationController?.popViewController(animated: true)
        
        let vc = navigationController?.viewControllers[0] as! ViewController
        vc.sourceArray.append(newItem)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { 
            vc.animationDisplay()
        }
    }

}
