//
//  ChatBuilder.swift
//  RSChat
//
//  Created by Baran Baran on 13.04.2025.
//

import Foundation

enum ChatBuilder {
    static func build() -> ChatViewController {
        let service = ChatService()
        let viewModel = ChatViewModel(service: service)
        let vc = ChatViewController(viewModel: viewModel)
        return vc
    }
}
