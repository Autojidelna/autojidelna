import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:material_symbols_icons/symbols.dart';

class ErrorLoadingData extends ConsumerWidget {
  const ErrorLoadingData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return RefreshIndicator(
      onRefresh: ref.read(canteenProvider).refreshCurrentPage,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
              Icon(
                Symbols.sentiment_sad,
                size: 250,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.75,
                child: Text(
                  l10n.errorsLoadingData,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
            ],
          ),
        ),
      ),
    );
  }
}
