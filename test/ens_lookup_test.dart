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

    test('Given valid ens name when ens entry exists then return address', () async {
      final address = await ensService.resolveName('ricmoo.firefly.eth');
      expect(address, '0x8ba1f109551bD432803012645Ac136ddd64DBA72');
    });

    test('Given valid ens name when ens entry does not exist then return null', () async {
      final address = await ensService.resolveName('not-found-fldnflqwkfvaoksdjvasjdvkanjvlkj.fldnflqwkfvaoksdjvasjdvkanjvlkj');
      expect(address, null);
    });

    test('Given invalid ens then return an error', () async {
      ensService.resolveName("%%\$\$33").catchError((error) {
        expect(error, isA<InvalidEnsName>());
      });
    });
  });
}
