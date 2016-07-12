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

    var fileMgr: NSFileManager = NSFileManager.defaultManager()
    var docsDir: String?
    var dataFile: String?
    var key: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let filemgr = NSFileManager.defaultManager()
        
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        dataFile = dirPaths[0].URLByAppendingPathComponent("datafile.dat").path
        
        if fileMgr.fileExistsAtPath(dataFile!) {
            let databuffer = fileMgr.contentsAtPath(dataFile!)
            let datastring = NSString(data: databuffer!, encoding: NSUTF8StringEncoding)
            key = datastring as? String
        }
        let secret: String = key!
        
        let secretData: NSData = NSData(base32String: secret)
        let now: NSDate = NSDate()
        let generator: TOTPGenerator = TOTPGenerator(secret: secretData, algorithm: kOTPGeneratorSHA1Algorithm, digits: 6, period: 30)

        let pin: String = generator.generateOTPForDate(now)
        
        pinTextLabel.text = pin
        
        
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
