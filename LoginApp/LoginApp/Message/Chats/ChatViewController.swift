//
//  ChatViewController.swift
//  LoginApp
//
//  Created by Nguyễn Văn Hữu on 24/12/2023.
//

import UIKit


struct ChatMessage {
    let text: String
    let isIncoming: Bool
}


class ChatViewController: UITableViewController {

    fileprivate let cellId = "id123"
    
    let chatMessages = [
        ChatMessage(text: "Here's my very first message", isIncoming: true),
        ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true),
        ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false),
        ChatMessage(text: "Yo, dawg, Whaddup!", isIncoming: false),
        ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let chatMessage = chatMessages[indexPath.row]
        
//        cell.messageLabel.text = chatMessage.text
//        cell.isIncoming = chatMessage.isIncoming
        
        cell.chatMessage = chatMessage
        
//        cell.isIncoming = indexPath.row % 2 == 0 // checks for odd/even
        
        return cell
    }

}
