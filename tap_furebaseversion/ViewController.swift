//
//  ViewController.swift
//  renda
//
//  Created by Atsuhiro Muroyama on 2022/08/27.
//

import UIKit
import Firebase
import FirebaseFirestore
class ViewController: UIViewController {
    var num: Int! = 0
    let firestore = Firestore.firestore()
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.layer.cornerRadius = 100
        
        firestore.collection("counts").document("share").addSnapshotListener { snapshot, error in
                    if error != nil {
                        print("エラーが発生しました")
                        print(error)
                        return
                    }
                    let data = snapshot?.data()
                    if data == nil {
                        print("データがありません")
                        return
                    }
                    let count = data!["count"] as? Int
                    if count == nil {
                        print("countという対応する値がありません")
                        return
                    }
                    self.num = count!
                    self.label.text = String(count!)
                }
        
    }
    @IBAction func plus(_ sender: Any) {
        num += 1
        label.text = String(num)
        firestore.collection("counts").document("share").setData(["count": num])
        
    }
    

}

