//
//  ListViewController.swift
//  Tinder
//
//  Created by MASAMUNE on 2021/02/22.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    var likename = [String]()

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(likename)
        tableview.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likename.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = likename[indexPath.row]
        return cell
    }
}
