//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Сергей Кривошапко on 15.06.2021.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    deinit {
        print("WelcomeViewController was deinit")
    }

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        // В документации сказано, что если мы вызываем эту ф-ию, мы должны вызвать метод суперкласса ( If you override this method, you must call super at some point in your implementation.)
        //В общем, мы должны всегда вызвать ф-ию super, когда переопределяем ф-ию супер класса
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        titleLabel.charInterval = 1
    
        
        }
    }
