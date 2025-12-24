import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_flutter/detail_screen.dart';
import 'package:hello_flutter/models/tourism_place.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<TourismPlace> tourismPlaces = TourismPlace.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wisata Bandung',
          style: GoogleFonts.staatliches(fontWeight: FontWeight.w500),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth <= 750
            ? _tourismPlaceList()
            : _tourismPlaceGrid(constraints.maxWidth <= 900 ? 4 : 5),
      ),
    );
  }

  GridView _tourismPlaceGrid(int gridCount) {
    return GridView.builder(
      padding: EdgeInsets.all(14),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: tourismPlaces.length,
      itemBuilder: (context, index) {
        TourismPlace place = tourismPlaces[index];

        return InkWell(
          onTap: () => goTo(context, place),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(place.imageAsset, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.staatliches(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      place.location,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withValues(alpha: 0.8),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ListView _tourismPlaceList() {
    return ListView.separated(
      padding: EdgeInsets.all(14),
      itemCount: tourismPlaces.length,
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemBuilder: (context, index) {
        TourismPlace place = tourismPlaces[index];

        return InkWell(
          onTap: () => goTo(context, place),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    place.imageAsset,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        place.name,
                        style: GoogleFonts.staatliches(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        place.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void goTo(BuildContext context, TourismPlace place) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(place: place)),
    );
  }
}
