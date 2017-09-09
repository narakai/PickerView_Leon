//
//  ViewController.swift
//  PickerView_Leon
//
//  Created by lai leon on 2017/9/9.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

let YHRect = UIScreen.main.bounds
let YHHeight = YHRect.size.height
let YHWidth = YHRect.size.width

let PickerViewRect = CGRect(x: 0, y: YHHeight / 3, width: YHWidth, height: YHHeight / 3)
let LabelRect = CGRect(x: 0, y: 20, width: YHWidth, height: YHHeight / 3 - 20)
let BtnRect = CGRect(x: 40, y: PickerViewRect.origin.y + PickerViewRect.size.height + 30, width: YHWidth - 80, height: 30)

class ViewController: UIViewController {

    let pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: PickerViewRect)
        pickerView.selectRow(0, inComponent: 0, animated: true)
        return pickerView
    }()

    let showLabel: UILabel = {
        let showLabel = UILabel(frame: LabelRect)
        showLabel.textColor = .orange
        showLabel.textAlignment = .center
        showLabel.font = UIFont.systemFont(ofSize: 30, weight: 5)
        return showLabel
    }()

    let btn: UIButton = {
        let btn = UIButton(frame: BtnRect)
        btn.setTitle("随机选择", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: 5)
        btn.addTarget(self, action: #selector(randomTime), for: .touchUpInside)
        return btn
    }()

    let hours = 0...23
    let mins = 0...59
    let secs = 0...59


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changLabelTiel()
    }

    private func setupView() {
        view.backgroundColor = .white
        pickerView.delegate = self
        pickerView.dataSource = self

        view.addSubview(pickerView)
        view.addSubview(showLabel)
        view.addSubview(btn)
    }

    func randomTime() {
        pickerView.selectRow(Int(arc4random()) % hours.count, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random()) % mins.count, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random()) % secs.count, inComponent: 2, animated: true)
        changLabelTiel()
    }

    func changLabelTiel() {
        showLabel.text = "\(pickerView.selectedRow(inComponent: 0))时 \(pickerView.selectedRow(inComponent: 1))分 \(pickerView.selectedRow(inComponent: 2))秒"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return YHWidth / 3
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }

    //系统默认样式
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(Array(hours)[row]) + "时"
        case 1:
            return String(Array(mins)[row]) + "分"
        default:
            return String(Array(secs)[row]) + "秒"
        }
    }

    //自定义cell
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        switch component {
        case 0:
            pickerLabel.text = String(Array(hours)[row]) + "H"
        case 1:
            pickerLabel.text = String(Array(mins)[row]) + "M"
        default:
            pickerLabel.text = String(Array(secs)[row]) + "S"
        }

        pickerLabel.textColor = .orange
        pickerLabel.font = UIFont.systemFont(ofSize: 18, weight: 5)
        pickerLabel.textAlignment = .center

        return pickerLabel
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changLabelTiel()
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return mins.count
        default:
            return secs.count
        }
    }
}
