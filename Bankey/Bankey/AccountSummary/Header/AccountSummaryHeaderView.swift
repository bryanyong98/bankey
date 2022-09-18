//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Bryan Yong on 11/09/2022.
//

import Foundation
import UIKit

class AccountSummaryHeaderView : UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    let viewShakeyBell = ShakeyBellView()
    
    struct ViewModel {
        let welcomeMessage : String
        let name : String
        let date : Date
        
        var dateFormatted : String {
            return date.monthDayYearString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // set a default size
    // width: don't care
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit(){
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        setupShakeyBell()
    }
    
    private func setupShakeyBell(){
        viewShakeyBell.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewShakeyBell)
        
        NSLayoutConstraint.activate([
            viewShakeyBell.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewShakeyBell.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    func configure(viewModel : ViewModel){
        lblWelcome.text = viewModel.welcomeMessage
        lblName.text    = viewModel.name
        lblDate.text    = viewModel.dateFormatted
    }
}
