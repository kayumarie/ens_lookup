import 'package:ens_lookup/ens_lookup.dart';
import 'package:ens_lookup/src/model/errors.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:web3dart/web3dart.dart';

void main() {
  group('Test ENS lookup', () {
    late EnsLookup ensService;

    setUp(() {
      final client = Client();

      ensService = EnsLookup.create(Web3Client(
        'https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161',
        client,
      ));
    });

    test('Given valid ENS name, find correct address', () async {
      final names = [
        'ricmoo.firefly.eth',
        '💎🙌🦍🚀🌑.eth',
        'haha.',
        'lol',
      ];

      final addresses = [
        '0x8ba1f109551bD432803012645Ac136ddd64DBA72',
        '0x513a76F5C1f503803DE5B2893F428B3dB86d69CD',
        null,
        null,
      ];

      int i = 0;
      for (final name in names) {
        final address = await ensService.resolveName(name);
        expect(address, addresses[i]);

        i++;
      }
    });

    test('Given valid ens name when ens entry does not exist then return null', () async {
      final names = [
        'not-found-fldnflqwkfvaoksdjvasjdvkanjvlkj.fldnflqwkfvaoksdjvasjdvkanjvlkj',
        'haha.',
        'lol',
      ];

      for (final name in names) {
        final address = await ensService.resolveName(name);
        expect(address, null);
      }
    });

    test('Given invalid ens then return an error', () async {
      final names = [
        "%%\$\$33",
        '.eth',
      ];

      for (final name in names) {
        ensService.resolveName(name).catchError((error) {
          expect(error, isA<InvalidEnsName>());
          return null;
        });
      }
    });
  });
}
