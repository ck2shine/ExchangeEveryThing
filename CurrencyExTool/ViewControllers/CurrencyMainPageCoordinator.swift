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
    case currencyRateList
}

//MARK: other ViewController back to mainPageViewController
protocol MainPageActionDelegate : class {
    func didSelectedCurrency(_ currency : String)
}

//MARK: mainPageViewController Actions to Coordinator
protocol MainPagePresentDelegate : class {
    func presentToNextVC(_ type : MainPresentingType)
}

class CurrencyMainPageCoordinator : Coordinator<UINavigationController>{
    
    var dependency : CurrencyMainDependency?
    private(set) var currencyMainPageVC :CurrencyMainPageVC?
    private(set) var viewModel : CurrencyMainPageVM?
    init(_ presenter :UINavigationController? , dependency : CurrencyMainDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
    }
    
    override func start(){
        
        let mainPageVM = CurrencyMainPageVM(taskManager: dependency!.currencyMainManager)
        self.viewModel = mainPageVM
        let mainPageVC = CurrencyMainPageVC(viewModel: mainPageVM)
        mainPageVC.delegate = self
        self.currencyMainPageVC = mainPageVC
        show(to: mainPageVC)
        super.start()
    }
}

extension CurrencyMainPageCoordinator : MainPagePresentDelegate{
    func presentToNextVC(_ type: MainPresentingType) {
        let dataDependency = CurrencyDataDependency()

        switch type {
        case .currencySelection:
            dataDependency.currencyDataManager.currencyListDatas = self.viewModel?.currencyList ?? []
            dataDependency.currencyDataManager.sendingData = self.viewModel?.currentSelectCurrency.value ?? "USD"
        case .currencyRateList:
            dataDependency.currencyDataManager.currencyListDatas = self.viewModel?.rateList ?? []
            dataDependency.currencyDataManager.sendingData = self.viewModel?.amount.value ?? "1999999"
            dataDependency.currencyDataManager.selectCurrency = self.viewModel?.currentSelectCurrency.value ?? "USD"
        }

        let dataCoordinator = CurrencyDataCoordinator(self.presenter,dependency: dataDependency)
        dataCoordinator.delegate = self
        startChildCoordinator(coordinator: dataCoordinator)
    }    
    
}

//MARK: other VC back to mainPageVC ev ent
extension CurrencyMainPageCoordinator : MainPageActionDelegate{


    func didSelectedCurrency(_ currency: String) {
        self.stopAllChildCoordinator()
        //change current currency
        self.viewModel?.inputs.replaceCurrentCurrency.value = currency
    }


}
