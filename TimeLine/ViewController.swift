//
//  ViewController.swift
//  TimeLine
//
//  Created by 黄启明 on 2017/8/7.
//  Copyright © 2017年 Himin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let manager = CoreDataManager.shareManger
    
//    var sourceArray: [TimeLineItem] = [
//        CoreDataManager.shareManger.insertNewItem(timeText: "8/8 14:19",contentText: "1: 上班打卡"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "8:30",contentText: "2: 今天天气不错呢，美好的一天。"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "9:00",contentText: "3: 开始要工作了呢，今天要做好多事请，先列个计划吧，嗯，开始工作。为了加长这个字符串，继续写以下废话，废话很多，用来占位置的，方便测试，嘻嘻哈哈，(*^__^*) 嘻嘻……"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "9:30",contentText: "4: 开一会儿小差吧，吃个点心啥的"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "10:00",contentText: "5: 哦，还有好多工作啊，别吃了"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "10:30",contentText: "6: 嗯，休息时间到了，今天是睡觉呢还是玩儿游戏呢，这是个问题,还是先玩一会游戏吧"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "11:00",contentText: "7: 继续工作，坑爹了，这个bug不好解决呀"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "11:30",contentText: "8: 先热个饭"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "12:00",contentText: "9: 吃饭，散步，一条龙"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "12:30",contentText: "10: 看会NBA,骑士这都能输？看来这周就要结束总决赛了"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "13:00",contentText: "11: 睡觉,想妹子"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "14:00",contentText: "12: 起来做事，bug修不完回不了家"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "15:00",contentText: "13: 下午茶时间到了,拿根香蕉和牛奶吧，反正也没有什么好吃的"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "16:00",contentText: "14: 继续工作"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "17:00",contentText: "15: 赶紧做完事情，免得又要加班。"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "18:00",contentText: "16: 约妹子吃饭看电影打豆豆一起学习swift，少壮不努力，老大喜当爹"),
//        CoreDataManager.shareManger.insertNewItem(timeText: "23:00",contentText: "17: 至今思项羽，不肯喜当爹。睡觉")
//        ]
    
    var sourceArray = [TimeLineItem]()
    
    var layoutArr: [TimeLineLayout] = []
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourceArray = manager.queryData()
        
        navigationItem.title = "Time Line"
        
        //添加按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTimeLineButtonClick))
        
        //清空按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "清除所有", style: .plain, target: self, action: #selector(deleteAllTimeLineButtonClick))
        
        print(Date.currentDate())

        setupTableView()
        animationDisplay()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///setup TableView
    fileprivate func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            , style: .plain)
        tableView.register(TimeLineCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
    }
    
    //MARK: - tableview 动画
    
    func animationDisplay() {
        
        if layoutArr.count >= sourceArray.count {
            return
        }
        
        let item = sourceArray[layoutArr.count]
        
        layoutArr.append(TimeLineLayout(item: item))
        
        let lastIndexPath = NSIndexPath(row: layoutArr.count - 1, section: 0) as IndexPath
        
        print(lastIndexPath.row)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [lastIndexPath], with: .top)
        tableView.endUpdates()
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        
        //防止动画重复
        layoutArr[layoutArr.count - 1].iscellAlreadyLoad = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationDuration) {
            self.animationDisplay()
        }
    }
    
    //MARK: - navigationItem button
    
    @objc fileprivate func deleteAllTimeLineButtonClick() {
        
        print("delete all")
        
        sourceArray.removeAll()
        layoutArr.removeAll()
        
        CoreDataManager.shareManger.deleteAll()
        tableView.reloadData()
        
    }
    
    @objc fileprivate func addNewTimeLineButtonClick() {
        
        print("add click")
        
        let newTimeLineVC = NewTimeLineViewController()
        navigationController?.pushViewController(newTimeLineVC, animated: true)
        
    }

    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layoutArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TimeLineCell
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let timeLineCell = cell as! TimeLineCell
        timeLineCell.configurationCell(layout: layoutArr[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return layoutArr[indexPath.row].totalHeight
    }
    
}

