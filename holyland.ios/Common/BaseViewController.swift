//
//  BaseViewController.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/08.
//
import UIKit
import SnapKit
import Network
import RxSwift
import Action

class BaseViewController: UIViewController {
    
    // MARK: property
    // swiftlint:disable force_cast
    weak var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    // swiftlint:enable force_cast
    
    var navigationFirstButtonSelectedCompletion: (() -> Observable<Void>)?
    var navigationLastButtonSelectedCompletion: (() -> Void)?
    
    lazy var statusBar = createStatusBar()
    lazy var navigationBar = createCustomNavigationBar()
    lazy var navigationTitle = createNavigationTitleLabel()
    lazy var navigationFirstButton = createNavigationFirstButton()
    lazy var navigationLastButton: UIButton = createNavigationLastButton()
    
    var disposeBag = DisposeBag()
    
    init() {
        navigationFirstButtonSelectedCompletion = nil
        navigationLastButtonSelectedCompletion = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showsNavigationBar(isHidden: true)
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Navigation button
    func setupNavigationButton(_ button: UIButton, image: UIImage?) {
        button.setBackgroundImage(image, for: .normal)
        
        switch button {
        case navigationFirstButton:
            setupFirstButtonConstraint(button)
            button.addTarget(self, action: #selector(navigationFirstButtonSelected), for: .touchUpInside)
        case navigationLastButton:
            setupLastButtonConstraint(button)
            button.addTarget(self, action: #selector(navigationLastButtonSelected), for: .touchUpInside)
        default:
            break
        }
    }
    
    // MARK: - Navigation bar
    func setupNavigationBackgroundColor(_ color: UIColor) {
        statusBar.backgroundColor = color
        navigationBar.backgroundColor = color
    }
    
    func setupNavigationTitle(_ title: String,
                              textColor: UIColor = Asset.Color.gray9.color) {
        navigationTitle.textColor = textColor
        navigationTitle.text = title
    }
    
    func hideNavigationBar() {
        self.statusBar.isHidden = true
        self.navigationBar.isHidden = true
    }
    
    func showNavigationBar() {
        self.statusBar.isHidden = false
        self.navigationBar.isHidden = false
    }
    
    func showsNavigationBar(isHidden: Bool) {
        navigationController?.navigationBar.isHidden = isHidden
    }
    
    @objc func navigationFirstButtonSelected() {
        navigationFirstButtonSelectedCompletion?()
    }
    
    @objc func navigationLastButtonSelected() {
        navigationLastButtonSelectedCompletion?()
    }

    func showAlertView(type: AlertType, completion: (() -> Void)? = nil) {
        let alertView = type.alertView
        alertView.frame = self.view.frame
        alertView.setDefaultBody(type: type)
        alertView.okayActionCompletion = completion
        self.view.addSubview(alertView)
    }

    func showCheckNetworkStatusToast() {
        self.view.showToastView(message: "인터넷 연결 상태를 확인해주세요.")
    }

    func showCheckServerStatusToast() {
        self.view.showToastView(message: "서버와의 연결이 불안정합니다.")
    }

    func setNetworkStatusChangeHandler() -> (() -> Void) {
        return { [unowned self] in
            Observable.just(NetworkStatus.shared.isConnected)
                .filter { !$0 }
                .subscribe(onNext: { [weak self] _ in
                    DispatchQueue.main.async {
                        self?.showCheckNetworkStatusToast()
                    }
                })
                .disposed(by: disposeBag)
        }
    }

    private func setUpdateNetworkStatusHandler() {
        NetworkStatus.shared.netStatusChangeHandler = setNetworkStatusChangeHandler()
    }
}

// MARK: - Create UI components using code
extension BaseViewController {
    func createStatusBar() -> UIView {
        let view = createClearView()
        self.view.addSubview(view)
        return view
    }
    
    func createCustomNavigationBar() -> UIView {
        let view = createClearView()
        self.view.addSubview(view)
        return view
    }
    
    func createNavigationTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = FontFamily.NanumSquareRoundOTF.extraBold.font(size: 19)
        label.textAlignment = .center
        self.navigationBar.addSubview(label)
        return label
    }
    
    func createNavigationFirstButton() -> UIButton {
        let button = UIButton()
        navigationBar.addSubview(button)
        return button
    }
    
    func createNavigationLastButton() -> UIButton {
        let button = UIButton()
        navigationBar.addSubview(button)
        return button
    }
    
    fileprivate func createClearView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

// MARK: - Constraints
extension BaseViewController {
    private func setupConstraints() {
        statusBar.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.Design.navigationBarHeight)
        }
        
        navigationTitle.snp.makeConstraints {
            $0.center.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupFirstButtonConstraint(_ button: UIButton) {
        button.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(6)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    private func setupLastButtonConstraint(_ button: UIButton) {
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-6)
            $0.top.bottom.equalToSuperview()
        }
    }
}
