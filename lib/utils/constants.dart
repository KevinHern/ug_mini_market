// UI Imports
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

// Models
import 'package:ug_mini_market/domain/models/product.dart';
import 'package:ug_mini_market/domain/models/app_notification.dart';
import '../domain/models/ug_user.dart';
import '../domain/models/app_request.dart';
import '../ui/filter_models/market_products_filter.dart';
import '../ui/filter_models/notifications_filter.dart';
import '../ui/filter_models/requests_filter.dart';

enum Faculty { FISSIC, FACTI, FABIQ, LASI, FACOM }

enum NotificationType { INFO, CANCEL, IMPORTANT, CONFIRM }

enum RequestType { PURCHASE, SELL }

enum RequestStatus { APPROVED, REJECTED, ON_GOING }

class FilterChipModel {
  static const List<String> notificationTypesLabels = const [
        "Confirmada",
        "Importante",
        "Información",
        "Rechazada",
      ],
      requestStatusLabels = const [
        "Aprobada",
        "En Curso",
        "Rechazada",
      ];

  final List<String> labels, selectedLabels;
  final List<bool> selectedValues;

  FilterChipModel({
    required this.labels,
    this.selectedLabels = const <String>[],
  }) : selectedValues = <bool>[] {
    for (int i = 0; i < labels.length; i++) {
      selectedValues.add(selectedLabels.contains(labels[i]));
    }
  }

  // Getters
  bool get onlyOneOptionRemaining =>
      selectedValues.where((element) => element).toList().length == 1;

  // Functions
  void discernSelectedValues() {
    for (int i = 0; i < labels.length; i++) {}
  }
}

class ChoiceChipModel {
  static const List<String> displayListBlockLabels = const [
        "En Bloques",
        "En Lista"
      ],
      negotiableLabels = const ["No Negociable", "Negociable"],
      notificationStatusLabels = const ["Leída", "Sin Ver", "Ambas"],
      myRoleLabels = const ["Comprador(a)", "Vendedor(a)", "Ambas"],
      requestSortModeLabels = const [
        "Mas Antiguos Primero",
        "Mas Recientes Primero"
      ];

  final List<String> labels;
  int? selectedLabel;

  ChoiceChipModel({
    required this.labels,
    this.selectedLabel,
  });
}

class UGFaculties {
  static const List<String> faculties = const [
    "FISSIC",
    "FACTI",
    "FABIQ",
    "LASI",
    "FACOM"
  ];

  static Faculty mapIntToEnum({required int faculty}) =>
      Faculty.values[faculty];
  static Faculty mapStringToEnum({required String faculty}) =>
      Faculty.values[faculties.indexOf(faculty)];
  static String mapEnumToString({required Faculty faculty}) =>
      faculties[faculty.index];
}

class ProductCategories {
  static const List<String> categories = const [
    "Electronica",
    "Dibujo Tecnico",
    "Quimica",
    "Carpinteria",
    "Metales",
    "Cálculo",
    "Herramientas",
    "Utiles",
    "Otros",
  ];
}

class ScreenBreakPoints {
  static const small = Breakpoints.small as WidthPlatformBreakpoint;
  static const medium = Breakpoints.medium as WidthPlatformBreakpoint;
  static const large = Breakpoints.large as WidthPlatformBreakpoint;
  static const largeAlternative = WidthPlatformBreakpoint(begin: 840, end: 960);
  static const extraLarge = WidthPlatformBreakpoint(begin: 960);
}

const List<dynamic> menuOptions = [
  const ["Inbox", Icons.inbox_rounded],
  const ["Solicitudes", Icons.request_page_rounded],
  const ["Mis Productos", Icons.shop_rounded],
  const ["Mercado", Icons.shopping_cart_rounded],
  const ["Historial", Icons.history_rounded],
  const ["Bookmark", Icons.bookmarks_rounded],
];

const int acceptedNumberDecimals = 2;

const double topActionBarHeight = 65.0;

// Padding constants
const double padding = 8.0, screenPadding = 16.0, dividerIndentPadding = 15.0;

const double scrollHorizontalPaddingMultiplier = 2,
    listTextPaddingMultiplier = 3,
    topActionBarPaddingMultiplier = 4,
    formPaddingMultiplier = 3,
    formButtonsPaddingMultiplier = 5,
    dividerIndentListViewPaddingMultiplier = 1.5,
    filterChipMultiSelectionPaddingMultiplier = 2.5,
    gridViewPaddingMultiplier = 2,
    gridCrossAxisProductThumbnailSpacingMultiplier = 2,
    gridMainAxisProductThumbnailSpacingMultiplier = 2,
    avatarIconPaddingMultiplier = 3,
    avatarPaddingMultiplier = 8;

