import SwiftUI

/// 最愛站牌頁面
struct FavoriteStopsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部導覽列
            HStack {
                // 左側返回按鈕
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .bold))
                        Text("最愛站牌")
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
                
                // 右側功能按鈕：排序與刪除
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {}) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.18))
                )
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 12)
            .background(Color("HeaderBackground"))
            
            // 中間空白提示區
            ZStack {
                Color("ScreenBackground")
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 54))
                        .foregroundColor(Color(white: 0.55))
                    
                    Text("目前沒有最愛站牌")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("TextSecondary"))
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("返回查詢")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .background(
                                Capsule()
                                    .fill(Color("FABBackground"))
                                    .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)
                            )
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 6)
                }
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarBackButtonHidden(true)
        #if os(iOS)
        .toolbar(.hidden, for: .navigationBar)
        #endif
    }
}

#Preview {
    NavigationStack {
        FavoriteStopsView()
    }
}
