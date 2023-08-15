import '../../../modules/management_module/domain/entities/pendency_entity.dart';

class PendencyTestObjects {
  static final pendency = PendencyEntity(
    pendencyFinished: false,
    pendencyId: "573hweriwf29h382goqe819rgfan",
    annotationId: "235234i5hqoeaighoais34oithqa",
    pendencyPeriod: "Manhã",
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
    "operatorId": "dfskjgali45ut8o87fe793K252K7FdgkdkaGSDK",
  };
}
