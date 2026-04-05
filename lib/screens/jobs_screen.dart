import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = [
    'All',
    'Remote',
    'Freelance',
    'Contract',
    'Full-time'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs Marketplace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategory == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(_categories[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = index;
                      });
                    },
                    backgroundColor: AppTheme.surfaceColor,
                    selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppTheme.primaryColor
                          : AppTheme.textSecondary,
                    ),
                    checkmarkColor: AppTheme.primaryColor,
                  ),
                );
              },
            ),
          ),
          // Stats Row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard('Available', '124 jobs', Icons.work),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('My Applications', '8', Icons.description),
                ),
              ],
            ),
          ),
          // Jobs List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildJobCard(
                  'Senior Flutter Developer',
                  'Remote • \$80-120/hr',
                  'Looking for experienced Flutter developer for mobile app project...',
                  'Posted 2h ago',
                  true,
                ),
                _buildJobCard(
                  'P2P Network Engineer',
                  'Full-time • \$100-150k',
                  'Build decentralized mesh networking solutions...',
                  'Posted 5h ago',
                  true,
                ),
                _buildJobCard(
                  'Security Analyst',
                  'Contract • \$60-80/hr',
                  'Audit and enhance security protocols...',
                  'Posted 1d ago',
                  false,
                ),
                _buildJobCard(
                  'UI/UX Designer',
                  'Freelance • \$50-75/hr',
                  'Design engaging game interfaces...',
                  'Posted 2d ago',
                  true,
                ),
                _buildJobCard(
                  'Blockchain Developer',
                  'Remote • \$90-130/hr',
                  'Implement crypto wallet features...',
                  'Posted 3d ago',
                  true,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showPostJobDialog(context);
        },
        backgroundColor: AppTheme.primaryColor,
        icon: const Icon(Icons.add, color: AppTheme.backgroundColor),
        label: const Text(
          'Post Job',
          style: TextStyle(color: AppTheme.backgroundColor),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(
    String title,
    String salary,
    String description,
    String posted,
    bool active,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? AppTheme.successColor.withOpacity(0.2)
                        : AppTheme.warningColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    active ? 'Active' : 'Urgent',
                    style: TextStyle(
                      color: active
                          ? AppTheme.successColor
                          : AppTheme.warningColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              salary,
              style: const TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  posted,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                        side: const BorderSide(color: AppTheme.primaryColor),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text('Apply'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPostJobDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Post a Job',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Job Title',
                    hintText: 'e.g., Flutter Developer',
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Describe the job...',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: const TextField(
                        decoration: InputDecoration(
                          labelText: 'Budget',
                          hintText: '\$50-100/hr',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Type',
                        ),
                        items: const [
                          DropdownMenuItem(value: 'remote', child: Text('Remote')),
                          DropdownMenuItem(value: 'freelance', child: Text('Freelance')),
                          DropdownMenuItem(value: 'contract', child: Text('Contract')),
                          DropdownMenuItem(value: 'fulltime', child: Text('Full-time')),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Job posted! (3% fee applies)'),
                        ),
                      );
                    },
                    child: const Text('Post Job'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}