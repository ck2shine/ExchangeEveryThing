//
//  CurrencySelectCoordinator.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit

//MARK: CurrencyData Actions to Coordinator
protocol CurrencyDataPresentDelegate : class {
    func didSelectCurrencyType(type : String)
    func popWithoutAnyMove()
}
class CurrencyDataCoordinator : Coordinator<UINavigationController>{
    
    var dependency : CurrencyDataDependency?

    weak final var delegate : MainPageActionDelegate?

    private(set) var currenyDataVC :CurrencyDataVC?
    init(_ presenter :UINavigationController? , dependency : CurrencyDataDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
    }
    
    override func start(){
        
        let dataVM = CurrencyDataVM(taskManager: dependency!.currencyDataManager)
        let dataVC = CurrencyDataVC(viewModel: dataVM)
        dataVC.delegate = self
        self.currenyDataVC = dataVC
        show(to: dataVC)
        super.start()
    }
}
extension CurrencyDataCoordinator : CurrencyDataPresentDelegate{
    func popWithoutAnyMove() {
         self.presenter?.popViewController(animated: true)
        self.delegate?.stopAllCoordinatorFromChild()
    }

    func didSelectCurrencyType(type: String) {
        self.presenter?.popViewController(animated: true)
        self.delegate?.didSelectedCurrency(type)
    }
}
