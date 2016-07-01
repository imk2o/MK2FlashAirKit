//
//  FileListViewController.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/17.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import MK2FlashAirKit
import AlamofireImage

class FileListViewController: UIViewController {
    var path: String! = "/"
    
    private var fileListItems: [FileListItem] = []
    private var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.path.componentsSeparatedByString("/").last
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = FileListRequest(directory: self.path)
        Session.sendRequest(request) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.fileListItems = response.fileListItems
                self?.tableView.reloadData()
            case .Failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case .Some("ShowSubdirectory"):
            guard
                let indexPath = self.tableView.indexPathForSelectedRow,
                let destinationFileListVC = segue.destinationViewController as? FileListViewController
            else {
                fatalError()
            }

            let fileListItem = self.fileListItems[indexPath.row]
            destinationFileListVC.path = fileListItem.path
        case .Some("ShowImage"):
            guard
                let indexPath = self.tableView.indexPathForSelectedRow,
                let destinationImageVC = segue.destinationViewController as? ImageViewController
            else {
                fatalError()
            }

            let fileListItem = self.fileListItems[indexPath.row]
            destinationImageVC.imageURL = fileListItem.fileURL
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension FileListViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fileListItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let fileListItem = self.fileListItems[indexPath.row]
        if fileListItem.isDirectory {
            let cell = tableView.dequeueReusableCellWithIdentifier("DirectoryCell", forIndexPath: indexPath)

            cell.textLabel?.text = fileListItem.fileName
            cell.detailTextLabel?.text = self.dateFormatter.stringFromDate(fileListItem.date)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FileCell", forIndexPath: indexPath)
            
            let detailText = self.dateFormatter.stringFromDate(fileListItem.date)
            cell.textLabel?.text = fileListItem.fileName
            cell.detailTextLabel?.text = detailText
            cell.imageView?.image = UIImage(named: "placeholder")
            cell.imageView?.af_setImageWithURL(fileListItem.thumbnailURL)
            
            return cell
        }
    }
}
