//
//  MainViewController.swift
//  Project-GIT
//
//  Created by goodmit on 2016. 7. 11..
//  Copyright © 2016년 goodmit. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var pinTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    var fileMgr: NSFileManager = NSFileManager.defaultManager()
    var docsDir: String?
    var dataFile: String?
    var key: String?
    var count = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataRead()
        
        self.updateKey()
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(MainViewController.refresh), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        if count > 0 {
            self.updateKey()
        }
        else if count == 0 {
            self.updateKey()
            count = 30
        }
    }
    
    func updateKey() {
        let secret: String = key!
        
        let secretData: NSData = NSData(base32String: secret)
        let now: NSDate = NSDate()
        let generator: TOTPGenerator = TOTPGenerator(secret: secretData, algorithm: kOTPGeneratorSHA1Algorithm, digits: 6, period: 30)
        
        let pin: String = generator.generateOTPForDate(now)
        
        pinTextLabel.text = pin
        
        let formatdate = NSDateFormatter()
        formatdate.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        timeLabel.text = formatdate.stringFromDate(now)
    }
    
    func dataRead() {
        let filemgr = NSFileManager.defaultManager()
        
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        dataFile = dirPaths[0].URLByAppendingPathComponent("datafile.dat").path
        
        if fileMgr.fileExistsAtPath(dataFile!) {
            let databuffer = fileMgr.contentsAtPath(dataFile!)
            let datastring = NSString(data: databuffer!, encoding: NSUTF8StringEncoding)
            key = datastring as? String
        }
    }
}
