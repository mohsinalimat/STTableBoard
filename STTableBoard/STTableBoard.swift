//
//  STTableBoard.swift
//  STTableBoard
//
//  Created by DangGu on 15/10/27.
//  Copyright © 2015年 Donggu. All rights reserved.
//

import UIKit

class STTableBoard: UIViewController {
    
    var boardWidth: CGFloat {
        get {
            return self.view.width - (leading + trailing)
        }
    }
    var maxBoardHeight: CGFloat {
        get {
            return self.containerView.height - (top + bottom)
        }
    }

    var numberOfPage: Int {
        get {
            guard let page = self.dataSource?.numberOfBoardsInTableBoard(self) else { return 1 }
            return page
        }
    }
    
    var longPressGesture: UILongPressGestureRecognizer {
        get {
            let gesture = UILongPressGestureRecognizer(target: self, action: "handleLongPressGesuter:")
            return gesture
        }
    }
    
    var currentPage: Int = 0
    var registerCellClasses:[(AnyClass, String)] = []
    var tableBoardMode: STTableBoardMode = .Page

    //Views Property
    var boards: [STBoardView] = []
    var scrollView: UIScrollView!
    var containerView: UIView!

    //Delegate Property
    weak var dataSource: STTableBoardDataSource?
    weak var delegate: STTableBoardDelegate?

    //Move Row Property
    var snapshot: UIView!
    var snapshotCenterOffset: CGPoint!
    var snapshotOffsetForLeftBounds: CGFloat!
    var sourceIndexPath: STIndexPath!

    //ScrollView Auto Scroll property
    var isScrolling: Bool = false
    var scrollDirection: ScrollDirection = .None
    var velocity: CGFloat = defaultScrollViewScrollVelocity

    //TableView Auto Scroll Property
    var tableViewAutoScrollTimer: NSTimer?
    var tableViewAutoScrollDistance: CGFloat = 0

    //Zoom Property
    var originContentOffset = CGPoint(x: 0, y: 0)
    var originContentSize = CGSize(width: 0, height: 0)
    var scaledContentOffset = CGPoint(x: 0, y: 0)
    var currentScale: CGFloat = scaleForPage
    var tapPosition: CGPoint = CGPoint(x: 0, y: 0)

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperty()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }

    //MARK: - init helper
    private func setupProperty() {
        let contentViewWidth = view.width + (view.width - overlap) * CGFloat(numberOfPage - 1)
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: contentViewWidth, height: view.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.minimumZoomScale = scaleForScroll
        scrollView.maximumZoomScale = scaleForPage
        scrollView.delegate = self
        scrollView.bounces = false
        view.addSubview(scrollView)

        containerView = UIView(frame: CGRect(origin: CGPointZero, size: scrollView.contentSize))
        scrollView.addSubview(containerView)
        containerView.backgroundColor = UIColor.浅草绿()

        let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
        doubleTapGesture.delegate = self
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        containerView.addGestureRecognizer(doubleTapGesture)
    }

    func reloadData() {
        let contentViewWidth = view.width + (view.width - overlap) * CGFloat(numberOfPage - 1)
        scrollView.contentSize = CGSize(width: contentViewWidth, height: view.height)
        containerView.frame = CGRect(origin: CGPointZero, size: scrollView.contentSize)

        if boards.count != 0 {
            boards.forEach({ (board) -> () in
                board.removeFromSuperview()
            })
            boards.removeAll()
        }

        for i in 0..<numberOfPage {
            let x = leading + CGFloat(i) * (boardWidth + pageSpacing)
            let y = top
            let boardViewFrame = CGRect(x: x, y: y, width: boardWidth, height: maxBoardHeight)

            let boardView: STBoardView = STBoardView(frame: boardViewFrame)
            boardView.addGestureRecognizer(self.longPressGesture)
            boardView.index = i
            boardView.tableView.delegate = self
            boardView.tableView.dataSource = self
            registerCellClasses.forEach({ (classAndIdentifier) -> () in
                boardView.tableView.registerClass(classAndIdentifier.0, forCellReuseIdentifier: classAndIdentifier.1)
            })
            autoAdjustTableBoardHeight(boardView, animated: false)
            boards.append(boardView)
        }

        boards.forEach { (cardView) -> () in
            containerView.addSubview(cardView)
        }
    }
}