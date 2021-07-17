import 'package:graphql/client.dart';

class Repository {
  static String key = "";
  static GraphQLClient client;
  static String endpoint =
      "https://npsup7t6pvhy5mrtly3xuov55m.appsync-api.us-east-2.amazonaws.com/graphql";

  static initClient() async {
    final _httpLink = HttpLink(endpoint, defaultHeaders: {"x-api-key": key});

    client = GraphQLClient(
      cache: GraphQLCache(),
      link: _httpLink,
    );
  }

  static Future<QueryResult> _runQuery(String query) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: <String, dynamic>{},
    );
    final QueryResult result = await client.query(options);
    return result;
  }
}
