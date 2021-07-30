import 'dart:math';

import 'package:dio/dio.dart' as req;
import 'package:double_up/models/business.dart';
import 'package:double_up/models/business_type.dart';
import 'package:double_up/models/category.dart';
import 'package:double_up/models/customer.dart';
import 'package:double_up/models/notification.dart';
import 'package:double_up/models/product.dart';
import 'package:double_up/models/send_card_data.dart';
import 'package:double_up/models/transaction.dart';
import 'package:double_up/singleton/user_singleton.dart';
import 'package:graphql/client.dart';

class Repository {
  static String key = "";
  static GraphQLClient client;
  static req.Dio dio = req.Dio();
  static String endpoint =
      "https://npsup7t6pvhy5mrtly3xuov55m.appsync-api.us-east-2.amazonaws.com/graphql";
  static String discount =
      "https://4j06qhxu9k.execute-api.us-east-2.amazonaws.com/default/Calculate-Discount";

  static String sendCard =
      "https://dl5faox7f5.execute-api.us-east-2.amazonaws.com/default/BlinkSky-Send";

  static String updatePoints =
      "https://1zz46g9639.execute-api.us-east-2.amazonaws.com/default/update-balance";

  static initClient() {
    final _httpLink = HttpLink(endpoint, defaultHeaders: {"x-api-key": key});
    client = GraphQLClient(
      cache: GraphQLCache(),
      link: _httpLink,
    );
  }

  static Future<Map<String, dynamic>> redeemPoints(String transactionID) async {
    req.Response response = await dio.post(discount,
        data: {"id": transactionID, "user": UserSingleton.userId});
    print(response.data);
    return response.data["body"];
  }

  static Future<Transaction> generateRandomTransaction() async {
    int date = DateTime.now().toUtc().microsecondsSinceEpoch;
    date = date ~/ 1000;
    Random random = Random();

    List<Business> businesses = await getBusinesses();
    Business business = businesses[random.nextInt(businesses.length)];
    List<Product> products = await searchProductsByBusiness(business.id);
    int count = random.nextInt(products.length);
    if (count == 0) count++;

    List<Product> randomProducts = [];
    List<String> quantity = [];

    for (int i = 0; i < count; i++) {
      randomProducts.add(products[i]);
      quantity.add((random.nextInt(5) + 1).toString());
    }

    String quantityStr = parseList(quantity, (String result) {
      return result;
    });
    String productStr = parseList(randomProducts, (Product result) {
      return result.id;
    });

    String mutation = """
                        mutation MyMutation {
                      createTransaction(input: {quantity: $quantityStr, products: $productStr, business: "${business.id}", date: $date}) {
                            id
                            points
                            date
                            quantity
                            redeemed
                            products {
                              id
                              images
                              name
                              price
                              category {
                                id
                                name
                                color
                              }
                              threshold
                            }
                            business {
                              id
                              name
                            }
                      }
                    }
     """;
    QueryResult result = await _runMutation(mutation);
    return Transaction.fromJson(result.data["createTransaction"]);
  }

  static parseList(List<dynamic> objects, dynamic function) {
    String list = "[";
    for (dynamic obj in objects) {
      list += '"';
      list += function(obj);
      list += '",';
    }
    list += "]";
    return list;
  }

  static Future<Map<String, dynamic>> addPoints(String points) async {
    req.Response response = await dio.post(updatePoints,
        data: {"id": UserSingleton.userId, "amount": points});
    print(response.data);
    return response.data["body"];
  }

  static Future<Map<String, dynamic>> sendGiftCard(SendCardData data) async {
    req.Response response = await dio.post(sendCard, data: data);
    return response.data["body"];
  }

