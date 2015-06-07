//
//  ViewController.swift
//  TestingGroundForMemeMe
//
//  Created by Colin Easter on 6/5/15.
//  Copyright (c) 2015 Colin Easter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imagePickerButton: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var topTextField: UITextField!
    
    let topTextFieldWidth = 200.00
    let topTextFieldHeight = 40.00
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        topTextField = UITextField(frame: CGRect(x: 100, y: 240, width: topTextFieldWidth, height: topTextFieldHeight));
        standardizeTextFieldSettings(topTextField, aString: "TopTextField")
        self.view.addSubview(topTextField)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Occurs when the pick button in the toolbar is pressed
    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        
        // create and launch an image picker controller
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    // Called after the user picks an image in the image picker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        // set the image view's image to the image that was selected
        
        imageView.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Called after the user hits cancel in the image picker
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func takeAPhoto(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    // format the text field (white text, centered, etc) and change the text to a given string
    func standardizeTextFieldSettings(aTextField: UITextField, aString: String) {
        aTextField.delegate = memeTextFieldDelegate
        aTextField.textColor = UIColor.whiteColor()
        aTextField.text = aString
        aTextField.textAlignment = NSTextAlignment.Center
        
    
    }
    
        
}