// Grid count constants
const int gridViewProductThumbnailSmallCount = 2,
    gridViewProductThumbnailMediumCount = 3,
    gridViewProductThumbnailLargeAlternativeCount = 3,
    gridViewProductThumbnailExtraLargeCount = 5;

const int gridViewFilterChipSmallCount = 3,
    gridViewFilterChipMediumCount = 4,
    gridViewFilterChipLargeAlternativeCount = 6,
    gridViewFilterChipExtraLargeCount = 9;

// Dummy Variables
final dummyProductsFilter = ProductsFilter(displayAsBlocks: true);
final dummyRequestsFilter = RequestsFilter(sortNewest: true);
final dummyNotificationsFilter = NotificationsFilter();

final dummyInfoNotification = InfoNotification(
  notificationTitle: "Solicitud Aprobada",
  description: "<Usuario> ha aprobado tu solicitud del producto ABC",
  timestamp: 123456789,
  read: false,
);

final dummyImportantNotification = ImportantNotification(
  notificationTitle: "Compra",
  description: "<Usuario> solicitado tu producto ZYX",
  timestamp: 123456789,
  read: false,
);

final dummyConfirmNotification = ConfirmNotification(
  notificationTitle: "Confirmación de Transacción",
  description: "La compra/venta del producto ABC ha sido confirmada",
  timestamp: 123456789,
  read: false,
);

final dummyRejectNotification = RejectNotification(
  notificationTitle: "Solicitud Rechazada",
  description:
      "<Usuario> ha rechazado tu solicitud del producto ABC\nTu has rechazado la solicitud a <Usuario> de tu producto ABC",
  timestamp: 123456789,
  read: false,
);

final dummyUGUser = UGUser(
  names: "Dummy Dummy",
  lastNames: "McDummy Redummy",
  email: "someemail@galileo.edu",
  faculty: 1,
  id: 12004455,
  rating: 3.6,
);

final dummyUGProduct = UGProduct(
  name: "Product Name asdfasdfasdfasd",
  description:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lacus ex, hendrerit imperdiet velit in, bibendum sollicitudin purus. Suspendisse id massa eget nibh hendrerit dignissim. Quisque mollis sagittis justo ut consectetur. Suspendisse odio tortor, fringilla sed tortor a, vestibulum tincidunt massa. Quisque mattis sem gravida aliquam convallis. Fusce tempor elit non aliquet malesuada. Nullam nec tempor ligula, sit amet sagittis libero.",
  details:
      "Fusce lorem metus, auctor ut lacus quis, accumsan lobortis erat. Nulla rhoncus fermentum viverra. Ut finibus felis congue dui tincidunt, eu consectetur ex vestibulum.",
  categories: [
    "Electronica",
    "Herramientas",
    "Otros",
  ],
  quantity: 123,
  price: 50.0,
  negotiable: true,
);

final dummySellAppRequest = SellRequest(
  requestStatus: RequestStatus.APPROVED,
  notificationTitle: "Venta",
  description: "<Usuario> ha solicitado tu product XYZ",
  timestampCreation: 123456789,
  place:
      "Insert some awesome and beautiful place in this short multiline space form input field",
  timestampMeeting: 123456789,
  timestampLastModification: 123456789,
);

final dummyPurchaseAppRequest = PurchaseRequest(
  requestStatus: RequestStatus.ON_GOING,
  notificationTitle: "Compra",
  description: "Tu has solicitado el product XYZ a <Usuario>",
  timestampCreation: 123456789,
  place:
      "Insert some awesome and beautiful place in this short multiline space form input field",
  timestampMeeting: 123456789,
  timestampLastModification: 123456789,
);

final List<AppRequest> dummyRequests = [
  dummyPurchaseAppRequest,
  dummyPurchaseAppRequest,
  dummyPurchaseAppRequest,
  dummySellAppRequest,
  dummySellAppRequest,
  dummySellAppRequest,
  dummyPurchaseAppRequest,
  dummyPurchaseAppRequest,
  dummySellAppRequest,
  dummySellAppRequest,
  dummyPurchaseAppRequest,
  dummySellAppRequest,
  dummyPurchaseAppRequest,
  dummySellAppRequest,
  dummyPurchaseAppRequest,
  dummySellAppRequest,
];

final List<UGProduct> dummyProducts = [
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
  dummyUGProduct,
];

final List<AppNotification> dummyAppNotifications = [
  dummyInfoNotification,
  dummyImportantNotification,
  dummyImportantNotification,
  dummyConfirmNotification,
  dummyImportantNotification,
  dummyInfoNotification,
  dummyInfoNotification,
  dummyImportantNotification,
  dummyImportantNotification,
  dummyInfoNotification,
  dummyImportantNotification,
  dummyRejectNotification,
  dummyRejectNotification,
  dummyImportantNotification,
];
