//
//  ViewController.swift
//  TestingGroundForMemeMe
//
//  Created by Colin Easter on 6/5/15.
//  Copyright (c) 2015 Colin Easter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imagePickerButton: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        
        let pickerController = UIImagePickerController()
        self.presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
}

