import SwiftUI

/// 公車路線搜尋頁面
struct RouteSearchView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部導覽列與搜尋框區塊
            VStack(spacing: 12) {
                // 返回按鈕
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                            Text("路線搜尋")
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
                
                // 搜尋文字輸入框外觀（使用自訂設計放大鏡圖示）
                HStack(spacing: 10) {
                    CustomMagnifyingGlass(color: Color(white: 0.4))
                        .frame(width: 20, height: 20)
                    
                    if searchText.isEmpty {
                        Text("輸入路線或站牌")
                            .foregroundColor(Color(white: 0.65))
                            .font(.system(size: 16))
                    } else {
                        Text(searchText)
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .bold))
                    }
                    
                    Spacer()
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(white: 0.6))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(Color.white)
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
            .background(Color("HeaderBackground"))
            
            // 中間主要內容區（搜尋提示）
            ZStack {
                Color("ScreenBackground")
                    .ignoresSafeArea()
                
                VStack(spacing: 14) {
                    Image(systemName: "bus.fill")
                        .font(.system(size: 58))
                        .foregroundColor(Color(white: 0.6))
                    
                    Text("基隆市路線搜尋")
                        .font(.system(size: 21, weight: .bold))
                        .foregroundColor(Color("TextSecondary"))
                    
                    Text("請輸入公車路線編號")
                        .font(.system(size: 16))
                        .foregroundColor(Color("TextSecondary").opacity(0.8))
                    
                    if !searchText.isEmpty {
                        Text("目前查詢：\(searchText)")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.top, 8)
                    }
                }
                .padding(.bottom, 60)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // 底部快捷鍵盤區塊 (5 欄 x 4 列)
            VStack(spacing: 6) {
                // Row 1: 車站、七堵、1、2、3
                HStack(spacing: 6) {
                    keypadButton(title: "車站", bg: Color(red: 0.90, green: 0.22, blue: 0.21), fg: .white) {
                        appendSearch("車站")
                    }
                    keypadButton(title: "七堵", bg: Color(red: 0.12, green: 0.53, blue: 0.90), fg: .white) {
                        appendSearch("七堵")
                    }
                    numberButton("1")
                    numberButton("2")
                    numberButton("3")
                }
                
                // Row 2: 八斗子、信義、4、5、6
                HStack(spacing: 6) {
                    keypadButton(title: "八斗子", bg: Color(red: 0.26, green: 0.63, blue: 0.28), fg: .white) {
                        appendSearch("八斗子")
                    }
                    keypadButton(title: "信義", bg: Color(red: 0.36, green: 0.20, blue: 0.03), fg: .white) {
                        appendSearch("信義")
                    }
                    numberButton("4")
                    numberButton("5")
                    numberButton("6")
                }
                
                // Row 3: 大武崙、和平島、7、8、9
                HStack(spacing: 6) {
                    keypadButton(title: "大武崙", bg: Color(red: 0.98, green: 0.55, blue: 0.0), fg: .white) {
                        appendSearch("大武崙")
                    }
                    keypadButton(title: "和平島", bg: Color(red: 0.96, green: 0.75, blue: 0.24), fg: .white) {
                        appendSearch("和平島")
                    }
                    numberButton("7")
                    numberButton("8")
                    numberButton("9")
                }
                
                // Row 4: 更多、長庚、0、重設、刪除
                HStack(spacing: 6) {
                    keypadButton(title: "更多", bg: .white, fg: .black) {
                        // 更多地點
                    }
                    keypadButton(title: "長庚", bg: .white, fg: .black) {
                        appendSearch("長庚")
                    }
                    numberButton("0")
                    keypadButton(title: "重設", bg: .white, fg: .black) {
                        searchText = ""
                    }
                    keypadButton(title: "刪除", bg: .white, fg: .black) {
                        if !searchText.isEmpty {
                            searchText.removeLast()
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 10)
            .padding(.bottom, 24)
            .background(Color("HeaderBackground"))
        }
        .navigationBarBackButtonHidden(true)
        #if os(iOS)
        .toolbar(.hidden, for: .navigationBar)
        #endif
    }
    
    // 數字按鈕
    private func numberButton(_ num: String) -> some View {
        keypadButton(title: num, bg: .white, fg: .black, isNumber: true) {
            searchText.append(num)
        }
    }
    
    // 通用按鍵產生器
    private func keypadButton(
        title: String,
        bg: Color,
        fg: Color,
        isNumber: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: isNumber ? 22 : 17, weight: .bold))
                .foregroundColor(fg)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(bg)
                )
        }
        .buttonStyle(.plain)
    }
    
    private func appendSearch(_ text: String) {
        if searchText.isEmpty {
            searchText = text
        } else {
            searchText.append(" \(text)")
        }
    }
}

#Preview("路線搜尋頁面") {
    NavigationStack {
        RouteSearchView()
    }
}
