
import Foundation

guard let url = Bundle.main.url(forResource: "coinGecko", withExtension: "json") else {
    fatalError()
}

guard let data = try? Data(contentsOf: url) else {
    fatalError()
}



let decoder = JSONDecoder()

do {
    let response = try decoder.decode([GeckoCriptoCoin].self, from: data)
    print(response)
} catch {
    print(error)
}
