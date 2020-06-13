import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:selector/src/models/country.dart';




class CountryService with ChangeNotifier {

  final String _countryUrl = 'https://restcountries.eu/rest/v2';

  String _selectedLang    = 'en';
  Country _selectedCountry = new Country();
  List<String> languages = ['es','en'];

  List<Country> activeCountries = [];
  

  CountryService(){
    this.selectedCountry.alpha2Code = '';
    this._getCountriesByLang( this._selectedLang );
  }

  get selectedLang {
    return this._selectedLang;
  }

  set selectedLang( String value ){
    this._selectedLang = value;
    this._getCountriesByLang(value);
  }

  Country get selectedCountry {
    return this._selectedCountry;
  }

  set selectedCountry( Country value ) {
    this._selectedCountry = value;
  }

  void setActiveCountry( String alphaCode2 ) {
    this._selectedCountry = activeCountries.firstWhere(( country ) => country.alpha2Code == alphaCode2 );
    notifyListeners();
  }

  void _getCountriesByLang( String lang ) async {

    final url = '$_countryUrl/lang/$lang';

    final resp = await http.get(url);

    if ( resp.statusCode == 200 ) {
      final countries = countryFromJson( resp.body );
      activeCountries = countries;
      this._selectedCountry = countries[0];
      notifyListeners();
    }

  }

}


