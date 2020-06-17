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
        
        // Do any additional setup after loading the view.
    }
    
}

//extension CurrencyDataVC : UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//
//}
