import 'package:flutter/material.dart';

import 'culinaryModels.dart';
import 'login_page.dart';
import 'culinary_detail_page.dart';

class CulinaryListPage extends StatefulWidget {
  const CulinaryListPage({super.key});

  @override
  State<CulinaryListPage> createState() => _CulinaryListPageState();
}

class _CulinaryListPageState extends State<CulinaryListPage> {
  // List<String> _favoriteCulinary = [];

  @override
  void initState() {
    super.initState();
    // _loadFavorites();
  }

  // Future<void> _loadFavorites() async {
  //   final favs = await FavoriteService.getFavoriteCulinary();
  //   if (mounted) {
  //     setState(() {
  //       _favoriteCulinary = favs;
  //     });
  //   }
  // }

  void _onCulinaryTap(Culinary culinary) async {
    // Navigasi ke MovieDetailPage dan kirim data film yang dipilih
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CulinaryDetailPage(culinary: culinary),
      ),
    );

    // // Refresh status favorit saat kembali dari Movie Detail Page
    // _loadFavorites();
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Culinarizz Catalog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: culinaryList.length,
        itemBuilder: (context, index) {
          final culinary = culinaryList[index];
          // final isFavorite = _favoriteCulinary.contains(culinaryList.name);

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () => _onCulinaryTap(culinary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster Film
                  Stack(
                    children: [
                      SizedBox(
                        height: 220,
                        width: double.infinity,
                        child: Image.network(
                          culinary.imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey.shade900,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade800,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.movie_creation_outlined,
                                      size: 50,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Berasal ${culinary.origin}',
                                      style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Badge Favorite jika difavoritkan
                      // if (isFavorite)
                      //   Positioned(
                      //     top: 12,
                      //     right: 12,
                      //     child: Container(
                      //       padding: const EdgeInsets.all(6),
                      //       decoration: BoxDecoration(
                      //         color: Colors.black.withValues(alpha: 0.65),
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: const Icon(
                      //         Icons.favorite,
                      //         color: Colors.red,
                      //         size: 20,
                      //       ),
                      //     ),
                      //   ),
                      // Badge Rating
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${culinary.category}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Informasi Film: Judul, Genre, Tahun
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          culinary.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          culinary.origin,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 14,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${culinary.category}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
