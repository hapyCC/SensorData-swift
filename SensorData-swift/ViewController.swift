//
//  ViewController.swift
//  SensorData-swift
//
//  Created by Apple on 11/2/22.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        

        UIApplication.swizzleMethod()
//        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        btn.backgroundColor = .red
//        view.addSubview(btn)
//        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        
        

        let table = UITableView(frame: view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: view.bounds.size.width, height: 100)
//    
//        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
//        view.addSubview(collectionView)
        
//        NSObject.load()
        
//        let longGes = UILongPressGestureRecognizer(target: self, action: #selector(longGesAction(_:)))
//        view.addGestureRecognizer(longGes)
//
//        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapGesAction(_:)))
//        view.addGestureRecognizer(tapGes)
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    @objc func longGesAction(_ ges: UILongPressGestureRecognizer) {
        print("longGesAction")
    }
    
    @objc func tapGesAction(_ tapGes: UITapGestureRecognizer) {
        print("tapGesAction")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchbegan")
    }
    
    
    @objc func btnClick(btn: UIButton) {
        print("btnClick")
    }
}



extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        cell?.textLabel?.text = String().appendingFormat("indexRow:-%d", indexPath.row)
        let btn = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        btn.backgroundColor = .brown
        cell?.contentView.addSubview(btn)
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        let cell = tableView.cellForRow(at: indexPath)
        print("cell.elementType:" + cell!.elementType as String + "---cell.elementContent:", cell?.elementContent as Any, cell?.elementViewController as Any)
    }
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView-->didSelectItemAt")
    }
}
