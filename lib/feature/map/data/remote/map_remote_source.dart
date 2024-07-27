import 'package:cooki/common/extension/graphql_extensions.dart';
import 'package:cooki/feature/map/data/model/coordinates.dart';
import 'package:cooki/feature/map/data/model/map_details.dart';
import 'package:cooki/feature/beacon/data/model/entity/beacon_details.dart';
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

  // TODO: Integrate API call
  // Future<List<Coordinates>> getDirections(GetDirectionsInput input) async {
  //   final response = await _client.mutate(
  //     MutationOptions(
  //       document: gql(_getDirectionsMutation),
  //       variables: {
  //         'input': input.toJson(),
  //       },
  //     ),
  //   );

  //   return response.result(
  //     onSuccess: (data) {
  //       final result = data['getDirections'] as List<dynamic>;

  //       return result
  //           .map(
  //             (coordinates) => Coordinates.fromJson(coordinates),
  //           )
  //           .toList();
  //     },
  //   );
  // }
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

// const _getDirectionsMutation = r'''
//   mutation getDirections($input: GetDirectionsInput!) {
//     getDirections(dto: $input) {
//       x
//       y
//     }
//   }
// ''';
