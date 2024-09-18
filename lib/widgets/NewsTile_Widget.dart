import 'package:flutter/material.dart';
import 'package:reel_news/utility/storage_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Newstile extends StatefulWidget {
  final String? imageUrl, title, desc, source, url, content; // Nullable fields

  Newstile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.source,
    required this.url,
    required this.content,
  });

  @override
  _NewstileState createState() => _NewstileState();
}

class _NewstileState extends State<Newstile> {
  bool _isArchived = false;

  @override
  void initState() {
    super.initState();
    _checkIfArchived();
  }

  // Function to check if the article is archived
  Future<void> _checkIfArchived() async {
    bool isArchived = await StorageService().isArticleArchived(widget.url ?? '');
    setState(() {
      _isArchived = isArchived;
    });
  }

  // Function to launch URL
  Future<void> _launchUrl(String? url) async {
    if (url == null || url.isEmpty) return;
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      print('Could not launch $url');
    }
  }

  // Function to archive an article
  void archiveArticle() async {
    await StorageService().archiveArticle(
      widget.title ?? 'No title',
      widget.url ?? '',
      widget.imageUrl ?? '',
    );
    print('Article archived: ${widget.title}');
    setState(() {
      _isArchived = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(widget.url), // Make the entire tile clickable
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 131, 131, 131),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Show image only if the imageUrl is not null or empty
                if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      widget.imageUrl!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.grey,
                          child: Center(
                            child: Icon(Icons.image, size: 50, color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center, // Center headline if no image
                    children: [
                      Center(
                        child: Text(
                          widget.title ?? 'No title available',
                          style: TextStyle(
                            fontSize: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                                ? 20
                                : 22, // Make it larger when no image
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center, // Center text
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                        SizedBox(height: 6),
                      // Only show description if there is an image
                      if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                        Text(
                          widget.desc ?? 'No description available',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.source != null && widget.source!.isNotEmpty)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    widget.source!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            // Checkmark icon when article is archived
            if (_isArchived)
              Positioned(
                top: 8,
                right: 8, // Move archive icon to the top-right
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Icon(Icons.check, color: Colors.white, size: 30),
                ),
              )
            else
              Positioned(
                top: 8,
                right: 8, // Move archive icon to the top-right
                child: InkWell(
                  // Archive the article on tap
                  onTap: archiveArticle,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    child: Icon(Icons.archive, color: Colors.white, size: 30),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
