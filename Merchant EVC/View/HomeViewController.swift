//
//  ViewController.swift
//  Merchant EVC
//
//  Created by Abdirizak Hassan on 6/19/22.
//

import UIKit

class HomeViewController: UIViewController {
    private let viewModel = ViewModel()
    
    private let imageTosell: UIImageView = {
        let image = UIImageView()
        image.image = Images.backetball_image
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let textVeiw: UITextView = {
        let txtview = UITextView()
        txtview.backgroundColor = .clear
        txtview.translatesAutoresizingMaskIntoConstraints = false
        let attributeText = NSMutableAttributedString(string: "Buy One BasketBall", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 38), NSAttributedString.Key.foregroundColor : UIColor.label])
        attributeText.append(NSAttributedString(string: "\n\n Basketball ball is a spherical ball used in basketball games. Basketballs usually range in size from very small promotional items that are only a few inches (some centimeters) in diameter to extra large balls nearly 2 feet (60 cm) in diameter used in training exercises.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]))
        txtview.attributedText = attributeText
        txtview.textAlignment = .center
        txtview.isScrollEnabled = false
        txtview.isEditable = false
        return txtview
    }()
    
    private let textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemGray4
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let numberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.placeholder = "Enter your Number"
        return textField
    }()
    
    private let buyButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Buy", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configImage()
        configTextView()
        configTextField()
        buyBtnRequest()
        dismissKeyboardTapGesture()
        numberTextField.delegate = self
    }
    
    
    private func configImage() {
        view.addSubview(imageTosell)
        NSLayoutConstraint.activate([
            imageTosell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageTosell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageTosell.heightAnchor.constraint(equalToConstant: 250),
            imageTosell.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func configTextView() {
        view.addSubview(textVeiw)
        NSLayoutConstraint.activate([
            textVeiw.topAnchor.constraint(equalTo:imageTosell.bottomAnchor, constant: 10),
            textVeiw.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textVeiw.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func configTextField() {
        view.addSubview(textFieldView)
        textFieldView.addSubview(numberTextField)
        
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: textVeiw.bottomAnchor, constant: 20),
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldView.heightAnchor.constraint(equalToConstant: 60),
            
            numberTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 10),
            numberTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -14),
            numberTextField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 14),
            numberTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func buyBtnRequest() {
        buyButton.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        view.addSubview(buyButton)
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 30),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            buyButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    private func validateTxt() {
        if (numberTextField.text?.isEmpty)! {
            print("Number can not be Empty")
        }
    }
    
    @objc func didTapBuy() {
        guard let number = numberTextField.text else { return }
        validateTxt()
        showLoadingview()
        Task {
            try await viewModel.makePayment(number, 1)
            dismissLoding()
        }
    }
    
    func dismissKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return viewModel.checkNumberCount(textField, range: range, string: string)
    }
    
}

