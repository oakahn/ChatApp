//
//  ViewController.swift
//  ChatApp
//
//  Created by chayarak on 25/5/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var listItem = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var sendText: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var listChatView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        sendText.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        listChatView.frame =  CGRect(x: 0,
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height - keyboardSize.height - 200)
        
        chatTableView.frame =  CGRect(x: 0,
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height - keyboardSize.height - 200)
        
        viewBar.frame.origin.y = view.frame.maxY - keyboardSize.height - 50
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        listChatView.frame =  CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height)
        chatTableView.frame =  CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height)
        viewBar.frame.origin.y = view.frame.maxY - 50
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listItem[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendMessage((Any).self)
    }
}
