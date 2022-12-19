import 'package:metch/domain/models/resource.dart';

abstract class ResourceRepository{
  const ResourceRepository();

  Future<List<Resource>> getResource(List<int> id);
}