//
//  ChatView.swift
//  RSChat
//
//  Created by Baran Baran on 13.04.2025.
//

import UIKit
import SnapKit

final class ChatView: UIView {
    // MARK: - UI Elements
    private(set) lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.allowsSelection = false
        table.rowHeight = UITableView.automaticDimension
        table.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.reuseID)
        return table
        
    }()
    
    private lazy var sentButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.right.circle"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 16
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.backgroundColor = .white
        textView.textColor = .lightGray
        textView.isScrollEnabled = false
        textView.text = "Type your message..."
        return textView
    }()
    
    private lazy var inputStackView: UIStackView = {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        spacer.widthAnchor.constraint(equalToConstant: 8).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [spacer,textView,sentButton])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .systemGray6
        return stack
    }()
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Setup
private extension ChatView {
    func setup(){
        addSubview(tableView)
        addSubview(inputStackView)
    }
}

// MARK: - Layout
private extension ChatView {
    func layout(){
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(safeAreaLayoutGuide)
            make.bottomMargin.equalTo(inputStackView.snp.top)
        }
        
        inputStackView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(50)
        }
        
        textView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(30)
            make.width.greaterThanOrEqualTo(100)
        }
        
        sentButton.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        
    }
}

// MARK: - Preview
#Preview {
    ChatBuilder.build()
}

