import UIKit

let usersJsonData1 = """
[
    {
        "id": 1,
        "name": "Mario",
        "age": 26,
    },
    {
        "id": 2,
        "name": "Bowser",
        "age": 34,
    }
]
""".data(using: .utf8)!

// MARK: - 普通のJSONのデコード処理

struct SimpleUserResponse: Decodable {
    let id: Int
    let name: String
    let age: Int
}

let simpleUsersResponse = try JSONDecoder().decode([SimpleUserResponse].self, from: usersJsonData1)
dump(simpleUsersResponse)


// MARK: - フラットなJSONをネストしたモデルでデコードする

let usersJsonData2 = """
[
    {
        "id": 1,
        "name": "Mario",
        "age": 26,
        "introduction": "It's me!",
        "is_favorite": true,
    },
    {
        "id": 2,
        "name": "Bowser",
        "age": 34,
        "introduction": "Gwah ha ha ha!",
        "is_favorite": false,
    }
]
""".data(using: .utf8)!

/// ユーザの詳細情報をまとめたモデル
struct DetailAttrResponse: Decodable {
    let introduction: String
    let is_favorite: Bool
}
struct DetailUserResponse: Decodable {
    let simpleUser: SimpleUserResponse
    let userDetail: DetailAttrResponse

    init(from decoder: Decoder) throws {
        self.simpleUser = try SimpleUserResponse(from: decoder)
        self.userDetail = try DetailAttrResponse(from: decoder)
    }
}

let detailUsersResponse = try JSONDecoder().decode([DetailUserResponse].self, from: usersJsonData2)
dump(detailUsersResponse)
