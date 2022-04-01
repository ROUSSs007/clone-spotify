import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/data/data.dart';
import 'package:flutter_spotify_ui/widgets/playlist_header.dart';
import 'package:flutter_spotify_ui/widgets/tracks_list.dart';

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;

  const PlaylistScreen({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  ScrollController? _scrollbarController;

  @override
  void initState() {
    super.initState();
    _scrollbarController = new ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollbarController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 140.0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_left, size: 28.0)),
              ),
              const SizedBox(width: 16.0),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_right, size: 28.0)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
                primary: Theme.of(context).iconTheme.color),
            onPressed: () {},
            icon: Icon(Icons.account_circle_outlined, size: 30.0),
            label: const Text('Rousselet'),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            padding: EdgeInsets.only(),
            onPressed: () {},
            icon: const Icon(Icons.keyboard_arrow_down, size: 30.0),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFAF1018),
              Theme.of(context).backgroundColor,
            ],
            stops: const [0, 0.3],
          ),
        ),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollbarController,
          child: ListView(
            controller: _scrollbarController,
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 60.0,
            ),
            children: [
              PlaylistHeader(playlist: widget.playlist),
              TracksList(tracks: widget.playlist.songs),
            ],
          ),
        ),
      ),
    );
  }
}
