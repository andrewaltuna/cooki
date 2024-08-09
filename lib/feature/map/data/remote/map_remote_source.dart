import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/feature/map/data/model/input/product_directions_input.dart';
import 'package:cooki/feature/map/data/model/map_details.dart';
import 'package:cooki/feature/beacon/data/model/entity/beacon_details.dart';
import 'package:cooki/feature/map/data/model/nearby_sections_details.dart';
import 'package:cooki/feature/product/data/remote/product_remote_source.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MapRemoteSource {
  const MapRemoteSource(this._client);

  final GraphQLClient _client;

  Future<MapDetails> getMapDetails() async {
    final response = await _client.query(
      QueryOptions(
        document: gql(_getMapDetailsQuery),
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['getMapDetails'] as Map<String, dynamic>;

        return MapDetails.fromJson(result);
      },
    );
  }

  Future<Coordinates> getUserPosition(List<BeaconDetails> input) async {
    final response = await _client.query(
      QueryOptions(
        document: gql(_getUserPositionQuery),
        variables: {
          'input': input.map((beacon) => beacon.toJson()).toList(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['getUserPosition'] as Map<String, dynamic>;

        return Coordinates.fromJson(result);
      },
    );
  }

  Future<Directions> getProductDirections(
    ProductDirectionsInput input,
  ) async {
    final response = await _client.query(
      QueryOptions(
        document: gql(_getProductDirections),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['getProductDirections'] as List;

        return result
            .map(
              (coordinates) => Coordinates.fromJson(coordinates),
            )
            .toList();
      },
    );
  }

  Future<NearbySectionsDetails> getNearbySections(
    Coordinates input,
  ) async {
    final response = await _client.query(
      QueryOptions(
        document: gql(_getNearbySectionsQuery),
        variables: {
          'input': input.toJson(),
        },
      ),
    );

    return response.result(
      onSuccess: (data) {
        final result = data['getNearestSections'];

        return NearbySectionsDetails.fromJson(result);
      },
    );
  }
}

const _getMapDetailsQuery = r'''
  query getMapDetails {
    getMapDetails {
      width
      height
      pointsOfInterest
    }
  }
''';

const _getUserPositionQuery = r'''
  query getUserPosition($input: [UserPositionInput!]!) {
    getUserPosition(beacons: $input) {
      x
      y
    }
  }
''';

const _getProductDirections = r'''
  query GetProductDirections($input: GetProductDirectionsArgs!) {
    getProductDirections(getProductDirectionsArgs: $input) {
      x
      y
    }
  }
''';

const _getNearbySectionsQuery = productsOutputFragment +
    r'''
      query getNearbySections($input: PositionInput!) {
        getNearestSections(currentPosition: $input) {
          section
          products {
            ...ProductsOutputFragment
          }
        }
      }
    ''';
