//
//  InfoViewController.swift
//  TouchId3DPeek
//
//  Created by yaosixu on 16/7/18.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

//登录成功后显示的内容
class InfoViewController: UIViewController {

    let tableView = UITableView()
    let imageArray = ["男","女"]
    let titleInfo = ["1","2","3","4","5","6","7","8","9","10"]
    let subTitle = ["1sub","2sub","3sub","4sub","5sub","6sub","7sub","8sub","9sub","10sub"]
    var cellArray : [ScrolViewInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        automaticallyAdjustsScrollViewInsets = false
        title = "InfoView"
        
        addCellToCellArray()
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initTableView() {
        tableView.frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        //Pop Peek 实现Pop Peek必须实现的代理
        registerForPreviewingWithDelegate(self, sourceView: view)
    }
    
    func addCellToCellArray() {
        
        for i in 0...99 {
            let cellItem = ScrolViewInfo(titleImage: UIImage(named: imageArray[i % 2]), titleString: titleInfo[i % 10], subTitleString: subTitle[i % 10], selectedAction: {
                print("i = \(i)")
            })
            cellArray.append(cellItem)
        }
        
    }
    
}

extension InfoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.imageView?.image = cellArray[indexPath.row].titleImage
        cell.textLabel?.text = cellArray[indexPath.row].titleString
        cell.detailTextLabel?.text = cellArray[indexPath.row].subTitleString
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(#function):: \(indexPath.row)")
        cellArray[indexPath.row].selectedAction()
    }
    
}

extension InfoViewController : UIViewControllerPreviewingDelegate {
    
    //Pop
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        viewControllerToCommit.view.backgroundColor = UIColor.whiteColor()
        showViewController(viewControllerToCommit, sender: self)
    }
    
    //Peek
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let indexPath = tableView.indexPathForRowAtPoint(CGPoint(x: location.x,y:location.y - 64))
        
        if indexPath == nil {
            return nil
        }
        print("\(#function)::\(indexPath!.row)")
        let detailViewController = DetailViewController(image: cellArray[indexPath!.row].titleImage!, infoOne: cellArray[indexPath!.row].titleString!, infoTwo: cellArray[indexPath!.row].subTitleString!,indexPath: indexPath!.row)
        detailViewController.delegate = self
        
        return detailViewController
    }
}

extension InfoViewController : DetailViewDeInsertDelegate {
    //自定义插入操作
    func insertCell(index: Int) {
        let cellItem = ScrolViewInfo(titleImage: UIImage(named: imageArray[index % 2]), titleString: titleInfo[index % 10], subTitleString: subTitle[index % 10], selectedAction: {
            print("index = \(index)")
        })
        cellArray.insert(cellItem, atIndex: index)
        tableView.reloadData()
    }
    
    //自定义删除操作
    func deleCell(index: Int) {
        print("\(#function)")
        cellArray.removeAtIndex(index)
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow:index, inSection: 0)], withRowAnimation: .Left)
        tableView.endUpdates()
    }
    
}


