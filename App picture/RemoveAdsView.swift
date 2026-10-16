import SwiftUI

/// 免費去除廣告頁面
struct RemoveAdsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingRewardAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部導覽列與標題看板
            VStack(spacing: 16) {
                // 返回按鈕
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                            Text("免費去除廣告")
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
                
                // 禁止符號圖示與標題
                VStack(spacing: 8) {
                    Image(systemName: "nosign")
                        .font(.system(size: 54, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("升級無廣告體驗")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("完成下方任務即可升級無廣告體驗")
                        .font(.system(size: 14.5, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 8)
            .background(Color("HeaderBackground"))
            
            // 任務清單區塊
            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    // 紅色播放按鈕圖示
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.86, green: 0.24, blue: 0.18))
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "play.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .offset(x: 2)
                    }
                    
                    // 說明文字
                    VStack(alignment: .leading, spacing: 4) {
                        Text("看完一部簡短的廣告影片")
                            .font(.system(size: 16.5, weight: .bold))
                            .foregroundColor(Color("TextPrimary"))
                        
                        Text("即可獲得 10 分鐘無廣告體驗")
                            .font(.system(size: 13.5))
                            .foregroundColor(Color("TextSecondary"))
                    }
                    
                    Spacer()
                    
                    // 觀看按鈕
                    Button(action: {
                        showingRewardAlert = true
                    }) {
                        Text("按此觀看")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color(red: 0.0, green: 0.74, blue: 0.83))
                                    .shadow(color: Color.black.opacity(0.18), radius: 3, x: 0, y: 2)
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 18)
                .background(Color("ListBackground"))
                
                Divider()
                    .background(Color("DividerColor"))
                    .padding(.horizontal, 16)
                
                Spacer()
            }
            .background(Color("ScreenBackground"))
        }
        .navigationBarBackButtonHidden(true)
        #if os(iOS)
        .toolbar(.hidden, for: .navigationBar)
        #endif
        .alert("恭喜獲得無廣告獎勵", isPresented: $showingRewardAlert) {
            Button("確定", role: .cancel) { }
        } message: {
            Text("您已成功觀看完畢，已為您開啟 10 分鐘無廣告體驗！")
        }
    }
}

#Preview {
    NavigationStack {
        RemoveAdsView()
    }
}
