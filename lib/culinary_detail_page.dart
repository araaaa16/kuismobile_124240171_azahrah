import 'package:flutter/material.dart';

import 'culinaryModels.dart';

class CulinaryDetailPage extends StatefulWidget {
  final Culinary culinary;

  const CulinaryDetailPage({super.key, required this.culinary});

  @override
  State<CulinaryDetailPage> createState() => _CulinaryDetailPageState();
}

class _CulinaryDetailPageState extends State<CulinaryDetailPage> {
  @override
  Widget build(BuildContext context) {
    // final bool isFav = widget.favoriteManager.isFavorite(widget.culinary.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.culinary.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          // IconButton(
          //   tooltip: isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
          //   icon: Icon(
          //     isFav ? Icons.favorite : Icons.favorite_border,
          //     color: isFav ? Colors.red : null,
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       widget.favoriteManager.toggleFavorite(widget.culinary.name);
          //     });
          //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text(
          //           isFav
          //               ? 'Dihapus dari daftar favorit'
          //               : 'Ditambahkan ke daftar favorit',
          //         ),
          //         duration: const Duration(seconds: 1),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Buku
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      height: 280,
                      width: 190,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 117, 117),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Image.network(
                        widget.culinary.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.indigo.shade50,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  size: 56,
                                  color: Colors.indigo.shade300,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  widget.culinary.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.culinary.origin,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.indigo.shade700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  widget.culinary.name,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),

                Text(
                  'Berasal ${widget.culinary.origin}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildInfoChip(
                      icon: Icons.title,
                      label: widget.culinary.name,
                      color: Colors.blue.shade50,
                      textColor: Colors.blue.shade800,
                    ),
                    _buildInfoChip(
                      icon: Icons.place,
                      label: '${widget.culinary.origin}',
                      color: Colors.green.shade50,
                      textColor: Colors.green.shade800,
                    ),
                    _buildInfoChip(
                      icon: Icons.category,
                      label: '${widget.culinary.category} ',
                      color: Colors.purple.shade50,
                      textColor: Colors.purple.shade800,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                const Divider(),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.business, size: 20, color: Colors.grey),
                    const SizedBox(width: 8),
                    const Text(
                      'Berasal ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        widget.culinary.origin,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  'Deskripsi',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.culinary.description,
                    style: const TextStyle(fontSize: 14.5, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor ?? textColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
