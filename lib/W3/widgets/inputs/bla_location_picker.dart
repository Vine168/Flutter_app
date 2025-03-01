import 'package:flutter/material.dart';
import 'package:flutter_app/W3/model/ride/locations.dart';
import '../../service/locations_service.dart';
import '../../theme/theme.dart';

/// This full-screen modal is in charge of providing (if confirmed) a selected location.
class BlaLocationPicker extends StatefulWidget {
  final Location? initLocation;
  const BlaLocationPicker({super.key, this.initLocation});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}
class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    if (widget.initLocation != null) {
      filteredLocations = _getLocationsFor(widget.initLocation!.name);
    }
  }
  void _onBackSelected() {
    Navigator.of(context).pop();
  }

  void _onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }

  void _onSearchChanged(String searchText) {
    if (searchText.length > 1) {
      setState(() {
        filteredLocations = _getLocationsFor(searchText);
      });
    } else {
      setState(() {
        filteredLocations = [];
      });
    }
  }
  List<Location> _getLocationsFor(String text) {
    return LocationsService.availableLocations
        .where((location) => location.name.toUpperCase().contains(text.toUpperCase()))
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m, vertical: BlaSpacings.s),
        child: Column(
          children: [
            // Top search bar
            BlaSearchBar(
              onBackPressed: _onBackSelected,
              onSearchChanged: _onSearchChanged,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (ctx, index) => LocationTile(
                  location: filteredLocations[index],
                  onSelected: _onLocationSelected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// Represents an item in the list of locations.
class LocationTile extends StatelessWidget {
  final Location location;
  final Function(Location location) onSelected;

  const LocationTile({super.key, required this.location, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(location.name, style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)),
      subtitle: Text(location.country.name, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
      trailing: Icon(Icons.arrow_forward_ios, color: BlaColors.iconLight, size: 16),
    );
  }
}
/// Combines the search input and the navigation back button.
/// A clear button appears when the search contains some text.
/// change structure

class BlaSearchBar extends StatefulWidget {
  final Function(String text) onSearchChanged;
  final VoidCallback onBackPressed;

  const BlaSearchBar({super.key, required this.onSearchChanged, required this.onBackPressed});
  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController _controller = TextEditingController();

  bool get _searchIsNotEmpty => _controller.text.isNotEmpty;

  void _onChanged(String newText) {
    widget.onSearchChanged(newText);
    setState(() {});
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: widget.onBackPressed,
            icon: Icon(Icons.arrow_back_ios, color: BlaColors.iconLight, size: 16),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onChanged,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none,
              ),
            ),
          ),
          _searchIsNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, color: BlaColors.iconLight),
                  onPressed: () {
                    _controller.clear();
                    _onChanged("");
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}