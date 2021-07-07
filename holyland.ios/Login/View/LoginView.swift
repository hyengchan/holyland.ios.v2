//
//  LoginView.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import UIKit
import SnapKit
import RxSwift

class LoginView: UIView {
    lazy var mainLogoLabel = createMainLogoLabel()
    lazy var idField = createTextField(placeholder: "아이디")
    lazy var passwordField = createPasswordTextField(placeholder: "비밀번호")
    lazy var signInButton = createSignInButton()
    lazy var helpButtonForSignIn = createHelpButtonForSignIn()
    lazy var idClearAllTextButton = createClearAllTextButton()
    lazy var passwordClearAllTextButton = createClearAllTextButton()
    lazy var copyrightLabel = createCopyrightLabel()
    
    lazy var deviceRatio = self.frame.height / Constants.Design.heightIphone11
    let signInButtonHeight: CGFloat = 49
    let baseKeyboardHidingHeight: CGFloat = 580
    
    let selectedColor = Asset.Color.gray8.color
    let deselectedColor = Asset.Color.gray5.color
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
        
        addSubview(mainLogoLabel)
        addSubview(copyrightLabel)
        addSubview(idField)
        addSubview(passwordField)
        addSubview(signInButton)
        addSubview(helpButtonForSignIn)
        addSubview(idClearAllTextButton)
        addSubview(passwordClearAllTextButton)
        
        setupConstraints()
        setupKeyboardObservers()
        setupButtonEvents()
        setupTextfieldEvents()
    }
}

extension LoginView {
    fileprivate func setupKeyboardObservers() {
        let keyboardShown = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
        let keyboardHidden = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)

        keyboardShown
            .map { [self] _ in
                self.frame.height < self.baseKeyboardHidingHeight
            }
            .asDriver(onErrorJustReturn: false)
            .filter { $0 }
            .drive(onNext: { [weak self] _ in
                self?.updateIdFieldConstraint(offset: 60)
            })
            .disposed(by: disposeBag)
        
        keyboardHidden
            .map { [self] _ in
                self.frame.height < self.baseKeyboardHidingHeight
            }
            .asDriver(onErrorJustReturn: false)
            .filter { $0 }
            .drive(onNext: { [weak self] _ in
                self?.updateIdFieldConstraint(offset: 0)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupButtonEvents() {
        idClearAllTextButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.idField.text = ""
                self?.showsIdClearAllTextButton(isHidden: true)
            }.disposed(by: disposeBag)
        
        passwordClearAllTextButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.passwordField.text = ""
                self?.showsPasswordClearAllTextButton(isHidden: true)
            }.disposed(by: disposeBag)
        
        helpButtonForSignIn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.showHelpSignInAlert()
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupTextfieldEvents() {
        // idField
        idField.rx.controlEvent([.editingDidEndOnExit])
            .asDriver()
            .drive { [self] _ in
                self.passwordField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        idField.rx.controlEvent([.editingDidBegin])
            .asDriver()
            .drive(onNext: { [self] _ in
                self.focusedIdField()
                let isHidden = idField.text?.isEmpty == true
                self.showsIdClearAllTextButton(isHidden: isHidden)
            })
            .disposed(by: disposeBag)
        
        idField.rx.controlEvent([.editingChanged])
            .asObservable()
            .map({ [self] _ in
                self.idField.text?.isEmpty == true
            })
            .bind(to: self.idClearAllTextButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        // passwordField
        passwordField.rx.controlEvent([.editingDidEndOnExit])
            .asDriver()
            .drive { [self] _ in
                self.passwordField.resignFirstResponder()
                self.showsPasswordClearAllTextButton(isHidden: true)
            }
            .disposed(by: disposeBag)
        
        passwordField.rx.controlEvent([.editingDidBegin])
            .asDriver()
            .drive(onNext: { [self] _ in
                self.focusedPasswordField()
                let isHidden = passwordField.text?.isEmpty == true
                self.showsPasswordClearAllTextButton(isHidden: isHidden)
            })
            .disposed(by: disposeBag)
        
        passwordField.rx.controlEvent([.editingChanged])
            .map({ [self] _ in
                self.passwordField.text?.isEmpty == true
            })
            .asDriver(onErrorJustReturn: true)
            .drive(self.passwordClearAllTextButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
