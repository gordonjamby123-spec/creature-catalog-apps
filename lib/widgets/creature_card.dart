import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalogsforcreatureapps/models/creature.dart';

class CreatureCard extends StatelessWidget {
  final Creature creature;
  final VoidCallback onTap;

  const CreatureCard({
    super.key,
    required this.creature,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          creature.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildRarityIcon(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    creature.species,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoChips(),
                  const SizedBox(height: 12),
                  Text(
                    creature.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: creature.imageUrl != null
          ? CachedNetworkImage(
        imageUrl: creature.imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      )
          : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(
          Icons.pets,
          size: 60,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildRarityIcon() {
    Color color;
    IconData icon;

    switch (creature.rarity) {
      case 'legendary':
        color = Colors.deepPurple;
        icon = Icons.auto_awesome;
        break;
      case 'rare':
        color = Colors.blue;
        icon = Icons.star;
        break;
      case 'uncommon':
        color = Colors.green;
        icon = Icons.star_half;
        break;
      default:
        color = Colors.grey;
        icon = Icons.star_border;
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }

  Widget _buildInfoChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildChip(
          Icons.landscape,
          creature.habitat,
          Colors.teal,
        ),
        if (creature.isDangerous)
          _buildChip(
            Icons.warning,
            'Dangerous',
            Colors.red,
          ),
        if (creature.discoveredBy != null)
          _buildChip(
            Icons.person,
            creature.discoveredBy!,
            Colors.blueGrey,
          ),
      ],
    );
  }

  Widget _buildChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}