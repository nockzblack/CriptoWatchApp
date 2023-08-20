import Foundation


public struct GeckoCriptoCoin: Codable {
    public let id: String
    public let symbol: String
    public let name: String
    public let image: String
    public let current_price: Double
    public let last_updated: String
    public let total_volume: Double
    public let high_24h: Double
    public let low_24h: Double
    public let price_change_percentage_24h: Double
    public let market_cap: Double
}
