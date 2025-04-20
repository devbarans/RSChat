//
//  ChatMessageCell.swift
//  RSChat
//
//  Created by Baran Baran on 13.04.2025.
//

import UIKit
import SnapKit

final class ChatMessageCell: UITableViewCell {
    // MARK: - Properties
    static let reuseID = "ChatMessageCell"
    
    // MARK: - UI Elements
    private lazy var bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension ChatMessageCell {
    func setup() {
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        selectionStyle = .none
        backgroundColor = .clear
    }
}

// MARK: - Layout
private extension ChatMessageCell {
    func layout() {
        bubbleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.greaterThanOrEqualToSuperview().inset(16)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
            make.bottom.equalTo(messageLabel.snp.bottom).offset(8)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(bubbleView).inset(8)
            make.leading.equalTo(bubbleView).inset(12)
            make.trailing.equalTo(bubbleView).inset(12)
        }
    }
}

// MARK: - Configuration
extension ChatMessageCell {
    public func configure(with message: Message) {
        messageLabel.text = message.content
        bubbleView.backgroundColor = message.isSentByUser ? .systemBlue : .systemGray6
        messageLabel.textColor = message.isSentByUser ? .white : .label
        
        bubbleView.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(8)
            if message.isSentByUser {
                make.leading.greaterThanOrEqualToSuperview().inset(100)
                make.trailing.equalToSuperview().inset(16)
            } else {
                make.leading.equalToSuperview().inset(16)
                make.trailing.lessThanOrEqualToSuperview().inset(100)
            }
            make.bottom.equalTo(messageLabel.snp.bottom).offset(8)
        }

        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - Preview
#Preview {
    ChatBuilder.build()
}


