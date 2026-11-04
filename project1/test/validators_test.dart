import 'package:flutter_test/flutter_test.dart';
import 'package:project1/utils/validators.dart';

void main() {
  group('Validators.name', () {
    test('kosong -> pesan error', () {
      expect(Validators.name(''), 'Nama tidak boleh kosong');
      expect(Validators.name(null), 'Nama tidak boleh kosong');
    });
    test('terlalu pendek -> pesan error', () {
      expect(Validators.name('An'), 'Nama minimal 3 karakter');
    });
    test('valid -> null', () {
      expect(Validators.name('Ani'), isNull);
    });
  });

  group('Validators.email', () {
    test('kosong dan tanpa @ ditolak', () {
      expect(Validators.email(''), 'Email tidak boleh kosong');
      expect(Validators.email('una.mail.com'), 'Format email belum sesuai');
    });
    test('valid -> null', () {
      expect(Validators.email('una@mail.com'), isNull);
    });
  });

  group('Validators.amount', () {
    test('kosong, bukan angka, dan nol ditolak', () {
      expect(Validators.amount(''), 'Nominal tidak boleh kosong');
      expect(
        Validators.amount('20.000'),
        'Nominal harus berupa angka (tanpa titik atau koma)',
      );
      expect(Validators.amount('0'), 'Nominal harus lebih dari 0');
    });
    test('valid -> null', () {
      expect(Validators.amount('20000'), isNull);
    });
  });

  group('Validators.uniqueName (BAB 7)', () {
    const existing = ['Food & Dining', 'Rent'];

    test('nama sudah ada ditolak tanpa membedakan huruf besar/kecil', () {
      expect(
        Validators.uniqueName('rent', existing: existing),
        'Nama kategori sudah ada',
      );
      expect(
        Validators.uniqueName('  FOOD & dining ', existing: existing),
        'Nama kategori sudah ada',
      );
    });
    test('aturan dasar tetap berlaku', () {
      expect(
        Validators.uniqueName('', existing: existing),
        'Nama kategori tidak boleh kosong',
      );
      expect(
        Validators.uniqueName('ab', existing: existing),
        'Nama kategori minimal 3 karakter',
      );
    });
    test('nama baru valid -> null', () {
      expect(Validators.uniqueName('Hiburan', existing: existing), isNull);
    });
  });

  group('Validators.category', () {
    test('wajib dipilih', () {
      expect(Validators.category(null), 'Kategori wajib dipilih');
      expect(Validators.category('Rent'), isNull);
    });
  });
}
