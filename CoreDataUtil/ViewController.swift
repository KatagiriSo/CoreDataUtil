//
//  ViewController.swift
//  CoreDataUtil
//
//  Created by 片桐奏羽 on 2015/10/02.
//  Copyright (c) 2015年 SoKatagiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var list: [Record]?;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var util = CoreDataUtil.share()
        self.list = util.GET()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfSections() -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var item = self.list?[indexPath.row]
        cell.textLabel!.text = item?.text
        return cell
    }
    
    @IBAction func pushed(sender: AnyObject) {
        var util = CoreDataUtil.share()
        var record = util.CREATE()
        
        record.timestamp = NSDate()
        var t = record.timestamp.description
        record.text = "record " + t
        
        
        self.list?.append(record)
        var error:NSError?
        var a = util.save(&error)
        
        self.tableView.reloadData()
    }
    

}

