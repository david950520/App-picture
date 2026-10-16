import SwiftUI

/// 附近站牌資料模型
struct NearbyStopItem: Identifiable {
    let id = UUID()
    let name: String
    let distanceDescription: String
}

/// 附近站牌頁面
struct NearbyStopsView: View {
    @Environment(\.dismiss) private var dismiss
    
    // 範例站牌資料
    private let stops: [NearbyStopItem] = [
        NearbyStopItem(name: "仁二路 (二信循環站)", distanceDescription: "約 64.2 公尺 (步行 0 分鐘)"),
        NearbyStopItem(name: "二信循環站", distanceDescription: "約 64.2 公尺 (步行 0 分鐘)"),
        NearbyStopItem(name: "廟口夜市 (二信循環站仁二路)", distanceDescription: "約 64.2 公尺 (步行 0 分鐘)"),
        NearbyStopItem(name: "忠一路孝一路口", distanceDescription: "約 155.4 公尺 (步行 2 分鐘)"),
        NearbyStopItem(name: "孝二路", distanceDescription: "約 226.0 公尺 (步行 3 分鐘)"),
        NearbyStopItem(name: "城隍廟", distanceDescription: "約 265.9 公尺 (步行 3 分鐘)"),
        NearbyStopItem(name: "基隆港務大樓", distanceDescription: "約 268.4 公尺 (步行 4 分鐘)"),
        NearbyStopItem(name: "電力公司", distanceDescription: "約 307.2 公尺 (步行 4 分鐘)")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部導覽列
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .bold))
                        Text("附近站牌")
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
            .padding(.top, 8)
            .padding(.bottom, 12)
            .background(Color("HeaderBackground"))
            
            // 站牌清單列表
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    ForEach(stops) { stop in
                        VStack(spacing: 0) {
                            HStack(spacing: 14) {
                                // 黃色地標圖示
                                Image(systemName: "mappin.circle.fill")
                                    .font(.system(size: 38))
                                    .foregroundColor(Color(red: 0.95, green: 0.73, blue: 0.15))
                                
                                // 站牌名稱與步行資訊
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(stop.name)
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(Color("TextPrimary"))
                                    
                                    Text(stop.distanceDescription)
                                        .font(.system(size: 13.5))
                                        .foregroundColor(Color("TextSecondary"))
                                }
                                
                                Spacer()
                                
                                // 查詢路線按鈕
                                Button(action: {}) {
                                    Text("查詢路線")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(
                                            Capsule()
                                                .fill(Color(red: 0.0, green: 0.74, blue: 0.83))
                                                .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 2)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            
                            Divider()
                                .background(Color("DividerColor"))
                                .padding(.leading, 68)
                        }
                        .background(Color("ListBackground"))
                    }
                }
            }
            .background(Color("ScreenBackground"))
            
            // 底部搜尋功能列
            HStack {
                Text("以目前地圖位置為中心搜尋 →")
                    .font(.system(size: 13.5, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}) {
                    Text("按此搜尋附近站牌")
                        .font(.system(size: 13.5, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 7)
                        .background(
                            Capsule()
                                .stroke(Color.white, lineWidth: 1.5)
                        )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Color("HeaderBackground"))
        }
        .navigationBarBackButtonHidden(true)
        #if os(iOS)
        .toolbar(.hidden, for: .navigationBar)
        #endif
    }
}

#Preview {
    NavigationStack {
        NearbyStopsView()
    }
}
