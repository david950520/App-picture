import SwiftUI

/// 飯店訂房平台項目模型
struct HotelBookingItem: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String
    let iconType: IconType
    let url: String
    
    enum IconType {
        case agoda
        case booking
        case klook
    }
}

/// 預訂飯店住宿頁面
struct HotelBookingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    var onSearchTapped: (() -> Void)? = nil
    
    private let bookingItems: [HotelBookingItem] = [
        HotelBookingItem(
            name: "Agoda 訂房網站",
            subtitle: "國內外特惠住宿線上訂房",
            iconType: .agoda,
            url: "https://www.agoda.com"
        ),
        HotelBookingItem(
            name: "Booking.com 訂房網站",
            subtitle: "預訂免付費,免取消手續費",
            iconType: .booking,
            url: "https://www.booking.com"
        ),
        HotelBookingItem(
            name: "KLOOK 客路 訂房網站",
            subtitle: "精選專案優惠,訂房最便宜",
            iconType: .klook,
            url: "https://www.klook.com"
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部導覽列與看板
            VStack(spacing: 16) {
                // 頂部導覽按鈕列
                HStack {
                    // 左側返回按鈕
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                            Text("預訂飯店住宿")
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
                    
                    // 右側放大鏡搜尋按鈕（採用專屬放大鏡設計）
                    FloatingSearchButton(size: 40) {
                        onSearchTapped?()
                    }
                }
                .padding(.horizontal, 16)
                
                // 飯店圖示與說明
                VStack(spacing: 8) {
                    Image("HotelIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                    
                    Text("預訂飯店住宿")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("▼ 請選擇飯店訂房比價網站")
                        .font(.system(size: 14.5, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 8)
            .background(Color("HeaderBackground"))
            
            // 訂房平台清單
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    ForEach(bookingItems) { item in
                        VStack(spacing: 0) {
                            HStack(spacing: 14) {
                                // 廣告小標籤 + 平台 Logo
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("AD")
                                        .font(.system(size: 9, weight: .black))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 1.5)
                                        .background(
                                            RoundedRectangle(cornerRadius: 3)
                                                .fill(Color(red: 0.12, green: 0.18, blue: 0.42))
                                        )
                                    
                                    platformLogoView(type: item.iconType)
                                }
                                
                                // 標題與說明文字
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name)
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(Color("TextPrimary"))
                                    
                                    Text(item.subtitle)
                                        .font(.system(size: 13.5))
                                        .foregroundColor(Color("TextSecondary"))
                                }
                                
                                Spacer()
                                
                                // 立即預訂按鈕
                                Button(action: {
                                    if let url = URL(string: item.url) {
                                        openURL(url)
                                    }
                                }) {
                                    Text("立即預訂")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 8)
                                        .background(
                                            Capsule()
                                                .fill(Color(red: 0.48, green: 0.74, blue: 0.28))
                                                .shadow(color: Color.black.opacity(0.18), radius: 3, x: 0, y: 2)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if let url = URL(string: item.url) {
                                    openURL(url)
                                }
                            }
                            
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
    
    // 自訂各平台專屬 Logo 造型
    @ViewBuilder
    private func platformLogoView(type: HotelBookingItem.IconType) -> some View {
        switch type {
        case .agoda:
            // Agoda 風格圖示：白色底圓角矩形 + 灰色 'a' + 5 色小圓點
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(white: 0.95))
                    .frame(width: 48, height: 48)
                
                VStack(spacing: 2) {
                    Text("a")
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .foregroundColor(Color(white: 0.35))
                    
                    HStack(spacing: 2.5) {
                        Circle().fill(Color.red).frame(width: 4.5, height: 4.5)
                        Circle().fill(Color.orange).frame(width: 4.5, height: 4.5)
                        Circle().fill(Color.green).frame(width: 4.5, height: 4.5)
                        Circle().fill(Color.blue).frame(width: 4.5, height: 4.5)
                        Circle().fill(Color.purple).frame(width: 4.5, height: 4.5)
                    }
                }
            }
            
        case .booking:
            // Booking.com 風格圖示：深藍圓角矩形 + 白色 "Booking"
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.05, green: 0.22, blue: 0.52))
                    .frame(width: 48, height: 48)
                
                Text("Booking")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
            }
            
        case .klook:
            // KLOOK 風格圖示：橙色圓角矩形 + 白色標誌
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.98, green: 0.38, blue: 0.15))
                    .frame(width: 48, height: 48)
                
                Image(systemName: "k.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HotelBookingView()
    }
}
