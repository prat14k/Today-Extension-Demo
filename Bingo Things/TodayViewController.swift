//
//  TodayViewController.swift
//  Bingo Things
//
//  Created by Ritu on 22/11/17.
//  Copyright © 2017 Bingo. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding , UITableViewDelegate,UITableViewDataSource {
    
           
    @IBOutlet weak var labelCompact: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var preferrredHght : CGFloat! = 20
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "title no. \(indexPath.row)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        
        if(expanded){
            preferredContentSize = CGSize(width: preferredContentSize.width , height: tableView.contentSize.height)
            tableView.isHidden = false
            labelCompact.isHidden = true
        }
        else{
            preferredContentSize = maxSize
            labelCompact.isHidden = false
            tableView.isHidden = true
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
//        let url = NSURL(string: "extendedApp://recent")
        let url = URL(string: "extendedApp://recent")
        extensionContext?.open(url!, completionHandler: nil)
        
    }
    
    func updateFrame(){
        
        var tableFrame = tableView.frame
        tableFrame.size.height = tableView.contentSize.height
        
        let expanded = extensionContext?.widgetActiveDisplayMode == NCWidgetDisplayMode.expanded
        
        if(expanded){
            preferredContentSize = CGSize(width: preferredContentSize.width , height: tableView.contentSize.height)
            labelCompact.isHidden = true
            tableView.isHidden = false
        }
        else{
            labelCompact.isHidden = false
            tableView.isHidden = true
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        updateFrame()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        tableView.reloadData()
        completionHandler(NCUpdateResult.newData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateFrame()
    }
    
}
