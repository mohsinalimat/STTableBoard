//
//  ViewController.swift
//  STTableBoardDemo
//
//  Created by DangGu on 15/12/14.
//  Copyright © 2015年 StormXX. All rights reserved.
//

import UIKit
import STTableBoard

class ViewController: UIViewController {
    
    var dataArray: [[String]] = []
    var titleArray: [String] = []
    let tableBoard: STTableBoard! = STTableBoard()
    
    override func viewDidLoad() {
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.title = "Teambition"
        addAddButton()
        dataArray = [
            ["七里香1","七里香2","七里香3","七里香4","最后的战役1","最后的战役2","最后的战役3","晴天1","晴天2","晴天3","晴天4","晴天5","爱情悬崖1","爱情悬崖2","爱情悬崖3","爱情悬崖4","彩虹1","彩虹2","彩虹3","彩虹4"],
            ["彩虹","星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴星晴"],
            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"]
        ]
        
        titleArray = ["七里香", "星晴", "彩虹", "彩虹", "彩虹"]
        
//        dataArray = [
//            ["七里香1","七里香2","七里香3","七里香4","最后的战役1","最后的战役2","最后的战役3","晴天1","晴天2","晴天3","晴天4","晴天5","爱情悬崖1","爱情悬崖2","爱情悬崖3","爱情悬崖4","彩虹1","彩虹2","彩虹3","彩虹4"],
//            ["最后的战役1","最后的战役2","最后的战役3"],
//            ["晴天1","晴天2","晴天3","晴天4","晴天5"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["星晴1","星晴2","星晴3"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//        ]
        
//        dataArray = [
//            ["Teambition Web UI 问题集合", "Windows Platform Version", "Apple Watch Glance Redesign", "23333333333333333333333333333333333", "Integartion", "建 Teambition 的dribbble账号，200美金一年", "我想不出来了。。。", "我就凑个数啊", "满一页了吧", "到底能不能滚动啊!!", "人生啊！！！！"],
//            ["Teamibition Universal App", "Swift 2.0", "Carthage", "RxSwift", "Raywenderlich", "1月10号 Swift开发者大会"],
//            ["Google", "Android Studio", "Gradle"],
//            ["Teambition 文化衫设计", "圣诞主题口罩设计", "名片设计"],
//            ["彩虹1","彩虹2","彩虹3","彩虹4","彩虹5","彩虹6"],
//            ["最后的战役1","最后的战役2","最后的战役3"],
//            ["星晴1","星晴2","星晴3"]
//        ]
        
        tableBoard.contentInset = UIEdgeInsets(top: 64.0, left: 0, bottom: 0, right: 0)
//        table.sizeOffset = CGSize(width: 80, height: 0)
        tableBoard.registerClasses(classAndIdentifier: [(BoardCardCell.self,"DefaultCell")])
        tableBoard.delegate = self
        tableBoard.dataSource = self
        tableBoard.showAddBoardButton = true
        self.addChildViewController(tableBoard)
        view.addSubview(tableBoard.view)
        tableBoard.didMoveToParentViewController(self)
    }
    
    func addAddButton() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "doneButtonClick")
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func doneButtonClick() {
        let indexPath1 = STIndexPath(forRow: dataArray[1].count, inBoard: 1)
        dataArray[1].append("wtf")
        tableBoard.insertRowAtIndexPath(indexPath1, withRowAnimation: .Fade, atScrollPosition: .Bottom)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: STTableBoardDelegate {
    func tableBoard(tableBoard: STTableBoard, heightForRowAtIndexPath indexPath: STIndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableBoard(tableBoard: STTableBoard, willRemoveBoardAtIndex index: Int) {
        dataArray.removeAtIndex(index)
        titleArray.removeAtIndex(index)
    }
    
    func tableBoard(tableBoard: STTableBoard, willAddNewBoardAtIndex index: Int, withBoardTitle title: String) {
        dataArray.append([])
        titleArray.append(title)
        tableBoard.insertBoardAtIndex(index, withAnimation: true)
    }
}

extension ViewController: STTableBoardDataSource {
    func tableBoard(tableBoard: STTableBoard, titleForBoardInBoard board: Int) -> String? {
        return titleArray[board]
    }
    
    func numberOfBoardsInTableBoard(tableBoard: STTableBoard) -> Int {
        return dataArray.count
    }
    
    func tableBoard(tableBoard: STTableBoard, numberOfRowsInBoard board: Int) -> Int {
        return dataArray[board].count
    }
    
    func tableBoard(tableBoard: STTableBoard, cellForRowAtIndexPath indexPath: STIndexPath) -> UITableViewCell {
        let cell = tableBoard.dequeueReusableCellWithIdentifier("DefaultCell", forIndexPath: indexPath) as! BoardCardCell
        cell.titleText = dataArray[indexPath.board][indexPath.row]
        return cell
    }

    func tableBoard(tableBoard: STTableBoard, boardTitleBeChangedTo title: String, inBoard board: Int) {
        titleArray[board] = title
    }
    
    func tableBoard(tableBoard: STTableBoard, didAddRowAtBoard board: Int, withRowTitle title: String) {
        let indexPath = STIndexPath(forRow: dataArray[board].count, inBoard: board)
        dataArray[board].append(title)
        tableBoard.insertRowAtIndexPath(indexPath, withRowAnimation: .Fade, atScrollPosition: .Bottom)
    }
    
    // move row
    func tableBoard(tableBoard: STTableBoard, moveRowAtIndexPath sourceIndexPath: STIndexPath, toIndexPath destinationIndexPath: STIndexPath) {
        let data = dataArray[sourceIndexPath.board][sourceIndexPath.row]
        dataArray[sourceIndexPath.board].removeAtIndex(sourceIndexPath.row)
        dataArray[destinationIndexPath.board].insert(data, atIndex: destinationIndexPath.row)
    }
    
    func tableBoard(tableBoard: STTableBoard, shouldMoveRowAtIndexPath sourceIndexPath: STIndexPath, toIndexPath destinationIndexPath: STIndexPath) -> Bool {
        if destinationIndexPath.board == 1 && destinationIndexPath.row == 1 {
            return false
        }
        return true
    }
    
    func tableBoard(tableBoard: STTableBoard, canMoveRowAtIndexPath indexPath: STIndexPath) -> Bool {
        if indexPath.board == 0 && indexPath.row == 2 {
            return false
        }
        return true
    }
    
    func tableBoard(tableBoard: STTableBoard, didEndMoveRowAtOriginIndexPath originIndexPath: STIndexPath, toIndexPath destinationIndexPath: STIndexPath) {
        print("originIndexPath \(originIndexPath), destinationIndexPath \(destinationIndexPath)")
    }
    
    // move board
    func tableBoard(tableBoard: STTableBoard, moveBoardAtIndex sourceIndex: Int, toIndex destinationIndex: Int) {
        let sourceData = dataArray[sourceIndex]
        let destinationData = dataArray[destinationIndex]
        dataArray[sourceIndex] = destinationData
        dataArray[destinationIndex] = sourceData
    }
    
    func tableBoard(tableBoard: STTableBoard, canMoveBoardAtIndex index: Int) -> Bool {
        if index == 0 {
            return false
        }
        return true
    }
    
    func tableBoard(tableBoard: STTableBoard, didEndMoveBoardAtOriginIndex originIndex: Int, toIndex destinationIndex: Int) {
        print("originIndex \(originIndex), destinationIndex \(destinationIndex)")
    }
}
