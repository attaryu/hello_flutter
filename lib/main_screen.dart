import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_flutter/detail_screen.dart';
import 'package:hello_flutter/models/tourism_place.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<TourismPlace> tourismPlaces = TourismPlace.get();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wisata Bandung',
          style: GoogleFonts.staatliches(fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(14),
        itemCount: tourismPlaces.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) =>
            _placeCard(context, tourismPlaces[index]),
      ),
    );
  }

  InkWell _placeCard(BuildContext context, TourismPlace tourismPlace) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(place: tourismPlace),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                tourismPlace.imageAsset,
                height: 80,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tourismPlace.name,
                    style: GoogleFonts.staatliches(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    tourismPlace.location,
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
  }
}
