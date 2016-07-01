//
//  ConfigViewController.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/21.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import MK2FlashAirKit

class ConfigViewController: UITableViewController {
    private var masterCode: String?
    private var values = ConfigRequest.Values()
    
    @IBOutlet weak var masterCodeCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.masterCode = NSUserDefaults.standardUserDefaults().objectForKey(UserDefaultsKey.MasterCode.rawValue) as? String
        if let masterCode = self.masterCode {
            self.masterCodeCell.detailTextLabel?.text = masterCode
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func save(sender: AnyObject) {
        guard let masterCode = self.masterCode else {
            return
        }
        
        let request = ConfigRequest(masterCode: masterCode, values: self.values)
        Session.sendRequest(request) { [weak self] (result) in
            switch result {
            case .Success(_):
                self?.navigationController?.popViewControllerAnimated(true)
            case .Failure(let error):
                print(error)
            }
        }
    }
}

extension ConfigViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else {
            return
        }
        
        switch cell.reuseIdentifier {
        case .Some("masterCode"):
            self.editText(cell.textLabel?.text, text: self.masterCode, applyHandler: { (newText) in
                self.masterCode = newText
                cell.detailTextLabel?.text = newText

                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setObject(newText, forKey: UserDefaultsKey.MasterCode.rawValue)
                userDefaults.synchronize()
            })
        case .Some("timeout"):
            let initialText: String?
            if let timeout = self.values.timeout {
                initialText = String(timeout)
            } else {
                initialText = nil
            }
            self.editText(cell.textLabel?.text, text: initialText, applyHandler: { (newText) in
                let newValue = NSTimeInterval(newText)
                self.values.timeout = newValue
                cell.detailTextLabel?.text = newValue == nil ? "..." : String(newValue!)
            })
        case .Some("appInfo"):
            self.editText(cell.textLabel?.text, text: self.values.appInfo, applyHandler: { (newText) in
                self.values.appInfo = newText
                cell.detailTextLabel?.text = newText
            })
        case .Some("networkKey"):
            self.editText(cell.textLabel?.text, text: self.values.networkKey, applyHandler: { (newText) in
                self.values.networkKey = newText
                cell.detailTextLabel?.text = newText
            })
        case .Some("ssid"):
            self.editText(cell.textLabel?.text, text: self.values.ssid, applyHandler: { (newText) in
                self.values.ssid = newText
                cell.detailTextLabel?.text = newText
            })
        case .Some("networkKeyForBridgeMode"):
            self.editText(cell.textLabel?.text, text: self.values.networkKeyForBridgeMode, applyHandler: { (newText) in
                self.values.networkKeyForBridgeMode = newText
                cell.detailTextLabel?.text = newText
            })
        case .Some("ssidForBridgeMode"):
            self.editText(cell.textLabel?.text, text: self.values.ssidForBridgeMode, applyHandler: { (newText) in
                self.values.ssidForBridgeMode = newText
                cell.detailTextLabel?.text = newText
            })
        case .Some("ciPath"):
            self.editText(cell.textLabel?.text, text: self.values.ciPath, applyHandler: { (newText) in
                self.values.ciPath = newText
                cell.detailTextLabel?.text = newText
            })
        case .Some("wlanAwakeningMode"):
            let items: [(String, WLANAwakeningMode)] = [
                ("APModeOnUnlock(0)", .APModeOnUnlock),
                ("STAModeOnUnlock(2)", .STAModeOnUnlock),
                ("BridgeModeOnUnlock(3)", .BridgeModeOnUnlock),
                ("APModeOnBoot(4)", .APModeOnBoot),
                ("STAModeOnBoot(5)", .STAModeOnBoot),
                ("BridgeModeOnBoot(6)", .BridgeModeOnBoot)
            ]
            self.chooseItem("WLAN awakening mode", items: items, applyHandler: { (item) in
                self.values.wlanAwakeningMode = item.1
                cell.detailTextLabel?.text = item.0
            })
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    private func editText(title: String?, text: String?, applyHandler: (String) -> Void) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            textField.text = text
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction) in
            guard
                let textField = alert.textFields?[0],
                let newText = textField.text
            else {
                return
            }
            applyHandler(newText)
        })
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func chooseItem<Value>(title: String?, items: [(String, Value)], applyHandler: ((String, Value)) -> Void) {
        let actionSheet = UIAlertController(title: title, message: nil, preferredStyle: .ActionSheet)

        for item in items {
            actionSheet.addAction(UIAlertAction(title: item.0, style: .Default) { (action) in
                applyHandler(item)
                })
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
}