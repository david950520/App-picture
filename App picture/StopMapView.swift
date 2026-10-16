import SwiftUI
import MapKit

/// 地圖站牌標註模型
struct MapStopAnnotation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

/// 站牌地圖頁面
struct StopMapView: View {
    @Environment(\.dismiss) private var dismiss
    
    // 基隆市中心與基隆港座標
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 25.1315, longitude: 121.7410),
            span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        )
    )
    
    // 範例站牌標註點
    private let stops: [MapStopAnnotation] = [
        MapStopAnnotation(name: "仁德里", coordinate: CLLocationCoordinate2D(latitude: 25.1310, longitude: 121.7415)),
        MapStopAnnotation(name: "海洋廣場", coordinate: CLLocationCoordinate2D(latitude: 25.1325, longitude: 121.7395)),
        MapStopAnnotation(name: "新店里", coordinate: CLLocationCoordinate2D(latitude: 25.1320, longitude: 121.7380)),
        MapStopAnnotation(name: "基港大樓", coordinate: CLLocationCoordinate2D(latitude: 25.1332, longitude: 121.7430)),
        MapStopAnnotation(name: "崁仔頂漁市", coordinate: CLLocationCoordinate2D(latitude: 25.1298, longitude: 121.7398)),
        MapStopAnnotation(name: "仁愛市場", coordinate: CLLocationCoordinate2D(latitude: 25.1285, longitude: 121.7405)),
        MapStopAnnotation(name: "文安里", coordinate: CLLocationCoordinate2D(latitude: 25.1275, longitude: 121.7390))
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
                        Text("站牌地圖")
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
                
                // 右側定位中心點按鈕
                Button(action: {
                    cameraPosition = .region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 25.1315, longitude: 121.7410),
                            span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                        )
                    )
                }) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.18))
                        )
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 12)
            .background(Color("HeaderBackground"))
            
            // 地圖主畫面
            Map(position: $cameraPosition) {
                ForEach(stops) { stop in
                    Annotation(stop.name, coordinate: stop.coordinate) {
                        VStack(spacing: 2) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.12, green: 0.17, blue: 0.32))
                                    .frame(width: 32, height: 32)
                                
                                Image(systemName: "bus.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            .shadow(radius: 3)
                            
                            Text(stop.name)
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(
                                    Capsule()
                                        .fill(Color.black.opacity(0.75))
                                )
                        }
                    }
                }
            }
            .mapStyle(.standard(elevation: .realistic))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // 底部搜尋列
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
        StopMapView()
    }
}
