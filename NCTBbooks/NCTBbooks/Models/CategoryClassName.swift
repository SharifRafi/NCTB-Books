import Foundation
struct CategoryClassName : Codable {
        let category : String?
        let books : [Books]?

        enum CodingKeys: String, CodingKey {

            case category = "category"
            case books = "Books"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            category = try values.decodeIfPresent(String.self, forKey: .category)
            books = try values.decodeIfPresent([Books].self, forKey: .books)
        }

    }
