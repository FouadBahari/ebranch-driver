enum CountriesState {INIT , LOADING , LOADED , ERROR}
enum CitiesState {INIT , LOADING , LOADED , ERROR}
enum RegisterState {INIT , LOADING , LOADED , ERROR}
class States {
  static CountriesState countriesState = CountriesState.INIT;
  static CitiesState citiesState = CitiesState.INIT;
  static RegisterState registerState = RegisterState.INIT;
}