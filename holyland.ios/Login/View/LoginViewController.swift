//
//  LoginViewController.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/15.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: LoginViewModel!
    lazy var loginView = LoginView(frame: self.view.frame)

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }

    func bind() {
        loginView.idField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.input.id)
            .disposed(by: rx.disposeBag)

        loginView.passwordField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.input.password)
            .disposed(by: rx.disposeBag)

        viewModel.output.enableSignInButton
            .drive(loginView.signInButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)

        loginView.signInButton.rx.tap
            .withLatestFrom(viewModel.output.credential)
            .bind(to: viewModel.input.tapButton)
            .disposed(by: rx.disposeBag)

        viewModel.output.loginErrorsObservable
            .drive(onNext: { [weak self] error in
                self?.presentError(error)
            })
            .disposed(by: rx.disposeBag)

        viewModel.output.serverErrorObservable
            .drive(onNext: { [weak self] _ in
                self?.showCheckServerStatusToast()
            })
            .disposed(by: rx.disposeBag)
    }
}

extension LoginViewController {
    func setupViews() {
        view = loginView
    }
    
    func showFailedSignInAlert() {
        loginView.showCannotSignInAlert()
    }
    
    func presentError(_ error: Error) {
        loginView.signInButton.isEnabled = false
        showFailedSignInAlert()
    }
    
}
