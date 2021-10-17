//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Сергей Кривошапко on 15.06.2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    deinit {
        print("ChatViewController was deinit")
    }
    
    //инициализация экземпляра Cloud Firestore
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        //В структуре К хранятся значения констант (чтобы код был более читабельным)
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessage()
    }
    
    func loadMessage() {
        
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let e = error {
                print(e)
            } else {
                if let snapshopDocuments = querySnapshot?.documents {
                    for doc in snapshopDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                //Реализация скрола NableView в самый низ, когда в массив добавляется сообщение
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        //Если пользователь ввел какой-то текст и он авторизован, то в data base добавляюся данные о пользователе, времени отправки и текст сообщения) 
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender,
                                                                      K.FStore.bodyField: messageBody,
                                                                      K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.messageTextfield.text = nil
                        print("Sucsses")
                    }
                    
                    
                }
            }
        }
    }
    
    //Метод выхода пользователя
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.sender = message.sender
        cell.lable.text = message.body
        return cell
    }
}


