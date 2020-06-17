//
//  CurrencyMainPageCoordinator.swift
//  CurrencyExTool
//
//  Created by i9400503 on 2020/6/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit

enum MainPresentingType {
    case currencySelection 
    case currencyRateList(String)
}

protocol MainPagePresentDelegate : class {
    func presentToNextVC(_ type : MainPresentingType)
}

class CurrencyMainPageCoordinator : Coordinator<UINavigationController>{
    
    var dependency : CurrencyMainDependency?
    private(set) var currencyMainPageVC :CurrencyMainPageVC?
    init(_ presenter :UINavigationController? , dependency : CurrencyMainDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
    }
    
    override func start(){
        
        let mainPageVM = CurrencyMainPageVM(taskManager: dependency!.currencyMainManager)
        let mainPageVC = CurrencyMainPageVC(viewModel: mainPageVM)
        mainPageVC.delegate = self
        self.currencyMainPageVC = mainPageVC
        show(to: mainPageVC)
        super.start()
    }
}

extension CurrencyMainPageCoordinator : MainPagePresentDelegate{
    func presentToNextVC(_ type: MainPresentingType) {
        
    }    
    
}
