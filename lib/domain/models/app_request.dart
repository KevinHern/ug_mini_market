// Utils
import 'package:intl/intl.dart';
import '../../utils/constants.dart';

abstract class AppRequest {
  final String _notificationTitle, _description;
  final int _timestampCreation;
  String _place;
  int _timestampMeeting, _timestampLastModification;
  String? _firestoreId;

  final RequestType _requestType;
  RequestStatus _requestStatus;
  AppRequest(
      {required RequestType requestType,
      required RequestStatus requestStatus,
      required String notificationTitle,
      required String description,
      required String place,
      required int timestampCreation,
      required int timestampMeeting,
      required int timestampLastModification,
      String? firestoreId})
      : _requestType = requestType,
        _requestStatus = requestStatus,
        _notificationTitle = notificationTitle,
        _description = description,
        _place = place,
        _timestampCreation = timestampCreation,
        _timestampMeeting = timestampMeeting,
        _timestampLastModification = timestampLastModification,
        _firestoreId = firestoreId;

  // Setters
  set timestampMeeting(value) => _timestampMeeting = value;
  set timestampLastModification(value) => _timestampLastModification = value;
  set place(value) => _place = value;

  // Getters
  String get title => _notificationTitle;
  String get description => _description;
  int get timestampCreation => _timestampCreation;
  int get timestampMeeting => _timestampMeeting;
  int get timestampLastModification => _timestampLastModification;
  String get place => _place;

  // Complex Getters
  String get dateRequestCreation =>
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  String get dateMeeting => DateFormat('dd/MM/yyyy')
      .format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecond));
  String get timeMeeting => DateFormat('HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecond));
  String get lastModification => DateFormat('dd/MM/yyyy, HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecond));
  String get requestStatus {
    switch (_requestStatus) {
      case RequestStatus.APPROVED:
        return "APROBADA";
      case RequestStatus.REJECTED:
        return "RECHAZADA";
      case RequestStatus.ON_GOING:
        return "EN CURSO";
      default:
        return "Unexpected Request Status";
    }
  }

  String get icon;
}

class SellRequest extends AppRequest {
  SellRequest(
      {required super.requestStatus,
      required super.notificationTitle,
      required super.description,
      required super.timestampCreation,
      required super.place,
      required super.timestampMeeting,
      required super.timestampLastModification,
      super.firestoreId})
      : super(requestType: RequestType.SELL);

  @override
  String get icon => "sell_40p.png";
}

class PurchaseRequest extends AppRequest {
  PurchaseRequest(
      {required super.requestStatus,
      required super.notificationTitle,
      required super.description,
      required super.timestampCreation,
      required super.place,
      required super.timestampMeeting,
      required super.timestampLastModification,
      super.firestoreId})
      : super(requestType: RequestType.PURCHASE);

  @override
  String get icon => "purchase_40p.png";
}
