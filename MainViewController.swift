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
    @IBOutlet weak var expiryLabel: UILabel!

    var fileMgr: NSFileManager = NSFileManager.defaultManager()
    var docsDir: String?
    var dataFile: String?
    var key: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 201.0/255.0, green: 217.0/255.0, blue: 224.0/255.0, alpha: 1)
        
        self.dataRead()
        self.updateKey()
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(MainViewController.updateKey), userInfo: nil, repeats: true)
        
        expiryLabel.text = "Key change time 30s, 60s"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateKey() {
        let secret: String = key
        
        let secretData: NSData = NSData(base32String: secret)
        
        let now: NSDate = NSDate()
       
        let generator: TOTPGenerator = TOTPGenerator(secret: secretData, algorithm: kOTPGeneratorSHA1Algorithm, digits: 6, period: 30)
        
        let pin: String = generator.generateOTPForDate(now)
        
        pinTextLabel.text = pin
        
        let formatdate = NSDateFormatter()
        
        formatdate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        timeLabel.text = formatdate.stringFromDate(now)
    }
    
    func dataRead() {
        let filemgr = NSFileManager.defaultManager()
        
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        dataFile = dirPaths[0].URLByAppendingPathComponent("datafile.dat").path
        
        if fileMgr.fileExistsAtPath(dataFile!) {
            let databuffer = fileMgr.contentsAtPath(dataFile!)
            let datastring = NSString(data: databuffer!, encoding: NSUTF8StringEncoding)
            key = (datastring as? String)!
        }
    }
}
