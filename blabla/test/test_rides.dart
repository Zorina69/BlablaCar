import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/rides_service.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void onTap() {
  return;
}

void main() {
  Location dijon = Location(country: Country.france, name: "Dijon");

  List<Ride> filteredRide = RidesService.filterBySeatRequested(2);
  List<Ride> filteredRide1 = RidesService.filterByDeparture(dijon);
  List<Ride> filteredRide2 = RidesService.filterBy(
    departure: Location(name: "dijon", country: Country.france),
    seatRequested: 2,
  );

  testWidgets('BlaButton tap test', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlaButton(
            color: ColorButton.primary,
            icon: Icons.history,
            title: 'Test',
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    // Tap the button
    await tester.tap(find.text('Test'));
    await tester.pump();

    // Verify
    expect(tapped, true);
  });

  for (Ride ride in filteredRide) {
    print(ride);
  }
  for (Ride ride in filteredRide1) {
    print(ride);
  }
  for (Ride ride in filteredRide2) {
    print(ride);
  }
}
