enum OrdersOnProccessState {INIT , LOADING ,LOADED ,ERROR}
enum ReasonsState {INIT , LOADING ,LOADED ,ERROR}
enum FetchTermsState {INIT , LOADING ,LOADED ,ERROR}
enum MarketsState {INIT , LOADING ,LOADED ,ERROR}
class HomeStates{
  static OrdersOnProccessState ordersOnProccessState = OrdersOnProccessState.INIT;
  static ReasonsState reasonsState = ReasonsState.INIT;
  static var fetchTermsState = FetchTermsState.INIT;
  static MarketsState marketsState = MarketsState.INIT;
}