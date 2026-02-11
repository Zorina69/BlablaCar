import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/services/rides_service.dart';
import 'package:blabla/ui/screens/location_picker/location_picker_screen.dart';
import 'package:blabla/ui/screens/location_picker/seat_amount_screen.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/formTile.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:blabla/ui/widgets/inputs/datepicker.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).

enum SelectedColor { neutralDark, neutralLight }

class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;
  Location? location;
  bool searched = false;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  static const defautLocation = "Choose Your Location";
  static final defautDate = DateTime.now();
  static const defautRequestedSeats = 1;

  @override
  void initState() {
    super.initState();
    // TODO
    departure = Location(name: defautLocation, country: Country.france);
    departureDate = defautDate;
    arrival = Location(name: defautLocation, country: Country.france);
    requestedSeats = defautRequestedSeats;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void reverseLocation() {
    setState(() {
      location = departure;
      departure = arrival;
      arrival = location;
    });
  }

  Future<void> chooseDeparture() async {
    final Location? selected = await Navigator.push<Location>(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(selectedLocation: departure),
      ),
    );

    if (selected != null) {
      setState(() {
        departure = selected;
      });
    }
  }

  Future<void> chooseArrival() async {
    final Location? selected = await Navigator.push<Location>(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerScreen(selectedLocation: arrival),
      ),
    );

    if (selected != null) {
      setState(() {
        arrival = selected;
      });
    }
  }

  void chooseSeat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeatAmountScreen()),
    );
  }

  void search() {
    setState(() {
      searched = true;

      List<Ride> filteredRide = RidesService.filterBy(
        departure: departure,
        seatRequested: requestedSeats,
      );

      
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TileCard(
          icon: Icons.location_city,
          title: "$departure",
          trailingButton: Icons.thumbs_up_down_sharp,
          reverseLocation: reverseLocation,
          tapAction: chooseDeparture,
        ),
        TileCard(
          icon: Icons.location_city,
          title: "$arrival",
          tapAction: chooseArrival,
        ),
        DatePickerWidget(
          initialDate: departureDate,
          onDateSelected: (date) {
            setState(() {
              departureDate = date;
            });
          },
        ),
        TileCard(
          icon: Icons.person,
          title: "$requestedSeats",
          tapAction: chooseSeat,
        ),

        BlaButton(color: ColorButton.primary, onTap: search, title: "Search"),
        if (departure!.name == defautLocation &&
            arrival!.name == defautLocation &&
            searched == true)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Please Select the Location",
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
