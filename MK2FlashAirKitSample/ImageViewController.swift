//
//  ImageViewController.swift
//  MK2FlashAirKit
//
//  Created by k2o on 2016/06/18.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageViewController: UIViewController {
    var imageURL: NSURL!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        self.imageView.af_setImageWithURL(self.imageURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
