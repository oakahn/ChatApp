//
//  ViewController.swift
//  ChatApp
//
//  Created by chayarak on 25/5/2561 BE.
//  Copyright © 2561 chayarak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var listItem = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"]
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
        sendButton.addTarget(self, action: #selector(send), for: .touchUpInside)
    }
    
    @objc func send() {
        listItem.append(sendText.text ?? "")
        sendText.text = ""
        chatTableView.reloadData()
        getLastChat()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        chatTableView.frame =  CGRect(x: 0,
                                      y: 0,
                                      width: view.frame.width,
                                      height: view.frame.height - keyboardSize.height - 70)
        viewBar.frame.origin.y = view.frame.maxY - keyboardSize.height - 50
        getLastChat()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        chatTableView.frame =  CGRect(x: 0,
                                      y: 0,
                                      width: view.frame.width,
                                      height: view.frame.height - 70)
        viewBar.frame.origin.y = view.frame.maxY - 50
    }
    
    func getLastChat() {
        let lastSectionIndex = chatTableView.numberOfSections - 1
        let lastRowIndex = chatTableView.numberOfRows(inSection: lastSectionIndex) - 1
        let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
        chatTableView?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableViewScrollPosition.none, animated: true)
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
}
