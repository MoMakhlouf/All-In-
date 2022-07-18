//
//  NetworkManagerMock.swift
//  All-InTests
//
//  Created by Mohamed Makhlouf Ahmed on 05/07/2022.
//

import Foundation
 @testable import All_In

enum NetworkError: Error {
    case failedFetchingData
}

class NetworkManagerMock : NetworkManager{
    
    var shouldReturnError : Bool
    
    init(shouldReturnError : Bool){
        self.shouldReturnError = shouldReturnError
    }
    
    
    let jsonResponseCoupon : [String: [[String : Any]]] =
    ["discount_codes":
        [["id":15662475641046,"price_rule_id":1191661535446,"code":"ALLIN5","usage_count":0,"created_at":"2022-07-01T02:14:01+02:00","updated_at":"2022-07-01T02:14:01+02:00"],["id":15662472560854,"price_rule_id":1191661535446,"code":"ALLIN10","usage_count":0,"created_at":"2022-07-01T02:08:12+02:00","updated_at":"2022-07-01T02:08:12+02:00"]
        ]
    ]
    
    
    let jsonAllBrands: [String: [[String: Any]]] = ["smart_collections": [
        [
          "id": 409147113686,
          "handle": "adidas",
          "title": "ADIDAS",
          "updated_at": "2022-06-27T00:00:18+02:00",
          "body_html": "Adidas collection",
          "published_at": "2022-06-26T23:57:22+02:00",
          "sort_order": "best-selling",
          "template_suffix": "",
          "disjunctive": false,
          "rules": [
            [
              "column": "title",
              "relation": "contains",
              "condition": "ADIDAS"
            ]
          ],
          "published_scope": "web",
          "admin_graphql_api_id": "gid://shopify/Collection/409147113686",
          "image": [
            "created_at": "2022-06-26T23:57:22+02:00",
            "alt": "",
            "width": 1000,
            "height": 676,
            "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/97a3b1227876bf099d279fd38290e567.jpg?v=1656280642"
          ]
        ],
        [
          "id": 409147211990,
          "handle": "asics-tiger",
          "title": "ASICS TIGER",
          "updated_at": "2022-06-27T00:05:23+02:00",
          "body_html": "Asics Tiger collection",
          "published_at": "2022-06-26T23:57:25+02:00",
          "sort_order": "best-selling",
          "template_suffix": "",
          "disjunctive": false,
          "rules": [
            [
              "column": "title",
              "relation": "contains",
              "condition": "ASICS TIGER"
            ]
          ],
          "published_scope": "web",
          "admin_graphql_api_id": "gid://shopify/Collection/409147211990",
          "image": [
            "created_at": "2022-06-26T23:57:25+02:00",
            "alt": "",
            "width": 425,
            "height": 220,
            "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/b351cead33b2b72e7177e70512530f09.jpg?v=1656280645"
          ]
        ]
      ]
    ]
    
    
    let jsonProducts: [String:[[String:Any]]] = ["products": [
            [
                "id": 7730623709398,
                "title": "ADIDAS | CLASSIC BACKPACK",
                "body_html": "This women's backpack has a glam look, thanks to a faux-leather build with an allover fur print. The front zip pocket keeps small things within reach, while an interior divider reins in potential chaos.",
                "vendor": "ADIDAS",
                "product_type": "ACCESSORIES",
                "created_at": "2022-06-26T23:56:20+02:00",
                "handle": "adidas-classic-backpack",
                "updated_at": "2022-06-27T00:00:18+02:00",
                "published_at": "2022-06-26T23:56:20+02:00",
                "template_suffix": "",
                "status": "active",
                "published_scope": "web",
                "tags": "adidas, backpack, egnition-sample-data",
                "admin_graphql_api_id": "gid://shopify/Product/7730623709398",
                "variants": [
                  [
                    "id": 43130731823318,
                    "product_id": 7730623709398,
                    "title": "OS / black",
                    "price": "70.00",
                    "sku": "AD-03-black-OS",
                    "position": 1,
                    "inventory_policy": "deny",
                    "compare_at_price": "ull",
                    "fulfillment_service": "manual",
                    "inventory_management": "shopify",
                    "option1": "OS",
                    "option2": "black",
                    "option3": "",
                    "created_at": "2022-06-26T23:56:20+02:00",
                    "updated_at": "2022-06-26T23:57:25+02:00",
                    "taxable": true,
                    "barcode": "",
                    "grams": 0,
                    "image_id": "",
                    "weight": 0,
                    "weight_unit": "kg",
                    "inventory_item_id": 45231424209110,
                    "inventory_quantity": 6,
                    "old_inventory_quantity": 6,
                    "requires_shipping": true,
                    "admin_graphql_api_id": "gid://shopify/ProductVariant/43130731823318"
                  ]
                ],
                "options": [
                  [
                    "id": 9843604816086,
                    "product_id": 7730623709398,
                    "name": "Size",
                    "position": 1,
                    "values": [
                      "OS"
                    ]
                  ],
                  [
                    "id": 9843604848854,
                    "product_id": 7730623709398,
                    "name": "Color",
                    "position": 2,
                    "values": [
                      "black"
                    ]
                  ]
                ],
                "images": [
                  [
                    "id": 37836366086358,
                    "product_id": 7730623709398,
                    "position": 1,
                    "created_at": "2022-06-26T23:56:20+02:00",
                    "updated_at": "2022-06-26T23:56:20+02:00",
                    "alt": "",
                    "width": 635,
                    "height": 560,
                    "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/85cc58608bf138a50036bcfe86a3a362.jpg?v=1656280580",
                    "variant_ids": [],
                    "admin_graphql_api_id": "gid://shopify/ProductImage/37836366086358"
                  ],
                  [
                    "id": 37836366119126,
                    "product_id": 7730623709398,
                    "position": 2,
                    "created_at": "2022-06-26T23:56:20+02:00",
                    "updated_at": "2022-06-26T23:56:20+02:00",
                    "alt": "",
                    "width": 635,
                    "height": 560,
                    "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/8a029d2035bfb80e473361dfc08449be.jpg?v=1656280580",
                    "variant_ids": [],
                    "admin_graphql_api_id": "gid://shopify/ProductImage/37836366119126"
                  ],
                  [
                    "id": 37836366151894,
                    "product_id": 7730623709398,
                    "position": 3,
                    "created_at": "2022-06-26T23:56:20+02:00",
                    "updated_at": "2022-06-26T23:56:20+02:00",
                    "alt": "",
                    "width": 635,
                    "height": 560,
                    "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/ad50775123e20f3d1af2bd07046b777d.jpg?v=1656280580",
                    "variant_ids": [],
                    "admin_graphql_api_id": "gid://shopify/ProductImage/37836366151894"
                  ]
                ],
                "image": [
                  "id": 37836366086358,
                  "product_id": 7730623709398,
                  "position": 1,
                  "created_at": "2022-06-26T23:56:20+02:00",
                  "updated_at": "2022-06-26T23:56:20+02:00",
                  "alt": "",
                  "width": 635,
                  "height": 560,
                  "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/products/85cc58608bf138a50036bcfe86a3a362.jpg?v=1656280580",
                  "variant_ids": [],
                  "admin_graphql_api_id": "gid://shopify/ProductImage/37836366086358"
                ]
              ]
            ]
    ]
    
    
    var jsonCollections: [String:[[String:Any]]] = [
        "custom_collections": [
          [
            "id": 409129779414,
            "handle": "frontpage",
            "title": "Home page",
            "updated_at": "2022-06-26T23:54:30+02:00",
            "body_html": "",
            "published_at": "2022-06-26T15:20:49+02:00",
            "sort_order": "best-selling",
            "template_suffix": "",
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409129779414"
          ],
          [
            "id": 409147539670,
            "handle": "kid",
            "title": "KID",
            "updated_at": "2022-06-27T00:05:24+02:00",
            "body_html": "Collection for kids",
            "published_at": "2022-06-26T23:57:38+02:00",
            "sort_order": "best-selling",
            "template_suffix": "",
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147539670",
            "image": [
              "created_at": "2022-06-26T23:57:38+02:00",
              "alt": "",
              "width": 736,
              "height": 490,
              "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/3b6a545a8f309a6085625bcadcb19712.jpg?v=1656280658"
            ]
          ],
          [
            "id": 409147474134,
            "handle": "men",
            "title": "MEN",
            "updated_at": "2022-07-17T17:35:30+02:00",
            "body_html": "Collection for men ",
            "published_at": "2022-06-26T23:57:35+02:00",
            "sort_order": "best-selling",
            "template_suffix": "",
            "published_scope": "web",
            "admin_graphql_api_id": "gid://shopify/Collection/409147474134",
            "image": [
              "created_at": "2022-06-26T23:57:35+02:00",
              "alt": "",
              "width": 480,
              "height": 200,
              "src": "https://cdn.shopify.com/s/files/1/0659/3796/5270/collections/cde37406b76337f4438c62f57be75df2.jpg?v=1656280655"
            ]
          ]
        ]
      ]
    
    
    var jsonOrders: [String:[[String:Any]]] = ["order": [[
          "id": 4804665213142,
          "admin_graphql_api_id": "gid://shopify/Order/4804665213142",
          "app_id": 2450161665,
          "buyer_accepts_marketing": false,
          "confirmed": true,
          "contact_email": "ahmed12@gmail.com",
          "created_at": "2022-07-18T17:46:52+02:00",
          "currency": "EGP",
          "current_subtotal_price": "140.00",
          "current_subtotal_price_set": [
            "shop_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ]
          ],
          "current_total_discounts": "0.00",
          "current_total_discounts_set": [
            "shop_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ]
          ],
          "current_total_price": "140.00",
          "current_total_price_set": [
            "shop_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ]
          ],
          "current_total_tax": "0.00",
          "current_total_tax_set": [
            "shop_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ]
          ],
          "discount_codes": [],
          "email": "ahmed12@gmail.com",
          "estimated_taxes": false,
          "financial_status": "paid",
          "name": "#1210",
          "note_attributes": [],
          "number": 210,
          "order_number": 1210,
          "order_status_url": "https://ios-q3-mansoura.myshopify.com/65937965270/orders/7000ca82aa53ba29e9d919cef299ac26/authenticate?key=baf7c034d907a9b7ad961f8dfbd56ae8",
          "payment_gateway_names": [],
          "presentment_currency": "EGP",
          "processed_at": "2022-07-18T17:46:52+02:00",
          "processing_method": "",
          "source_name": "2450161665",
          "subtotal_price": "140.00",
          "subtotal_price_set": [
            "shop_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ]
          ],
          "tags": "",
          "tax_lines": [],
          "taxes_included": false,
          "test": false,
          "token": "7000ca82aa53ba29e9d919cef299ac26",
          "total_discounts": "0.00",
          "total_discounts_set": [
            "shop_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ]
          ],
          "total_line_items_price": "140.00",
          "total_line_items_price_set": [
            "shop_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ]
          ],
          "total_outstanding": "140.00",
          "total_price": "140.00",
          "total_price_set": [
            "shop_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "140.00",
              "currency_code": "EGP"
            ]
          ],
          "total_price_usd": "7.42",
          "total_shipping_price_set": [
            "shop_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ]
          ],
          "total_tax": "0.00",
          "total_tax_set": [
            "shop_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ],
            "presentment_money": [
              "amount": "0.00",
              "currency_code": "EGP"
            ]
          ],
          "total_tip_received": "0.00",
          "total_weight": 0,
          "updated_at": "2022-07-18T17:46:52+02:00",
          "customer": [
            "id": 6280692859094,
            "email": "ahmed12@gmail.com",
            "accepts_marketing": false,
            "created_at": "2022-07-18T17:43:26+02:00",
            "updated_at": "2022-07-18T17:46:52+02:00",
            "first_name": "Ahmed",
            "last_name": "12",
            "orders_count": 2,
            "state": "disabled",
            "total_spent": "280.00",
            "last_order_id": 4804665213142,
            "verified_email": true,
            "tax_exempt": false,
            "tags": "123456",
            "last_order_name": "#1210",
            "currency": "EGP",
            "accepts_marketing_updated_at": "2022-07-18T17:43:26+02:00",
            "tax_exemptions": [],
    
            "admin_graphql_api_id": "gid://shopify/Customer/6280692859094",
            "default_address": [
              "id": 7774907269334,
              "customer_id": 6280692859094,
              "first_name": "Ahmed 12",
              "last_name": "",
              "address1": "street2",
              "city": "Alexandria",
              "province": "",
              "country": "Egypt",
              "zip": "",
              "phone": "01234567890",
              "name": "Ahmed 12",
              "country_code": "EG",
              "country_name": "Egypt",
      
            ]
          ],
          "discount_applications": [],
          "fulfillments": [],
          "line_items": [
            [
              "id": 12236365594838,
              "admin_graphql_api_id": "gid://shopify/LineItem/12236365594838",
              "fulfillable_quantity": 2,
              "fulfillment_service": "manual",
              "gift_card": false,
              "grams": 0,
              "name": "ADIDAS | CLASSIC BACKPACK",
              "price": "70.00",
              "price_set": [
                "shop_money": [
                  "amount": "70.00",
                  "currency_code": "EGP"
                ],
                "presentment_money": [
                  "amount": "70.00",
                  "currency_code": "EGP"
                ]
              ],
              "product_exists": false,
              "properties": [],
              "quantity": 2,
              "requires_shipping": true,
              "taxable": true,
              "title": "ADIDAS | CLASSIC BACKPACK",
              "total_discount": "0.00",
              "total_discount_set": [
                "shop_money": [
                  "amount": "0.00",
                  "currency_code": "EGP"
                ],
                "presentment_money": [
                  "amount": "0.00",
                  "currency_code": "EGP"
                ]
              ],
              "tax_lines": [],
              "duties": [],
              "discount_allocations": []
            ]
          ],
          "refunds": [],
          "shipping_lines": []
        ]
      ]
    ]
                

    
    
    
    
    
    func fetchCodes(completion : @escaping (([Discount_codes]? , Error?) -> Void)){
        
        switch shouldReturnError {
        case true : completion(nil , NetworkError.failedFetchingData)
        
        case false :
            if let data = try? JSONSerialization.data(withJSONObject: jsonResponseCoupon, options: .fragmentsAllowed) {
                   if let decodedData = try? JSONDecoder().decode(DiscountCode.self, from: data){
                       completion(decodedData.discount_codes , nil)
                      
                   }else{
                       completion(nil, NetworkError.failedFetchingData)
                     
                   }
                   }
            else {
               completion(nil, NetworkError.failedFetchingData)
            }
        }
    }
                                                  
    func fetchBrand(completion : @escaping ((SmartCollections? , Error?) -> Void)){
        switch shouldReturnError{
        case true: completion(nil, NetworkError.failedFetchingData)
        case false:
            if let data = try? JSONSerialization.data(withJSONObject: jsonAllBrands, options: .fragmentsAllowed) {
                let json = JSONDecoder()
                if let  decodedData  = try? json.decode(SmartCollections.self, from: data){
                completion(decodedData, nil)
                    
                } else { completion(nil, NetworkError.failedFetchingData) }
            }else { completion(nil, NetworkError.failedFetchingData) }
            
        }
    }
    
    func fetchProduct(completion : @escaping ((Products? , Error?) -> Void)){
        switch shouldReturnError{
        case true: completion(nil, NetworkError.failedFetchingData)
        case false:
            if let data = try? JSONSerialization.data(withJSONObject: jsonAllBrands, options: .fragmentsAllowed) {
                let json = JSONDecoder()
                if let  decodedData  = try? json.decode(Products.self, from: data){
                completion(decodedData, nil)
                    
                } else { completion(nil, NetworkError.failedFetchingData) }
            }else { completion(nil, NetworkError.failedFetchingData) }
            
        }
    }
    
    
    func fetchCollections(completion : @escaping ((CustomCollections? , Error?) -> Void)){
        switch shouldReturnError{
        case true: completion(nil, NetworkError.failedFetchingData)
        case false:
            if let data = try? JSONSerialization.data(withJSONObject: jsonAllBrands, options: .fragmentsAllowed) {
                let json = JSONDecoder()
                if let  decodedData  = try? json.decode(CustomCollections.self, from: data){
                completion(decodedData, nil)
                    
                } else { completion(nil, NetworkError.failedFetchingData) }
            }else { completion(nil, NetworkError.failedFetchingData) }
            
        }
    }
    
    func fetchOrders(completion : @escaping ((Orders? , Error?) -> Void)){
        switch shouldReturnError{
        case true: completion(nil, NetworkError.failedFetchingData)
        case false:
            if let data = try? JSONSerialization.data(withJSONObject: jsonAllBrands, options: .fragmentsAllowed) {
                let json = JSONDecoder()
                if let  decodedData  = try? json.decode(Orders.self, from: data){
                completion(decodedData, nil)
                } else { completion(nil, NetworkError.failedFetchingData) }
            }else { completion(nil, NetworkError.failedFetchingData) }
            
        }
    }
    
    
    
    
}

