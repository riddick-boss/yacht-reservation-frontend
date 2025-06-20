// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:yacht_reservation_frontend/domain/models/faq.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final faqs = [
      const FAQ(
        question: 'How do I make a yacht reservation?',
        answer:
            'To make a reservation, navigate to the Yachts page, select your desired yacht, choose a date, and confirm your booking. You can also use the quick booking feature from the home page.',
      ),
      const FAQ(
        question: 'Can I cancel my reservation?',
        answer:
            'Yes, you can cancel your reservation up to 24 hours before the scheduled date. Go to the Reservations page, find your booking, and tap the cancel button.',
      ),
      const FAQ(
        question: 'What is included in the yacht rental?',
        answer:
            'Your yacht rental includes the vessel, professional crew, safety equipment, and basic amenities. Additional services like catering or water sports equipment can be arranged separately.',
      ),
      const FAQ(
        question: 'What should I bring for my yacht trip?',
        answer:
            'We recommend bringing comfortable clothing, swimwear, sunscreen, and any personal items you may need. The yacht will provide towels and basic amenities.',
      ),
      const FAQ(
        question: 'Are there any age restrictions?',
        answer:
            'Children of all ages are welcome, but those under 18 must be accompanied by an adult. Some activities may have age restrictions for safety reasons.',
      ),
      const FAQ(
        question: 'What happens if the weather is bad?',
        answer:
            'If weather conditions are unsafe, we will reschedule your trip at no additional cost. We monitor weather conditions closely and will contact you if changes are needed.',
      ),
      const FAQ(
        question: 'How far in advance should I book?',
        answer:
            'We recommend booking at least 1-2 weeks in advance, especially during peak season. For special events or large groups, booking 1-2 months ahead is advisable.',
      ),
      const FAQ(
        question: 'Do you offer group discounts?',
        answer:
            'Yes, we offer special rates for groups of 6 or more people. Contact our support team for group booking inquiries and pricing.',
      ),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Support & FAQ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.primaryColor.withOpacity(0.1),
                  theme.primaryColor.withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.support_agent,
                    size: 48,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'How can we help you?',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Find answers to frequently asked questions about yacht reservations',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // FAQ list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                final faq = faqs[index];
                return _FAQCard(faq: faq, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FAQCard extends StatefulWidget {
  final FAQ faq;
  final int index;
  const _FAQCard({required this.faq, required this.index});

  @override
  State<_FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<_FAQCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade50],
            ),
          ),
          child: ExpansionTile(
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${widget.index + 1}',
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            title: Text(
              widget.faq.question,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.textTheme.titleMedium?.color?.withOpacity(0.9),
              ),
            ),
            trailing: AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: theme.primaryColor,
                size: 24,
              ),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: theme.primaryColor.withOpacity(0.1),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.faq.answer,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(
                          0.8,
                        ),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
