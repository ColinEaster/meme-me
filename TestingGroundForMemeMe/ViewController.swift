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
    
    @IBOutlet weak var imagePickerButton: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIButton!
    
    var topTextField: UITextField!
    var bottomTextField: UITextField!
    var chosenImage: UIImageView!
    
    let topTextFieldWidth = 300.00
    let topTextFieldHeight = 45.00
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    
    var meme: Meme!
    //var memedImage: UIImage!
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //chosenImage = UIImageView(frame: CGRect(x: 100, y: 0, width: 90, height: 160))
        shareButton.enabled = false
        chosenImage = UIImageView(frame: view.bounds)
        chosenImage.contentMode = .ScaleAspectFit
        self.view.addSubview(chosenImage)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.unsubscribeFromKeyboardNotifications()

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
        
        
        chosenImage.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // add top text field
        topTextField = UITextField(frame: CGRect(x: 40, y: 240, width: topTextFieldWidth, height: topTextFieldHeight))
        standardizeTextFieldSettings(topTextField, aString: "TopText")
        self.view.addSubview(topTextField)
        
        // add bottom text field
        bottomTextField = UITextField(frame: CGRect(x: 40, y: 370, width: topTextFieldWidth, height: topTextFieldHeight))
        standardizeTextFieldSettings(bottomTextField, aString: "BottomText")
        self.view.addSubview(bottomTextField)
        
        shareButton.enabled = true
        println(" \(shareButton.enabled)")
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
        
        // settings dictionary
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2.0
        ]
        aTextField.defaultTextAttributes = memeTextAttributes
        // other stuff
        
        aTextField.text = aString
        aTextField.textAlignment = NSTextAlignment.Center
        aTextField.delegate = memeTextFieldDelegate
        
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    func saveMeme() {
        let memedImage = generateMemedImage()
        meme = Meme(textFromTop: topTextField.text, textFromBottom: bottomTextField.text, originalImage: chosenImage.image!, memedImage: memedImage)
    }
    // saves the picture with text
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        toolBar.hidden = true
        shareButton.hidden = true
        //navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memeImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        toolBar.hidden = false
        shareButton.hidden = false
        return memeImage
    }
    @IBAction func shareButtonPressed(sender: UIButton) {
        saveMeme()
        let activityController = UIActivityViewController(activityItems: [meme.memedImage!], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
    }
}

