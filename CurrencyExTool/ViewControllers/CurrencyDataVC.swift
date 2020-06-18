//
//  CurrencySelectVC.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class CurrencyDataVC: UIViewController {
    
    @IBOutlet weak var CurrencyAmountLabel: UILabel!
    @IBOutlet weak var DataTableView: UITableView!
    

    weak final var delegate : CurrencyDataPresentDelegate?

    private let viewModel : CurrencyDataVM
    
    init(viewModel : CurrencyDataVM) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIs()
        bindUIs()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.tableDataTrigger.value = true

    }
    @objc func back(_ sender : UIBarButtonItem){
        self.delegate?.popWithoutAnyMove()
    }
}

extension CurrencyDataVC{
    final private func setupUIs(){
        //setup tableview
        self.DataTableView.dataSource = self
        self.DataTableView.delegate = self
        self.DataTableView.estimatedRowHeight = 150

        //register cells
        let currencySelectName =  String(describing: CurrencySelectCell.self)

        self.DataTableView.register(UINib(nibName:currencySelectName, bundle: Bundle(for: Self.self)), forCellReuseIdentifier: currencySelectName)

        let currencyRateName =  String(describing: CurrencyRateCell.self)

        self.DataTableView.register(UINib(nibName:currencyRateName, bundle: Bundle(for: Self.self)), forCellReuseIdentifier: currencyRateName)

        //navigation bar title
        navigationItem.title = "Currency Data"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back(_:)))


    }

    final private func bindUIs(){
        let output = self.viewModel.outputs

        output.dataList.binding { [unowned self] dataList in
            DispatchQueue.main.async {
                self.DataTableView.reloadData()
            }
        }

        output.infoText.binding {[unowned self] text in
            DispatchQueue.main.async {
                self.CurrencyAmountLabel.text = text
            }
        }

        output.selectedCurrency.binding(trigger: false) {[unowned self] currency in
            self.delegate?.didSelectCurrencyType(type: currency ?? "")
        }

    }
}

extension CurrencyDataVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataList.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let dataList = self.viewModel.dataList.value ?? []

        let rowViewModel = dataList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: self.viewModel.cellIndentify(rowViewModel) , for: indexPath)

        if let cell = cell as? CellSettingProtocol {
            cell.setupCell(rowViewModel)
        }

        return cell
    }


}


extension CurrencyDataVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = self.viewModel.dataList.value?[indexPath.row] as? CellIsAbleToPress{
            viewModel.pressAction?()
        }

    }
}
