import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_flutter/models/tourism_place.dart';
import 'package:hello_flutter/widgets/favorite_button.dart';

class DetailScreen extends StatefulWidget {
  final TourismPlace place;

  const DetailScreen({super.key, required this.place});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 750) {
          return _detailMobileScreen(context);
        }

        return _detailWebScreen(context);
      },
    );
  }

  Scaffold _detailWebScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Container(
          width: 1000,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.all(10),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                  ),

                  Text(
                    'Wisata Bandung',
                    style: GoogleFonts.staatliches(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            widget.place.imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Scrollbar(
                          controller: _scrollController,
                          child: SizedBox(
                            height: 120,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  _imagePreview(widget.place.imageUrls[index]),
                              itemCount: widget.place.imageUrls.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            widget.place.name,
                            style: GoogleFonts.staatliches(
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _badge(
                                      icon: Icons.calendar_today,
                                      text: widget.place.openDays,
                                      rowMode: true,
                                    ),
                                    SizedBox(height: 8),
                                    _badge(
                                      icon: Icons.access_time,
                                      text: widget.place.openTime,
                                      rowMode: true,
                                    ),
                                    SizedBox(height: 8),
                                    _badge(
                                      icon: Icons.monetization_on,
                                      text: widget.place.ticketPrice,
                                      rowMode: true,
                                    ),
                                  ],
                                ),
                                FavoriteButton(),
                              ],
                            ),
                          ),

                          Text(
                            widget.place.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold _detailMobileScreen(BuildContext context) {
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
                    widget.place.imageAsset,
                    height: 210,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // title
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  widget.place.name,
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
                    _badge(
                      icon: Icons.access_time,
                      text: widget.place.openTime,
                    ),
                    _badge(
                      icon: Icons.calendar_today,
                      text: widget.place.openDays,
                    ),
                    _badge(
                      icon: Icons.monetization_on,
                      text: widget.place.ticketPrice,
                    ),
                  ],
                ),
              ),

              // description
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  widget.place.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),

              // preview image
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                height: 150,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.place.imageUrls.length,
                  itemBuilder: (context, index) =>
                      _imagePreview(widget.place.imageUrls[index]),
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect _imagePreview(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child:
          RegExp(
            r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
          ).hasMatch(url)
          ? Image.network(url)
          : Image.asset(url),
    );
  }

  Flex _badge({
    required IconData icon,
    required String text,
    bool rowMode = false,
  }) {
    if (rowMode) {
      return Row(
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 12)),
        ],
      );
    }

    return Column(
      children: [
        Icon(icon),
        SizedBox(height: 8),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
