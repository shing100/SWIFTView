//
//  TokenViewController.swift
//  Project-GIT
//
//  Created by goodmit on 2016. 7. 11..
//  Copyright © 2016년 goodmit. All rights reserved.
//

import UIKit

class TokenViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tokenTextField: UITextField!
    
    var fileMgr: NSFileManager = NSFileManager.defaultManager()
    var docsDir: String?
    var dataFile: String?
    
    @IBAction func saveKeyBtn(sender: UIButton) {
        if tokenTextField.text != "" {
            
            let databuffer = (tokenTextField.text)!.dataUsingEncoding(NSUTF8StringEncoding)
            
            fileMgr.createFileAtPath(dataFile!, contents: databuffer, attributes: nil)
            
            let alert = UIAlertController(title: "Save OK!", message: "Your secret key saved", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK!", style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Empty!", message: "please input your secret key", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK!", style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let filemgr = NSFileManager.defaultManager()
        
        let dirPaths = filemgr.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        dataFile = dirPaths[0].URLByAppendingPathComponent("datafile.dat").path
        
        self.tokenTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }

}
