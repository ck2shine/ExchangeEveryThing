//
//  CurrencyCell.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class CurrencySelectCell: UITableViewCell ,CellSettingProtocol {
    @IBOutlet weak var CurFullNameLabel: UILabel!

    @IBOutlet weak var CurShorNameLabel: UILabel!
    
    var viewModel : CurrencySelectVM?


    private lazy var selectedBackGroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    func setupCell(_ viewModel: CurrencyRowType) {
        if let viewModel = viewModel as? CurrencySelectVM {
            self.viewModel = viewModel
        }

        bindUIs()

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = selectedBackGroundView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    final private func bindUIs(){
        //remove first, because if reuse cells
        removeAllbindins()

        self.viewModel?.curFullName.binding(listener: { [unowned self]text in

            self.CurFullNameLabel.text = text

        })
        self.viewModel?.curShortName.binding(listener: { [unowned self]text in

            self.CurShorNameLabel.text = text

        })
    }

    final private func removeAllbindins(){
        self.viewModel?.curFullName.removeAllBinding()
        self.viewModel?.curShortName.removeAllBinding()
    }
    
}
