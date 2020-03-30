import Foundation
struct Books : Codable {
	let name : String?
	let image : String?
	let pdfLink : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case image = "image"
		case pdfLink = "pdfLink"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		pdfLink = try values.decodeIfPresent(String.self, forKey: .pdfLink)
	}

}
