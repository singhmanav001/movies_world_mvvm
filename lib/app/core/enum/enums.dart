// ignore_for_file: constant_identifier_names

enum ViewState {
  SHIMMER_STATE,
  NO_INTERNET_STATE,
  LIST_ERROR_STATE,
  LIST_EMPTY_STATE,
  LIST_VIEW_STATE
}

enum PreviousNetStatus { CONNECTED, DISCONNECTED, NONE }

enum ListScrollEnum { UP, DOWN }

enum IconPositionEnum { LEFT, RIGHT }

enum MediaType {
  ASSET_IMAGE,
  ASSET_SVG,
  ASSET_LOTTIE,
  NETWORK_IMAGE,
  NETWORK_SVG,
  NETWORK_LOTTIE,
  ERROR
}
enum ButtonEnum { SMALL, MEDIUM, FULL_WIDTH }