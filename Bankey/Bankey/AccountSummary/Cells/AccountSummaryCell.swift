//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Bryan Yong on 11/09/2022.
//

import Foundation
import UIKit

class AccountSummaryCell: UITableViewCell {
    
    let lblType = UILabel()
    let lblName = UILabel()
    let viewUnderline = UIView()
    
    let stackViewBalance = UIStackView()
    let lblBalance = UILabel()
    let lblBalanceAmount = UILabel()
    
    let imgViewChevron = UIImageView()
    
    static let reuseId = "AccountSummaryCell"
    static let rowHeight : CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


extension AccountSummaryCell {
    private func setup(){
        lblType.translatesAutoresizingMaskIntoConstraints = false
        lblType.font = UIFont.preferredFont(forTextStyle: .caption1)
        lblType.adjustsFontForContentSizeCategory = true
        lblType.text = "Account type"
        
        viewUnderline.translatesAutoresizingMaskIntoConstraints = false
        viewUnderline.backgroundColor = appColor
        
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.font = UIFont.preferredFont(forTextStyle: .body)
        lblName.adjustsFontForContentSizeCategory = true
        lblName.text = "Account Name"
    
        stackViewBalance.translatesAutoresizingMaskIntoConstraints = false
        stackViewBalance.axis = .vertical
        stackViewBalance.spacing = 0
        
        lblBalance.translatesAutoresizingMaskIntoConstraints = false
        lblBalance.font = UIFont.preferredFont(forTextStyle: .body)
        lblBalance.textAlignment = .right
        lblBalance.text = "Some balance"
        
        lblBalanceAmount.translatesAutoresizingMaskIntoConstraints = false
        lblBalanceAmount.textAlignment = .right
        lblBalanceAmount.attributedText = makeFormattedBalance(dollars: "929,466", cents: "63")

        
        imgViewChevron.translatesAutoresizingMaskIntoConstraints = false
        let imgChevron = UIImage(systemName: "chevron.right")?.withTintColor(appColor, renderingMode: .alwaysOriginal)
        imgViewChevron.image = imgChevron
        
        contentView.addSubview(lblType)
        contentView.addSubview(viewUnderline)
        contentView.addSubview(lblName)
        contentView.addSubview(imgViewChevron)
        
        stackViewBalance.addArrangedSubview(lblBalance)
        stackViewBalance.addArrangedSubview(lblBalanceAmount)
        contentView.addSubview(stackViewBalance)
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            lblType.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            lblType.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            viewUnderline.topAnchor.constraint(equalToSystemSpacingBelow: lblType.bottomAnchor, multiplier: 1),
            viewUnderline.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            viewUnderline.widthAnchor.constraint(equalToConstant: 60),
            viewUnderline.heightAnchor.constraint(equalToConstant: 4),
            
            lblName.topAnchor.constraint(equalToSystemSpacingBelow: viewUnderline.bottomAnchor, multiplier: 2),
            lblName.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            stackViewBalance.topAnchor.constraint(equalToSystemSpacingBelow: viewUnderline.bottomAnchor, multiplier: 0),
            stackViewBalance.leadingAnchor.constraint(equalTo: lblName.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackViewBalance.trailingAnchor, multiplier: 4),
            
            imgViewChevron.topAnchor.constraint(equalToSystemSpacingBelow: viewUnderline.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: imgViewChevron.trailingAnchor, multiplier: 1),

        ])
    }
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}
