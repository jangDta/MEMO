//
//  ViewController.swift
//  MEMO
//
//  Created by 장용범 on 17/03/2020.
//  Copyright © 2020 장용범. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    
    //Memo가 이미 있으면 편집하게, 없으면 새로 쓰게
    var alreadyMemo: Memo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAlreadyMemoAndInit()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func checkAlreadyMemoAndInit() {
        if let memo = alreadyMemo {
          navigationItem.title = "메모 편집"
          contentTextView.text = memo.content
        } else {
          navigationItem.title = "새 메모"
          contentTextView.text = ""
        }
    }

    @IBAction func save(_ sender: Any) {
        
        let memoContent = contentTextView.text
        
        if let alreadyMemo = alreadyMemo {
          alreadyMemo.content = memoContent
            CoreDataManager.shared.saveContext { success in
                if success {
                    print("편집 완료!")
                }
            }
        } else {
            CoreDataManager.shared.addMemo(content: memoContent) { success in
                if success {
                    print("새 메모 작성 완료!")
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

