//
//  AlertType.swift
//  holyland.ios
//
//  Created by 윤형찬 on 2021/06/14.
//

import UIKit

enum AlertType {
    case forgetSignIn
    case sureNotSavingProfile
    case sureSignOut
    case videoPlayback
    case maxSignInAccountWarning
    case failToUpdatePassword
    case failToSignIn
    case videoAttendance
    case cannotServiceWorship
    case showChildQRCode
    case error
    
    func getBody() -> (title: String, message: String?, okay: String, cancel: String?) {
        switch self {
        case .forgetSignIn:
            return (title: "로그인이 안되나요?",
                    message: "아이디나 비밀번호를 잊어버려서 \n로그인 할 수 없다면 우리반 선생님께 \n도움을 요청하세요!",
                    okay: "확인",
                    cancel: nil)
        case .sureNotSavingProfile:
            return (title: "나가기 하면 변경 사항이 저장되지 \n않아요. 정말 나가시겠습니까?",
                    message: nil,
                    okay: "확인",
                    cancel: "취소")
        case .videoPlayback:
            return (title: "이전 재생 위치\n00:10 부터 예배드릴래요!",
                    message: nil,
                    okay: "확인",
                    cancel: "처음부터")
        case .sureSignOut:
            return (title: "정말 로그아웃 하시겠습니까?",
                    message: nil,
                    okay: "확인",
                    cancel: "취소")
        case .maxSignInAccountWarning:
            return (title: "계정 등록은 \n3개 까지만 할 수 있어요!",
                    message: nil,
                    okay: "확인",
                    cancel: nil)
        case .failToUpdatePassword:
            return (title: "비밀번호가 일치하지 않아요!",
                    message: nil,
                    okay: "확인",
                    cancel: nil)
        case .failToSignIn:
            return (title: "아이디나 비밀번호가 잘못 \n입력되었어요!",
                    message: nil,
                    okay: "확인",
                    cancel: nil)
        case .videoAttendance:
            return (title: "말씀을 잘 듣고 있나요?",
                    message: "아멘 버튼을 눌러 예배에 계속 참여해요!",
                    okay: "아멘",
                    cancel: nil)
        case .cannotServiceWorship:
            return (title: "지금은 예배에 입장할 수 없어요!",
                    message: nil,
                    okay: "확인",
                    cancel: nil)
        case .error:
            return (title: "오류!",
                    message: "다시 시도해보세요.",
                    okay: "확인",
                    cancel: nil)
        default:
            return (title: "",
                    message: "",
                    okay: "",
                    cancel: "")
        }
    }
    
    var alertView: AlertView {
        switch self {
        case .forgetSignIn:
            return ForgetAlertView(frame: .zero)
        case .sureSignOut, .videoPlayback, .sureNotSavingProfile:
            return OkayCancelAlertView(frame: .zero)
        case .maxSignInAccountWarning, .failToUpdatePassword, .failToSignIn, .cannotServiceWorship:
            return OneTitleAlertView(frame: .zero)
        case .videoAttendance:
            return VideoAttendanceAlertView(frame: .zero)
        case .error:
            return TitleMessageAlertView(frame: .zero)
        case .showChildQRCode:
            return ChildQRCodeAlertView(frame: .zero)
        }
    }
}
