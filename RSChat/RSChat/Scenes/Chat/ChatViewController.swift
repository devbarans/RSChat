//
//  ChatViewController.swift
//  RSChat
//
//  Created by Baran Baran on 13.04.2025.
//

import UIKit

final class ChatViewController: UIViewController {
    
    // MARK: - Properties (Test)
    let messagesArray: [Message] = [
        Message(id: UUID().uuidString, content: "Heyy swift", isSentByUser: false),
        Message(id: UUID().uuidString, content: "Hello rust", isSentByUser: true),
    
    ]
    
    //MARK: Dependencies
    private let chatView = ChatView()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chatView.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setup(){
        view.addSubview(chatView)
        
        chatView.tableView.delegate = self
        chatView.tableView.dataSource = self
        
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatMessageCell.reuseID) as? ChatMessageCell
        else { return UITableViewCell() }

        cell.configure(with: messagesArray[indexPath.row])
        return cell
    }
    
}

// MARK: - Preview
#Preview {
    ChatBuilder.build()
}
