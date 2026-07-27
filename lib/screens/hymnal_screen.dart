import 'package:flutter/material.dart';
import '../services/hymnal_service.dart';
import '../models/hymn.dart';

class HymnalScreen extends StatefulWidget {
  const HymnalScreen({Key? key}) : super(key: key);

  @override
  State<HymnalScreen> createState() => _HymnalScreenState();
}

class _HymnalScreenState extends State<HymnalScreen> {
  final HymnalService _hymnalService = HymnalService();
  final TextEditingController _searchController = TextEditingController();
  List<Hymn> _hymns = [];
  List<Hymn> _filteredHymns = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHymns();
  }

  void _loadHymns() async {
    final hymns = await _hymnalService.getAllHymns();
    setState(() {
      _hymns = hymns;
      _filteredHymns = hymns;
      _isLoading = false;
    });
  }

  void _filterHymns(String query) async {
    if (query.isEmpty) {
      setState(() {
        _filteredHymns = _hymns;
      });
    } else {
      final results = await _hymnalService.searchHymns(query);
      setState(() {
        _filteredHymns = results;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SDA Hymnal',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search hymns...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterHymns('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: _filterHymns,
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredHymns.isEmpty
                    ? Center(
                        child: Text(
                          _searchController.text.isEmpty
                              ? 'Loading hymns...'
                              : 'No hymns found',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredHymns.length,
                        itemBuilder: (context, index) {
                          final hymn = _filteredHymns[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: ListTile(
                              title: Text(
                                '${hymn.number} - ${hymn.title}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(hymn.author),
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () {
                                _showHymnDetails(hymn);
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _showHymnDetails(Hymn hymn) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hymn.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'by ${hymn.author}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            Text(
              hymn.lyrics,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
