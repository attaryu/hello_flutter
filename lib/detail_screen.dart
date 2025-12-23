import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_flutter/models/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.all(10),
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
        title: Text(
          'Detail',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 10),
        actions: [FavoriteButton()],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // cover
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    place.imageAsset,
                    height: 210,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // title
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  place.name,
                  style: GoogleFonts.staatliches(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),

              // badges
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _badge(icon: Icons.access_time, text: place.openTime),
                    _badge(icon: Icons.calendar_today, text: place.openDays),
                    _badge(
                      icon: Icons.monetization_on,
                      text: place.ticketPrice,
                    ),
                  ],
                ),
              ),

              // description
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  place.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),

              // preview image
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                height: 150,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  children: place.imageUrls
                      .map((e) => _imagePreview(e))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _imagePreview(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child:
            RegExp(
              r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
            ).hasMatch(url)
            ? Image.network(url)
            : Image.asset(url),
      ),
    );
  }

  Column _badge({required IconData icon, required String text}) {
    return Column(
      children: [
        Icon(icon),
        SizedBox(height: 8),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => setState(() => isFavorited = !isFavorited),
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
        color: isFavorited ? Colors.red.shade600 : Colors.black,
      ),
    );
  }
}
