//
//  CurrencySelectCoordinator.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit
class CurrencySelectCoordinator : Coordinator<UINavigationController>{
    
    var dependency : CurrencyDataDependency?
    private(set) var currenyDataVC :CurrencyDataVC?
    init(_ presenter :UINavigationController? ) {
        super.init(presenter: presenter)
    }
    
    override func start(){
        
        let dataVM = CurrencyDataVM(taskManager: dependency!.currencyDataManager)
        let dataVC = CurrencyDataVC(viewModel: dataVM)
        self.currenyDataVC = dataVC
        show(to: dataVC)
        super.start()
    }
}