  static Future<QueryResult> _runQuery(String query) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
      variables: <String, dynamic>{},
    );
    final QueryResult result = await client.query(options);
    return result;
  }

  static Future<QueryResult> _runMutation(String mutation) async {
    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: <String, dynamic>{},
    );
    final QueryResult result = await client.mutate(options);
    return result;
  }

  static Future<List<Category>> getCategories() async {
    String query = """
                      query MyQuery {
                        listCategories {
                          items {
                            code
                            family
                            id
                            color
                            image
                            name
                          }
                        }
                      }                       
    """;
    QueryResult result = await _runQuery(query);
    List<Category> categories = [];
    for (dynamic item in result.data["listCategories"]["items"]) {
      Category category = Category.fromJson(item);
      categories.add(category);
    }
    return categories;
  }

  static Future<List<Product>> getProducts(int limit) async {
    String query = """
                      query MyQuery {
                        listProducts(limit: null,) {
                          items {
                            business {
                              category {
                                  color
                                  id
                                  title
                              }
                              description
                              id
                              image
                              name
                              x
                              y
                            }
                            category {
                              code
                              family
                              color
                              id
                              image
                              name
                            }
                            description
                            id
                            images
                            name
                            price
                            threshold
                          }
                          nextToken
                        }
                      }               
    """;
    QueryResult result = await _runQuery(query);
    List<Product> objects = [];
    for (dynamic item in result.data["listProducts"]["items"]) {
      Product obj = Product.fromJson(item);
      objects.add(obj);
    }
    objects.sort((b, a) => a.threshold.compareTo(b.threshold));

    return objects;
  }

  static Future<List<Product>> getProductByCategory(
      String id, int limit) async {
    String query = """
                      query MyQuery {
                        listProducts(filter: {category: {eq: "$id"}}) {
                          items {
                            business {
                              address
                              category {
                                  color
                                  id
                                  title
                              }
                              description
                              id
                              image
                              name
                              x
                              y
                            }
                            category {
                              code
                              family
                              id
                              color
                              image
                              name
                            }
                            description
                            id
                            images
                            price
                            name
                            threshold
                          }
                        }
                      }              
    """;
    QueryResult result = await _runQuery(query);
    List<Product> objects = [];
    for (dynamic item in result.data["listProducts"]["items"]) {
      Product obj = Product.fromJson(item);
      objects.add(obj);
    }
    print(objects);
    objects.sort((b, a) => a.threshold.compareTo(b.threshold));

    return objects;
  }

  static Future<List<Business>> getBusinesses() async {
    String query = """
                          query MyQuery {
                            listBusinesses {
                              items {
                                category {
                                  color
                                  id
                                  title
                                }
                                description
                                id
                                image
                                name
                                x
                                y
                                address
                              }
                            }
                          }             
    """;
    QueryResult result = await _runQuery(query);
    List<Business> objects = [];
    for (dynamic item in result.data["listBusinesses"]["items"]) {
      Business obj = Business.fromJson(item);
      objects.add(obj);
    }
    return objects;
  }

  static Future<List<AppNotifications>> getNotifications(String id) async {
    String query = """
                    query MyQuery {
                      listNotifications(filter: {userId: {eq: "$id"}}) {
                        nextToken
                        items {
                          id
                          location
                          message
                          read
                        }
                      }
                    }     
    """;
    QueryResult result = await _runQuery(query);
    List<AppNotifications> objects = [];
    for (dynamic item in result.data["listNotifications"]["items"]) {
      AppNotifications obj = AppNotifications.fromJson(item);
      objects.add(obj);
    }
    return objects;
  }

  static Future<List<Product>> searchProducts(String search, int limit) async {
    String query = """
              query MyQuery {
                listProducts(limit: $limit, filter: {name: {contains: "$search"}}) {
                  items {
                    threshold
                    sales
                    price
                    name
                    max
                    min
                    loss
                    images
                    id
                    description
                    category {
                      code
                      family
                      id
                      color
                      image
                      name
                    }
                    business {
                      address
                      description
                      id
                      image
                      name
                      x
                      y
                      category {
                        color
                        id
                        title
                      }
                    }
                  }
                }
              }    
    """;
    QueryResult result = await _runQuery(query);
    List<Product> objects = [];
    for (dynamic item in result.data["listProducts"]["items"]) {
      Product obj = Product.fromJson(item);
      objects.add(obj);
    }
    objects.sort((b, a) => a.threshold.compareTo(b.threshold));

    return objects;
  }

  static Future<List<Business>> searchBusinesses(
      String search, int limit) async {
    String query = """
                  query MyQuery {
                    listBusinesses(filter: {name: {contains: "$search"}}, limit: $limit) {
                      items {
                        address
                        category {
                                  color
                                  id
                                  title
                        }
                        description
                        id
                        name
                        image
                        x
                        y
                      }
                    }
                  }  
    """;
    QueryResult result = await _runQuery(query);
    List<Business> objects = [];
    for (dynamic item in result.data["listBusinesses"]["items"]) {
      Business obj = Business.fromJson(item);
      objects.add(obj);
    }
    return objects;
  }

  static updateFavProducts(List<Product> cards, String userId) async {
    String list = "[";
    for (Product card in cards) {
      list += '"';
      list += card.id;
      list += '",';
    }
    list += "]";

    String mutation = """ 
                            mutation MyMutation {
                              updateCustomer(input: {id: "$userId", fav_products: $list}) {
                                id
                              }
                            }
    """;
    QueryResult result = await _runMutation(mutation);
    return result.data["updateCustomer"]["id"];
  }

  static updateFavCards(List<int> cards, String userId) async {
    String mutation = """ 
                            mutation MyMutation {
                              updateCustomer(input: {id: "$userId", fav_cards: $cards}) {
                                fav_cards
                                id
                              }
                            }
    """;
    QueryResult result = await _runMutation(mutation);
    return result.data["updateCustomer"]["id"];
  }

  static Future<List<Product>> searchProductsByBusiness(String search) async {
    String query = """
                          query MyQuery {
                            listProducts(filter: {business: {eq: "$search"}}) {
                              items {
                                threshold
                                sales
                                price
                                name
                                max
                                min
                                loss
                                images
                                id
                                description
                                category {
                                  code
                                  family
                                  color
                                  id
                                  image
                                  name
                                }
                                business {
                                  address
                                  description
                                  id
                                  image
                                  name
                                  x
                                  y
                                  category {
                                    color
                                    id
                                    title
                                  }
                                }
                              }
                            }
                          }  
    """;
    QueryResult result = await _runQuery(query);
    List<Product> objects = [];
    for (dynamic item in result.data["listProducts"]["items"]) {
      Product obj = Product.fromJson(item);
      objects.add(obj);
    }
    objects.sort((b, a) => a.threshold.compareTo(b.threshold));

    return objects;
  }

  static Future<List<BusinessType>> getBusinessType() async {
    String query = """ 
                      query MyQuery {
                    listBusinessTypes {
                      items {
                        color
                        id
                        title
                      }
                    }
                  }
    """;
    QueryResult result = await _runQuery(query);
    List<BusinessType> objects = [];
    for (dynamic item in result.data["listBusinessTypes"]["items"]) {
      BusinessType obj = BusinessType.fromJson(item);
      objects.add(obj);
    }
    return objects;
  }

  static Future<String> createUser(String name) async {
    String balance = "5";
    String picture = "https://source.unsplash.com/random";
    String mutation = """ 
                    mutation MyMutation {
                  createCustomer(input: {balance: $balance, cards: [], fav_cards: [], fav_products: [], history: [], name: "$name", picture: "$picture", prefs: []}) {
                    id
                  }
                }
    """;
    QueryResult result = await _runMutation(mutation);
    return result.data["createCustomer"]["id"];
  }

  static Future<List<Transaction>> getTransactionHistory(String userId) async {
    String query = """
                  query MyQuery {
                    listTransactions(filter: {customer: {eq: "$userId"}}) {
                      items {
                        id
                        business {
                          id
                          name
                          image
                        }
                        points
                        customer {
                          id
                          name
                          balance
                          cards
                          fav_cards
                          picture
                        }
                        quantity
                        date
                        redeemed
                      }
                    }
                  }
    """;
    QueryResult result = await _runQuery(query);
    List<Transaction> objects = [];
    for (dynamic item in result.data["listTransactions"]["items"]) {
      Transaction obj = Transaction.fromJson(item);
      objects.add(obj);
    }
    return objects;
  }

  static getUser(String id) async {
    String query = """
  query MyQuery {
                          getCustomer(id: "$id") {
                            cards
                            balance
                            fav_cards
                            fav_products {
                              business {
                                description
                                id
                                image
                                name
                                x
                                y
                              }
                              category {
                                code
                                family
                                id
                                color
                                image
                                name
                              }
                              description
                              id
                              images
                              price
                              name
                              threshold
                            }
                            history {
                              id
                              products {
                                business {
                                  description
                                  id
                                  image
                                  name
                                  x
                                  y
                                }
                                description
                                id
                                images
                                name
                                price
                                threshold
                              }
                              quantity
                            }
                            name
                            id
                            picture
                            prefs {
                              code
                              family
                              id
                              image
                              name
                            }
                          }

                      }    
    """;

    QueryResult result = await _runQuery(query);
    return Customer.fromJson(result.data["getCustomer"]);
  }
}
