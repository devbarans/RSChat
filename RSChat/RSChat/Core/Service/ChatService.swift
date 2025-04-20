import Foundation
import Network

// MARK: - ChatServiceProtocol
protocol ChatServiceProtocol {
    func connect()
    func sendMessage(_ message: String)
    var messageReceived: ((Message) -> Void)? {get set}
}
// MARK: - ChatService
final class ChatService {
    private var connection: NWConnection?
    private var host: NWEndpoint.Host {
        NWEndpoint.Host(Bundle.main.infoDictionary?["ServerIP"] as? String ?? {
            fatalError("ServerIP not set in Info.plist")
        }())
    }
    private let port = NWEndpoint.Port(rawValue: 8080)!
    
    var messageReceived: ((Message) -> Void)?
}

// MARK: - Implement ChatServiceProtocol
extension ChatService: ChatServiceProtocol {
    func connect() {
        connection = NWConnection(host: host, port: port, using: .tcp)
        connection?.stateUpdateHandler = { [weak self] state in
            guard let self else { return }
            switch state {
            case .ready:
                print("Connected to server")
                self.receive()
            case .failed(let error):
                print("Connection failed: \(error.localizedDescription)")
            @unknown default:
                break
            }
        }
        connection?.start(queue: .global())
    }
    
    func sendMessage(_ message: String) {
        guard let data = message.data(using: .utf8) else { return }
        connection?.send(content: data, completion: .contentProcessed { error in
            if let error {
                print("Send error: \(error)")
            }
        })
    }
}

//MARK: Private Functions
fileprivate extension ChatService{
    func receive() {
        connection?.receive(minimumIncompleteLength: 1, maximumLength: 1024) { [weak self] data, _, isComplete, error in
            guard let self else { return }
            if let error {
                print("Receive error: \(error)")
                self.connection?.cancel()
                return
            }
            
            if let data, !data.isEmpty {
                let content = String(data: data, encoding: .utf8) ?? ""
                if !content.isEmpty {
                    let message = Message(id: UUID().uuidString, content: content, isSentByUser: false)
                    self.messageReceived?(message)
                }
            }
            
            if !isComplete {
                self.receive()
            }
        }
    }
    
    func reconnect() {
        connection?.cancel()
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.connect()
        }
    }
}
