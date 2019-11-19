//
//  UITabBarMainController.swift
//  greenr
//
//  Created by Chloe Yan on 10/31/19.
//  Copyright © 2019 Chloe Yan. All rights reserved.
//

import UIKit

class UITabBarMainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = self.navigationController?.tabBarController?.tabBar.standardAppearance
        appearance?.shadowImage = nil
        self.navigationController?.tabBarController?.tabBar.standardAppearance = appearance!
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
