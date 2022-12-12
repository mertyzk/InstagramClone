//
//  CommentViewModel.swift
//  InstagramFirebaseWork
//
//  Created by Macbook Air on 12.12.2022.
//

import UIKit

struct CommentViewModel {
    
    //MARK: - Properties
    private let comment: Comment
    
    var profileImageURL: URL? {
        return URL(string: comment.profileImageURL)
    }
    
    var username: String {
        return comment.username
    }
    
    var commentText: String {
        return comment.commentText
    }
    
    
    //MARK: - Custom Initializer
    init(comment: Comment) {
        self.comment = comment
    }
    
    
    //MARK: - Helpers
    func commentLabelText() -> NSAttributedString {
        let attributedString         = NSMutableAttributedString(string: "\(comment.username)  ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: comment.commentText, attributes: [.font : UIFont.systemFont(ofSize: 14)]))
        return attributedString
    }
    
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label           = UILabel()
        label.numberOfLines = 0
        label.text          = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
