//
//  CurrencyMainPageVC.swift
//  CurrencyExTool
//
//  Created by i9400503 on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class CurrencyMainPageVC: UIViewController {


    weak final var delegate : MainPagePresentDelegate?
    
    private let viewModel : CurrencyMainPageVM

    @IBOutlet weak var CurrencyButton: UIButton!
    @IBOutlet weak var AmountLabel: UILabel!
    init(viewModel : CurrencyMainPageVM) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIs()
        bindingUIs()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //start fetching
        self.viewModel.inputs.timeCheckTrigger.value = ()
    }

    @IBAction func convertCurButtonAction(_ sender: Any) {
        self.delegate?.presentToNextVC(.currencyRateList)
    }
    @IBAction func baseCurSelectButtonAction(_ sender: Any) {
        self.delegate?.presentToNextVC(.currencySelection)
    }
    @IBAction func NumberPadAction(_ sender: UIButton) {
        self.viewModel.inputs.addNumberToPad.value = sender.titleLabel?.text
    }

}

extension CurrencyMainPageVC{

    final private func bindingUIs(){

        let output = self.viewModel.outputs

        output.loadingHudDisplay.binding(trigger: false) { [unowned self ] message in
            DispatchQueue.main.async {
                if let message = message {
                    let msg : (title : String , infoMessage : String) = message
                    self.showHud(msg.title, message: msg.infoMessage)
                }
                else{
                    self.hideHud()
                }
            }
        }

        output.amount.binding { [unowned self ] amount in
            DispatchQueue.main.async {
                self.AmountLabel.text = amount
            }
        }

        output.currentSelectCurrency.binding(trigger: false) { [unowned self ] currency in
            DispatchQueue.main.async {
                self.CurrencyButton.setTitle(currency, for: .normal)
            }
        }
    }

    final private func setupUIs(){
        //navigation Title
        self.title = "Currency Caculator"

        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshFetchData(_:)))

        navigationItem.rightBarButtonItem = refresh
    }

}

//MARK: navigationBar item Actions
extension CurrencyMainPageVC{
    @objc final private func refreshFetchData(_ sender : UIBarButtonItem){
         self.viewModel.inputs.timeCheckTrigger.value = ()
    }
}
