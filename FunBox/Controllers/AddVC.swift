//
//  SecondVC.swift
//  FunBox
//
//  Created by Denis Prozukin on 13.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit
import SnapKit

protocol AddModalHandler: class {
	func addModalDismissed()
}

class AddVC: UIViewController {
	private let cancelButton: UIButton = {
		let button = UIButton()
		let config = UIImage.SymbolConfiguration(weight: .bold)
		let image = UIImage(systemName: "xmark", withConfiguration: config)
		button.setImage(image, for: .normal)
		button.contentMode = .scaleAspectFit
		button.tintColor = .black
		button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
		return button
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.textColor = .label
		label.textAlignment = .left
		label.text = "Название"
		return label
	}()
	
	private let nameTextField: UITextField = {
		let field = UITextField()
		field.font = UIFont.preferredFont(forTextStyle: .title2)
		field.autocorrectionType = .no
		field.keyboardType = .default
		field.returnKeyType = .done
		field.borderStyle = .roundedRect
		field.backgroundColor = .systemBackground
		field.clearButtonMode = .whileEditing
		field.placeholder = "Введите название"
		return field
	}()
	
	private let priceLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.textColor = .label
		label.textAlignment = .left
		label.text = "Цена"
		return label
	}()
	
	private let priceTextField: UITextField = {
		let field = UITextField()
		field.font = UIFont.preferredFont(forTextStyle: .title2)
		field.autocorrectionType = .no
		field.keyboardType = .decimalPad
		field.returnKeyType = .done
		field.borderStyle = .roundedRect
		field.backgroundColor = .systemBackground
		field.clearButtonMode = .whileEditing
		field.placeholder = "Введите цену"
		return field
	}()
	
	private let quantityLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.textColor = .label
		label.textAlignment = .left
		label.text = "Количество"
		return label
	}()
	
	private let quantityTextField: UITextField = {
		let field = UITextField()
		field.font = UIFont.preferredFont(forTextStyle: .title2)
		field.autocorrectionType = .no
		field.keyboardType = .numberPad
		field.returnKeyType = .done
		field.borderStyle = .roundedRect
		field.backgroundColor = .systemBackground
		field.clearButtonMode = .whileEditing
		field.placeholder = "Введите количество"
		return field
	}()
	
	private let confirmButton: UIButton = {
		let button = CustomButton(title: "Добавить")
		button.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
		button.addTarget(self, action: #selector(confirmAdd), for: .touchUpInside)
		return button
	}()
	
	private var name: String?
	private var price: Double?
	private var quantity: Int?
	weak var delegate: AddModalHandler?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		configureTextFields()
		setUpConstraints()
		setupAddTargetIsNotEmptyTextFields()
	}
}
// MARK: - Extensions
extension AddVC {
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		nameTextField.resignFirstResponder()
		priceTextField.resignFirstResponder()
		quantityTextField.resignFirstResponder()
	}
	
	@objc private func confirmAdd() {
		view.endEditing(true)
		
		guard let name = name, let price = price, let quantity = quantity else { return }
		let article = Article(name: name, price: price, quantity: quantity)
		let userInfo: [String: Article] = ["article": article]
		NotificationCenter.default.post(name: .didAddData, object: nil, userInfo: userInfo)
		
		dismiss(animated: true) {
			self.delegate?.addModalDismissed()
		}
	}
	
	@objc private func dismissVC() {
		view.endEditing(true)
		dismiss(animated: true)
	}
	
	private func configureTextFields() {
		nameTextField.becomeFirstResponder()
		nameTextField.delegate = self
		priceTextField.delegate = self
		quantityTextField.delegate = self
	}
	
	private func setUpConstraints() {
		let firstRowStack = UIStackView(arrangedSubviews: [nameLabel, cancelButton])
		firstRowStack.axis = .horizontal
		firstRowStack.alignment = .center
		firstRowStack.distribution = .equalCentering
		
		let stackView = UIStackView(arrangedSubviews: [firstRowStack, nameTextField, priceLabel, priceTextField, quantityLabel, quantityTextField, confirmButton])
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 12
		stackView.setCustomSpacing(16, after: quantityTextField)
		
		view.addSubview(stackView)
		
		stackView.snp.makeConstraints { (make) in
			make.leading.equalToSuperview().offset(8)
			make.trailing.equalToSuperview().offset(-8)
			make.top.equalToSuperview().offset(16)
		}
	}
	
	private func setupAddTargetIsNotEmptyTextFields() {
		confirmButton.isEnabled = false
		nameTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
		priceTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
		quantityTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
	}
	
	@objc private func textFieldsIsNotEmpty(sender: UITextField) {
		guard let name = nameTextField.text, !name.isEmpty,
			let price = priceTextField.text, !price.isEmpty,
			let quantity = quantityTextField.text, !quantity.isEmpty
			else {
				self.confirmButton.isEnabled = false
				return
		}
		confirmButton.isEnabled = true
	}
}

extension AddVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if textField.text == "" {
			return
		}
		
		switch textField {
		case nameTextField:
			name = textField.text!
		case priceTextField:
			price = Double(textField.text!)!
		case quantityTextField:
			quantity = Int(textField.text!)!
		default:
			break
		}
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		switch textField {
		case nameTextField:
			if range.location == 0 && string == " " {
				return false
			} else if range.location > 1 && textField.text?.last == " " && string == " " {
				return false
			} else {
				return true
			}
		case priceTextField:
			let dotsCount = textField.text!.components(separatedBy: ".").count - 1
			if range.location == 0 && string == "." {
				return false
			} else if dotsCount > 0 && (string == "." || string == ",") {
				return false
			} else if string == "," {
				textField.text! += "."
				return false
			}
		case quantityTextField:
			if string == "," {
				textField.text! += ""
				return false
			}
		default:
			break
		}
		return true
	}
}

