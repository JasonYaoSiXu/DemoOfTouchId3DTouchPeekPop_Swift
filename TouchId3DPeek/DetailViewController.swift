//
//  DetailViewController.swift
//  TouchId3DPeek
//
//  Created by yaosixu on 16/7/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol DetailViewDeInsertDelegate {
    func insertCell(index: Int)
    func deleCell(index: Int)
}


class DetailViewController: UIViewController {

    private var titleImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 64, width: 375, height: 100))
    private var infoLabelOne: UILabel = UILabel(frame: CGRect(x: 150, y: 184, width: 75, height: 30))
    private var infoLabelTwo: UILabel = UILabel(frame: CGRect(x: 150, y: 234, width: 75, height: 30))
    private var index : Int
    var delegate: DetailViewDeInsertDelegate!
    
    init(image: UIImage, infoOne: String, infoTwo: String,indexPath: Int) {
        titleImageView.image = image
        infoLabelOne.text = infoOne
        infoLabelTwo.text = infoTwo
        index = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        title = "DeatilViewController"
        // Do any additional setup after loading the view.
        
        view.addSubview(titleImageView)
        view.addSubview(infoLabelOne)
        view.addSubview(infoLabelTwo)
    }
    
    func initOutLet(image: UIImage, infoLabelOne: String, infoLabelTwo: String) {
        titleImageView.image = image
        self.infoLabelOne.text = infoLabelOne
        self.infoLabelTwo.text = infoLabelTwo
    }

    //自定义Peek操作
    override func previewActionItems() -> [UIPreviewActionItem] {
        let itemShare = UIPreviewAction(title: "插入", style: .Default, handler: { [unowned self] _ in
            self.delegate.insertCell(self.index)
        })
        
        let itemShareTwo = UIPreviewAction(title: "删除", style: .Default, handler: { [unowned self]_ in
                self.delegate.deleCell(self.index)
        })
        
        let itemShareThree = UIPreviewAction(title: "取消", style: .Destructive, handler: { _ in
            print("Do nothing")
        })
        
        return [itemShare,itemShareTwo,itemShareThree]
    }
}