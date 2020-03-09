import Foundation
struct DataModel : Codable {
	let pk : Int?
	let section : String?
	let version : String?
	let name : String?
	let image : String?
	let pdfLink : String?

	enum CodingKeys: String, CodingKey {

		case pk = "pk"
		case section = "section"
		case version = "version"
		case name = "name"
		case image = "image"
		case pdfLink = "pdfLink"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pk = try values.decodeIfPresent(Int.self, forKey: .pk)
		section = try values.decodeIfPresent(String.self, forKey: .section)
		version = try values.decodeIfPresent(String.self, forKey: .version)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		pdfLink = try values.decodeIfPresent(String.self, forKey: .pdfLink)
	}

}
