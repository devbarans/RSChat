//
//  ChatView.swift
//  RSChat
//
//  Created by Baran Baran on 13.04.2025.
//

import UIKit
import SnapKit

// MARK: - ChatViewDelegate
protocol ChatViewDelegate: AnyObject {
    func sentMessage(_ message: String)
}

// MARK: - ChatView
final class ChatView: UIView {
    
    // MARK:  Properties
    weak var delegate: ChatViewDelegate?
    
    // MARK:  UI Elements
    private(set) lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.allowsSelection = false
        table.estimatedRowHeight = 60
        table.rowHeight = UITableView.automaticDimension
        table.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.reuseID)
        return table
        
    }()
    
    private(set) lazy var sentButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.right.circle"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 28
        button.setPreferredSymbolConfiguration(.init(pointSize: 26, weight: .medium), forImageIn: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(sentMessage), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 16
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.backgroundColor = UIColor.systemBackground
        textView.textColor = .label
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1
        return textView
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textView,sentButton])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .systemGray6
        stack.layer.cornerRadius = 16
        stack.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 12)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOpacity = 0.2
        stack.layer.shadowOffset = CGSize(width: 0, height: -1)
        stack.layer.shadowRadius = 3
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
            make.width.height.equalTo(56)
        }
        
        
    }
}

// MARK: - Actions
fileprivate extension ChatView {
    @objc func sentMessage(){
        guard let delegate = delegate else { return }
        delegate.sentMessage(textView.text)
        textView.text = ""
    }
}

// MARK: - Preview
#Preview {
    ChatBuilder.build()
}

