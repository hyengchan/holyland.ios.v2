//
//  LoginView+Extension.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import UIKit
import RxSwift

extension LoginView {
    func showHelpSignInAlert() {
        endEditing(true)
        showAlertView(type: .forgetSignIn)
    }
    
    func showCannotSignInAlert() {
        endEditing(true)
        showAlertView(type: .failToSignIn)
    }
    
    func showsIdClearAllTextButton(isHidden: Bool) {
        self.passwordClearAllTextButton.isHidden = true
        self.idClearAllTextButton.isHidden = isHidden
    }
    
    func showsPasswordClearAllTextButton(isHidden: Bool) {
        self.idClearAllTextButton.isHidden = true
        self.passwordClearAllTextButton.isHidden = isHidden
    }
    
    func focusedIdField() {
        self.idField.changeBottomBorder(color: self.selectedColor)
        self.passwordField.changeBottomBorder(color: self.deselectedColor)
    }
    
    func focusedPasswordField() {
        self.idField.changeBottomBorder(color: self.deselectedColor)
        self.passwordField.changeBottomBorder(color: self.selectedColor)
    }
}

// MARK: - Create UI components using code
extension LoginView {
    func createMainLogoLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.appName
        label.textColor = Asset.Color.main.color
        label.font = FontFamily.JalnanOTF.regular.font(size: 28)
        return label
    }
    
    func createCopyrightLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.copyright
        label.textColor = Asset.Color.gray5.color
        label.font = FontFamily.NanumSquareRoundOTF.extraBold.font(size: 12)
        return label
    }
    
    func createTextField(placeholder: String) -> UITextField {
        let textfield = UITextField()
        textfield.placeholder = placeholder
        textfield.font = FontFamily.NanumSquareRoundOTF.extraBold.font(size: 17)
        textfield.addBottomBorder(width: self.frame.width - 16 * 2,
                                  height: Constants.Design.textFieldHeight,
                                  color: deselectedColor,
                                  leftPadding: Constants.Design.textFieldLeftPadding)
        return textfield
    }
    
    func createPasswordTextField(placeholder: String) -> UITextField {
        let textfield = createTextField(placeholder: placeholder)
        textfield.isSecureTextEntry = true
        return textfield
    }
    
    func createSignInButton() -> RoundedButton {
        let button = RoundedButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = FontFamily.NanumSquareRoundOTF.extraBold.font(size: 16)
        return button
    }
    
    func createHelpButtonForSignIn() -> UIButton {
        let button = UIButton()
        button.setTitle("로그인이 안되나요?", for: .normal)
        button.setTitleColor(Asset.Color.gray7.color, for: .normal)
        button.titleLabel?.font = FontFamily.NanumSquareRoundOTF.extraBold.font(size: 12)
        button.makeRounded()
        return button
    }
    
    func createClearAllTextButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "icKeyboardDelete"), for: .normal)
        button.isHidden = true
        return button
    }
    
    func createBackButton() -> UIButton {
        let button = UIButton()
        button.setImage(Asset.Assets.btnBack.image, for: .normal)
        return button
    }
}

// MARK: - Constraints
extension LoginView {
    func setupConstraints() {
        mainLogoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(104 * deviceRatio)
            $0.centerX.equalToSuperview()
        }
        
        idField.snp.makeConstraints {
            $0.top.equalTo(mainLogoLabel.snp.bottom).offset(123 * deviceRatio)
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
            $0.height.equalTo(Constants.Design.textFieldHeight)
        }

        idClearAllTextButton.snp.makeConstraints {
            $0.width.height.equalTo(36)
            $0.bottom.equalTo(idField.snp.bottom)
            $0.trailing.equalTo(idField.snp.trailing)
        }

        passwordField.snp.makeConstraints {
            $0.top.equalTo(idField.snp.bottom).offset(27)
            $0.leading.trailing.equalTo(idField)
            $0.height.equalTo(Constants.Design.textFieldHeight)
        }

        passwordClearAllTextButton.snp.makeConstraints {
            $0.width.height.equalTo(36)
            $0.bottom.equalTo(passwordField.snp.bottom)
            $0.trailing.equalTo(passwordField.snp.trailing)
        }

        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(65 * deviceRatio)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(signInButtonHeight)
        }

        helpButtonForSignIn.snp.makeConstraints {
            $0.leading.trailing.equalTo(idField)
            $0.top.equalTo(signInButton.snp.bottom).offset(Constants.Design.basicPadding)
        }

        copyrightLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(24)
            $0.centerX.equalToSuperview()
        }
        
//        backButton.snp.makeConstraints {
//            $0.size.equalTo(64)
//            $0.leading.equalTo(6)
//            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
//        }
    }
    
    func updateIdFieldConstraint(offset: CGFloat) {
        let defaultPadding = 123 * deviceRatio
        idField.snp.updateConstraints {
            $0.top.equalTo(mainLogoLabel.snp.bottom).offset(defaultPadding - offset)
        }
        self.layoutIfNeeded()
    }
}
