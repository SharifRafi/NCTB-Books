import Foundation
struct HomeModelClass : Codable {
	let className : String?
	let books : [Books]?

	enum CodingKeys: String, CodingKey {

		case className = "class"
		case books = "books"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		className = try values.decodeIfPresent(String.self, forKey: .className)
		books = try values.decodeIfPresent([Books].self, forKey: .books)
	}

}
