import SwiftUI

/// 轉乘服務選項模型
struct TransferServiceOption: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconName: String
    let iconColor: Color
    let url: String
}

/// 更多轉乘查詢頁面
struct TransferServicesView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    private let options: [TransferServiceOption] = [
        TransferServiceOption(
            title: "轉乘台鐵／高鐵",
            subtitle: "台鐵／高鐵時刻表快速查詢與訂票",
            iconName: "tram.fill",
            iconColor: Color(red: 0.48, green: 0.74, blue: 0.28),
            url: "https://www.railway.gov.tw"
        ),
        TransferServiceOption(
            title: "轉乘捷運",
            subtitle: "捷運路線地圖與票價行駛時間查詢",
            iconName: "tram.circle.fill",
            iconColor: Color(red: 0.10, green: 0.46, blue: 0.82),
            url: "https://www.metro.taipei"
        ),
        TransferServiceOption(
            title: "轉乘客運／公車",
            subtitle: "國道公路客運／市區公車動態時刻查詢",
            iconName: "bus.fill",
            iconColor: Color(red: 0.0, green: 0.74, blue: 0.83),
            url: "https://www.taiwanbus.tw/ebuspage/Default.aspx?lan=C"
        ),
        TransferServiceOption(
            title: "公共單車租借查詢",
            subtitle: "公共單車租借站點與車輛數量動態查詢",
            iconName: "bicycle",
            iconColor: Color(red: 0.98, green: 0.44, blue: 0.12),
            url: "https://www.youbike.com.tw"
        ),
        TransferServiceOption(
            title: "航班時刻查詢",
            subtitle: "航班時刻表班機即時狀態追蹤查詢",
            iconName: "airplane",
            iconColor: Color(red: 0.85, green: 0.11, blue: 0.38),
            url: "https://www.tsa.gov.tw"
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部導覽列與看板
            VStack(spacing: 16) {
                // 返回按鈕
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                            Text("更多轉乘查詢")
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
                
                // 轉乘圖示與標題
                VStack(spacing: 8) {
                    Image("TransferIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                    
                    Text("更多轉乘查詢")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("▼ 台鐵／高鐵／捷運／客運／公車／Ubike／航班")
                        .font(.system(size: 14.5, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 8)
            .background(Color("HeaderBackground"))
            
            // 轉乘選項清單
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    ForEach(options) { opt in
                        VStack(spacing: 0) {
                            HStack(spacing: 16) {
                                // 左側大圖示
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(opt.iconColor.opacity(0.15))
                                        .frame(width: 46, height: 46)
                                    
                                    Image(systemName: opt.iconName)
                                        .font(.system(size: 28))
                                        .foregroundColor(opt.iconColor)
                                }
                                
                                // 標題與說明
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(opt.title)
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(Color("TextPrimary"))
                                    
                                    Text(opt.subtitle)
                                        .font(.system(size: 13.5))
                                        .foregroundColor(Color("TextSecondary"))
                                }
                                
                                Spacer()
                                
                                // 右側淺灰色指示箭頭
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color("ChevronColor"))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if let url = URL(string: opt.url) {
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
}

#Preview {
    NavigationStack {
        TransferServicesView()
    }
}
