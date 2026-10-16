import SwiftUI

/// 路線規劃服務項目模型
struct RoutePlanningOption: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let iconName: String
    let isAssetImage: Bool
    let iconColor: Color
    let buttonTitle: String
    let buttonColor: Color
    let actionURL: String?
}

/// 路線規劃頁面
struct RoutePlanningView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    // 規劃選項
    private let options: [RoutePlanningOption] = [
        RoutePlanningOption(
            title: "大眾運輸路線規劃",
            subtitle: "(公車 + 捷運 + 鐵路)",
            iconName: "arrow.triangle.turn.up.right.diamond.fill",
            isAssetImage: false,
            iconColor: Color(red: 0.45, green: 0.08, blue: 0.45),
            buttonTitle: "路線規劃",
            buttonColor: Color(red: 0.45, green: 0.08, blue: 0.45),
            actionURL: "https://www.google.com/maps/@25.1259307,121.7295092,14z"
        ),
        RoutePlanningOption(
            title: "開啟地圖導航",
            subtitle: nil,
            iconName: "map.fill",
            isAssetImage: false,
            iconColor: Color(red: 0.42, green: 0.70, blue: 0.28),
            buttonTitle: "開啟導航",
            buttonColor: Color(red: 0.45, green: 0.72, blue: 0.28),
            actionURL: "https://maps.apple.com"
        ),
        RoutePlanningOption(
            title: "開啟街景服務",
            subtitle: nil,
            iconName: "figure.walk.motion",
            isAssetImage: false,
            iconColor: Color(red: 0.94, green: 0.75, blue: 0.22),
            buttonTitle: "查看街景",
            buttonColor: Color(red: 0.52, green: 0.76, blue: 0.30),
            actionURL: "https://www.google.com/maps"
        ),
        RoutePlanningOption(
            title: "附近共享單車查詢",
            subtitle: nil,
            iconName: "bicycle",
            isAssetImage: false,
            iconColor: Color(red: 0.98, green: 0.50, blue: 0.12),
            buttonTitle: "站點查詢",
            buttonColor: Color(red: 0.0, green: 0.74, blue: 0.83),
            actionURL: "https://www.youbike.com.tw"
        ),
        RoutePlanningOption(
            title: "附近飯店住宿查詢",
            subtitle: nil,
            iconName: "HotelIcon",
            isAssetImage: true,
            iconColor: Color(red: 0.12, green: 0.53, blue: 0.90),
            buttonTitle: "訂房比價",
            buttonColor: Color(red: 0.0, green: 0.74, blue: 0.83),
            actionURL: "https://www.booking.com"
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部導覽列與位置標題看板
            VStack(spacing: 16) {
                // 返回按鈕
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                            Text("路線規劃")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.18))
                        )
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                // 中心位置指示圖示與文字
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 44, height: 44)
                        
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(Color("HeaderBackground"))
                    }
                    
                    Text("您的位置")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("導航／街景／路線規劃與周邊服務查詢")
                        .font(.system(size: 14.5, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 8)
            .background(Color("HeaderBackground"))
            
            // 選項清單
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    ForEach(options) { opt in
                        VStack(spacing: 0) {
                            HStack(spacing: 16) {
                                // 左側圖示
                                Group {
                                    if opt.isAssetImage {
                                        Image(opt.iconName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 42, height: 42)
                                    } else {
                                        Image(systemName: opt.iconName)
                                            .font(.system(size: 34))
                                            .foregroundColor(opt.iconColor)
                                    }
                                }
                                .frame(width: 44, height: 44, alignment: .center)
                                
                                // 中間標題與副標題
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(opt.title)
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(Color("TextPrimary"))
                                    
                                    if let sub = opt.subtitle {
                                        Text(sub)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("TextPrimary"))
                                    }
                                }
                                
                                Spacer()
                                
                                // 右側動作按鈕
                                Button(action: {
                                    if let urlStr = opt.actionURL, let url = URL(string: urlStr) {
                                        openURL(url)
                                    }
                                }) {
                                    Text(opt.buttonTitle)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(
                                            Capsule()
                                                .fill(opt.buttonColor)
                                                .shadow(color: Color.black.opacity(0.18), radius: 3, x: 0, y: 2)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 18)
                            
                            Divider()
                                .background(Color("DividerColor"))
                                .padding(.horizontal, 16)
                        }
                        .background(Color("ListBackground"))
                    }
                }
            }
            .background(Color("ScreenBackground"))
        }
        .navigationBarBackButtonHidden(true)
        #if os(iOS)
        .toolbar(.hidden, for: .navigationBar)
        #endif
    }
}

#Preview {
    NavigationStack {
        RoutePlanningView()
    }
}
