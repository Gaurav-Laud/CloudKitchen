//
//  Extensions.swift
//  CloudKitchen
//
//  Created by E5000745 on 05/07/24.
//

import SwiftUI
import AlertToast

extension View {
    func showToast(isPresenting: Binding<Bool>, title: String? = nil, duration: Double = 3) -> some View {
        self
            .toast(isPresenting: isPresenting, duration: 3, alert: {
                AlertToast(displayMode: .banner(.pop), type: .regular, title: title)
            })
    }
    func roundCorners(_ radius: Float = 16) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: CGFloat(radius)))
    }
    func addBorder(cornerRadius: CGFloat = 16, borderColor: Color = .yellow, width: CGFloat = 2) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: width)
            )
    }
}
extension Color {
    init(hexString: String, opacity: Double = 1.0) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(.sRGB, red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0,opacity: 1.0)
    }
}
extension Date {
    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) else {return self}
    
        return localDate
    }
    static func getNextWeekDay(after date: Date) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.weekday = 2
        let weekDay = Calendar.current.nextDate(after: date, matching: dateComponents, matchingPolicy: .nextTimePreservingSmallerComponents)
        return weekDay
    }
}
struct NavigationUtil {
    static func popToRootView() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?.popToRootViewController(animated: true)
        }
    }
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else { return nil }
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        for childViewController in viewController.children {
            return findNavigationController(viewController:
                                                childViewController)
        }
        return nil
    }
}
