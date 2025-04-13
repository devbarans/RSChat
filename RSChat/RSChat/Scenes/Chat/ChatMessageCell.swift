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
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Hellloooo"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    
    // MARK: - İnitialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup & Layout
private extension ChatMessageCell {
     func setup(){
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        
        selectionStyle = .none
    }
    
     func layout(){
        bubbleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(16)
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

// MARK: - Preview
#Preview {
    ChatBuilder.build()
}
