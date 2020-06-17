//
//  CurrencyMainPageVC.swift
//  CurrencyExTool
//
//  Created by i9400503 on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class CurrencyMainPageVC: UIViewController {


    private let viewModel : CurrencyMainPageVM

       init(viewModel : CurrencyMainPageVM) {
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
