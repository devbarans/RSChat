//
//  ChatViewController.swift
//  RSChat
//
//  Created by Baran Baran on 13.04.2025.
//

import UIKit

final class ChatViewController: UIViewController {
    
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
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.reuseID) as? ChatMessageCell else { return UITableViewCell() }
        return cell
    }
    
}

// MARK: - Preview
#Preview {
    ChatBuilder.build()
}
