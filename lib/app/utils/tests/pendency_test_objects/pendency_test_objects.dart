import '../../../modules/management_module/domain/entities/pendency_entity.dart';

class PendencyTestObjects {
  static final pendency = PendencyEntity(
    pendencyFinished: false,
    pendencyId: "573hweriwf29h382goqe819rgfan",
    annotationId: "235234i5hqoeaighoais34oithqa",
    pendencyPeriod: "Manhã",
    operatorId: "dfskjgali45ut8o87fe793K252K7FdgkdkaGSDK",
  );
  static final newPendency = PendencyEntity(
    pendencyFinished: false,
    annotationId: "235234i5hqoeaighoais34oithqa",
    pendencyPeriod: "Manhã",
    pendencySaleDate: "23/08/2023",
    pendencySaleTime: "11:23",
    operatorId: "dfskjgali45ut8o87fe793K252K7FdgkdkaGSDK",
  );
  static final finishedPendency = PendencyEntity(
    pendencyFinished: true,
    pendencyId: "573hweriwf29h382goqe819rgfan",
    annotationId: "235234i5hqoeaighoais34oithqa",
    pendencyPeriod: "Manhã",
    operatorId: "dfskjgali45ut8o87fe793K252K7FdgkdkaGSDK",
  );
  static final pendencyMap = {
    "pendencyId": "573hweriwf29h382goqe819rgfan",
    "annotationId": "235234i5hqoeaighoais34oithqa",
    "pendencyPeriod": "Manhã",
    "pendencyFinished": false,
    "operatorId": "dfskjgali45ut8o87fe793K252K7FdgkdkaGSDK",
  };
  static final newPendencyMap = {
    "annotationId": "235234i5hqoeaighoais34oithqa",
    "pendencySaleTime": "14:23",
    "pendencySaleDate": "23/08/2023",
    "pendencyFinished": false,
    "operatorId": "dfskjgali45ut8o87fe793K252K7FdgkdkaGSDK",
  };
  static final finisehdPendencyMap = {
    "pendencyId": "573hweriwf29h382goqe819rgfan",
    "annotationId": "235234i5hqoeaighoais34oithqa",
    "pendencyPeriod": "Manhã",
    "pendencyFinished": true,
    "operatorId": "dfskjgali45ut8o87fe793K252K7FdgkdkaGSDK",
  };
}
