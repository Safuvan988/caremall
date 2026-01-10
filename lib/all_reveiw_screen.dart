import 'package:flutter/material.dart';

class AllReviewsScreen extends StatelessWidget {
  final Map<String, String> productData;

  const AllReviewsScreen({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    final String assetPath = productData["image"]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "All Reviews",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRatingHeader(),
              const SizedBox(height: 24),
              const Text(
                "Photos from Customers",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              _buildPhotoGallery(assetPath),
              const SizedBox(height: 24),
              _buildDetailedReview(
                name: "Alex Morgan",
                rating: 4.0,
                date: "12 days ago",
                comment:
                    "The fabric is incredibly soft and the design is both stylish and functional.",
              ),
              const Divider(height: 40),
              _buildDetailedReview(
                name: "Ankit Sharma",
                rating: 5.0,
                date: "12 March 2025",
                comment:
                    "I'm genuinely impressed! The exceptional fabric quality and stylish design make it suitable for various occasions.",
                imagePaths: [assetPath, assetPath],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: const [
            Text(
              "4.8",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Text("Avg Rating", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Text(
              "124 Ratings | 21 Reviews",
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            children: [
              _ratingBar("5.0", 0.8, "84"),
              _ratingBar("4.0", 0.4, "40"),
              _ratingBar("3.0", 0.0, "00"),
              _ratingBar("2.0", 0.0, "00"),
              _ratingBar("1.0", 0.0, "00"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ratingBar(String label, double progress, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.star, size: 10, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: Colors.red,
              minHeight: 4,
            ),
          ),
          const SizedBox(width: 8),
          Text(count, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPhotoGallery(String imgPath) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder:
            (context, index) => Container(
              margin: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imgPath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildDetailedReview({
    required String name,
    required double rating,
    required String date,
    required String comment,
    List<String>? imagePaths,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 18, child: Icon(Icons.person)),
            const SizedBox(width: 12),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(
              rating.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.star, color: Colors.orange, size: 16),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          comment,
          style: const TextStyle(color: Colors.black87, height: 1.4),
        ),
        if (imagePaths != null) ...[
          const SizedBox(height: 12),
          Row(
            children:
                imagePaths
                    .map(
                      (path) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            path,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image),
                                ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              date,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const Spacer(),
            const Icon(Icons.thumb_up_outlined, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            const Text("10", style: TextStyle(color: Colors.grey)),
            const SizedBox(width: 12),
            const Icon(Icons.thumb_down_outlined, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            const Text("2", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
