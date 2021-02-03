//
//  ViewController.swift
//  ndvhssahoolat
//
//  Created by MIS on 03/02/2021.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource{

    @IBOutlet var table:UITableView!
    let data=["First","Second","Third","Fourth"]
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource=self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath)
        cell.textLabel?.text=data[indexPath.row]
        return cell
    }

}

