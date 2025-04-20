import Foundation
// MARK: - ChatViewControllerDelegate
protocol ChatViewControllerDelegate: AnyObject {
    func didMessagesUpdated()
}

// MARK: - ChatViewModel
final class ChatViewModel {
    weak var delegate: ChatViewControllerDelegate?
    
    // MARK: - Properties
    private(set) lazy var messages: [Message] = []
    private var service: ChatServiceProtocol
        
    // MARK: - Initialization
    init(service: ChatServiceProtocol) {
        self.service = service
        setupService()
    }
    
    // MARK: - Private Methods
    
    private func setupService() {
        service.messageReceived = { [weak self] message in
            guard let self = self else { return }
            self.messages.append(message)
            delegate?.didMessagesUpdated()
        }
        service.connect()
    }
    
    // MARK: - Public Methods
    public func sendMessage(_ message: String) {
        let sentMessage = Message(id: UUID().uuidString, content: message, isSentByUser: true)
        messages.append(sentMessage)
        service.sendMessage(message)
        delegate?.didMessagesUpdated()
    }
}
