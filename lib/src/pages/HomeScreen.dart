import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:selector/src/models/country.dart';
import 'package:selector/src/services/country_service.dart';


class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Countries'),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Selectores(),


          ],
        )
      )

      // body: ,

    );
  }
}

class Selectores extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final countryService = Provider.of<CountryService>(context);
    final langs = countryService.languages;
    final countries = countryService.activeCountries;
    final selectedCountry = countryService.selectedCountry;


    return Expanded(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DropdownButton<String>(
            value: countryService.selectedLang,
            items: langs.map( (e) => DropdownMenuItem<String>(child: Text(e.toUpperCase()), value: e )).toList(), 
            onChanged: (String value) {
              countryService.selectedLang = value;
            },
          ),

          DropdownButton<String>(
            isExpanded: true,
            value: selectedCountry.alpha2Code,
            items: countries.map( (e) => DropdownMenuItem<String>(
              child: Text( e.name, overflow: TextOverflow.ellipsis, ), value: e.alpha2Code )
            ).toList(), 
            onChanged: (String value) {
              countryService.setActiveCountry( value );
            },
          ),

          // MostrarBandera( url: countryService.selectedCountry.flag ),

          DisplayCountry()


        ],
      ),
    );
  }
}

class DisplayCountry extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    Country country = Provider.of<CountryService>(context).selectedCountry;

    if( country.name == null ) {
      return CircularProgressIndicator();
    }

    return Expanded(
      child: ListView(
        children: <Widget>[
        
          ListTile( title: Text( 'Name' ), trailing: Text( country.name ), ),
          Divider(),
          ListTile( title: Text( 'Population' ), trailing: Text( country.population.toString() ), ),
          Divider(),
          ListTile( title: Text( 'Area' ), trailing: Text( country.area.toString() ), ),


        ],
      ),
    );
  }
}

class MostrarBandera extends StatelessWidget {
  
  final String url;

  const MostrarBandera({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print( this.url );

    if ( this.url == null ) {
      return Container();
    }

    // return Container();
    try {
      return Container(
        height: 250,
        width: 500,
        child: SvgPicture.network(
            this.url,
            width: 500,
            height: 250,
            alignment: Alignment.center,
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator()),
          ),
      );  
    } catch (e) {
      return Placeholder(
        fallbackHeight: 250,
        fallbackWidth: double.infinity,
      );
    }
    
  }
}