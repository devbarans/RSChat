import UIKit

final class ChatViewController: UIViewController {
    // MARK: - Properties
    private let chatView = ChatView()
    private var viewModel: ChatViewModel?
    
    // MARK: - İnitialization
    init(viewModel: ChatViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chatView.frame = view.bounds
    }
    
    private func setup() {
        view.addSubview(chatView)
        chatView.tableView.delegate = self
        chatView.tableView.dataSource = self
        chatView.delegate = self
        viewModel?.delegate = self
    }
    
    private func scrollToBottom() {
        guard let messages = self.viewModel?.messages, !messages.isEmpty else { return }
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        self.chatView.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

// MARK: - ChatViewControllerDelegate
extension ChatViewController: ChatViewControllerDelegate {
    func didMessagesUpdated() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.chatView.tableView.reloadData()
            self.scrollToBottom()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.messages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.reuseID, for: indexPath) as? ChatMessageCell,
              let message = viewModel?.messages[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(with: message)
        return cell
    }
}

// MARK: - ChatViewDelegate
extension ChatViewController: ChatViewDelegate {
    func sentMessage(_ message: String) {
        guard !message.isEmpty else { return }
        viewModel?.sendMessage(message)
    }
}

// MARK: - Preview
#Preview {
    ChatBuilder.build()
}
