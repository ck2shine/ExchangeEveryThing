//
//  CurrencyRateCell.swift
//  CurrencyExTool
//
//  Created by Shine on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class CurrencyRateCell: UITableViewCell , CellSettingProtocol {

    @IBOutlet weak var CurrenyNameLabel: UILabel!
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var RateLabel: UILabel!

    var viewModel : CurrencyRateVM?

    func setupCell(_ viewModel: CurrencyRowType) {

        if let viewModel = viewModel as? CurrencyRateVM {
            self.viewModel = viewModel
        }

        bindUIs()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    final private func bindUIs(){
        //remove first, because if reuse cells
        removeAllbindins()
        guard let viewModel = self.viewModel else {
            return
        }
        viewModel.currenyName.binding(listener: { [unowned self]text in
            self.CurrenyNameLabel.text = text
        })
        
        viewModel.amount.binding(listener: { [unowned self]text in
            self.AmountLabel.text = text
        })

        viewModel.rate.binding(listener: { [unowned self]text in
            self.RateLabel.text = text
        })
    }

    final private func removeAllbindins(){
        guard let viewModel = viewModel else {
            return
        }
        viewModel.currenyName.removeAllBinding()
        viewModel.amount.removeAllBinding()
        viewModel.rate.removeAllBinding()
    }

    
}


