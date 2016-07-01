//
//  InformationViewController.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/19.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import MK2FlashAirKit

class InformationViewController: UITableViewController {

    @IBOutlet weak var updatedCell: UITableViewCell!
    @IBOutlet weak var ssidCell: UITableViewCell!
    @IBOutlet weak var networkPasswordCell: UITableViewCell!
    @IBOutlet weak var macAddressCell: UITableViewCell!
    @IBOutlet weak var firmwareVersionCell: UITableViewCell!
    @IBOutlet weak var wlanAwakeningModeCell: UITableViewCell!
    @IBOutlet weak var wlanTimeoutCell: UITableViewCell!
    @IBOutlet weak var appInfoCell: UITableViewCell!
    @IBOutlet weak var uploadableCell: UITableViewCell!
    @IBOutlet weak var updatedTimeCell: UITableViewCell!
    @IBOutlet weak var storageCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

private extension InformationViewController {
    func load() {
        // IsUpdated
        Session.sendRequest(IsUpdatedRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.updatedCell.detailTextLabel?.text = response.updated ? "YES" : "NO"
            case .Failure(let error):
                break
            }
        }

        // SSID
        Session.sendRequest(GetSSIDRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.ssidCell.detailTextLabel?.text = response.ssid
            case .Failure(let error):
                break
            }
        }
        
        // NetworkPassword
        Session.sendRequest(GetNetworkPasswordRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.networkPasswordCell.detailTextLabel?.text = response.password
            case .Failure(let error):
                break
            }
        }
        
        // MACAddress
        Session.sendRequest(GetMACAddressRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.macAddressCell.detailTextLabel?.text = response.macAddress
            case .Failure(let error):
                break
            }
        }
        
        // FirmwareVersion
        Session.sendRequest(GetFirmwareVersionRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.firmwareVersionCell.detailTextLabel?.text = response.version
            case .Failure(let error):
                break
            }
        }
        
        // WLANAwakeningMode
        Session.sendRequest(GetWLANAwakeningModeRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.wlanAwakeningModeCell.detailTextLabel?.text = String(response.wlanAwakeningMode)
            case .Failure(let error):
                break
            }
        }
        
        // WLANTimeout
        Session.sendRequest(GetWLANTimeoutRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.wlanTimeoutCell.detailTextLabel?.text = String(response.timeout)
            case .Failure(let error):
                break
            }
        }
        
        // AppInfo
        Session.sendRequest(GetAppInfoRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.appInfoCell.detailTextLabel?.text = response.appInfo
            case .Failure(let error):
                break
            }
        }
        
        // Uploadable
        Session.sendRequest(IsUploadableRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.uploadableCell?.detailTextLabel?.text = response.uploadable ? "YES" : "NO"
            case .Failure(let error):
                break
            }
        }
        
        // Updated time
        Session.sendRequest(GetUpdatedTimeRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                self?.updatedTimeCell?.detailTextLabel?.text = String(response.timeIntervalSinceBoot)
            case .Failure(let error):
                break
            }
        }
        
        // Storage
        Session.sendRequest(GetStorageInfoRequest()) { [weak self] (result) in
            switch result {
            case .Success(let response):
                let estimatedFreeSizeMB = Double(response.estimatedFreeSize) / Double(1024 * 1024)
                let estimatedMaxSizeMB = Double(response.estimatedMaxSize) / Double(1024 * 1024)
                self?.storageCell?.detailTextLabel?.text = "\(estimatedFreeSizeMB)/\(estimatedMaxSizeMB)MB"
            case .Failure(let error):
                break
            }
        }
        
    }
}