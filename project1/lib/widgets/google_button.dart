import 'package:flutter/material.dart';

/// Tombol "Continue With Google" sesuai desain.
///
/// Login Google sungguhan membutuhkan konfigurasi/credential dan belum
/// termasuk target BAB 5-6, jadi tombol ini hanya memberi feedback SnackBar.
class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Continue With Google belum tersedia pada versi ini'),
          ),
        );
      },
      child: const Text('Continue With Google'),
    );
  }
}
